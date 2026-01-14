//
//  CloudKitManager.swift
//  CloudKitAiExample
//
//  A tiny, heavily commented helper that demonstrates the minimum calls
//  needed to save and fetch records with CloudKit's private database.
//  This code compiles even before you turn on the CloudKit capability,
//  but real network calls will only succeed after you enable it in
//  Signing & Capabilities and create a CloudKit schema in the dashboard.
//

import Foundation
import CloudKit
import Combine

/// Simple value type to bridge CKRecord data into SwiftUI-friendly objects.
struct CKNote: Identifiable {
    let id: CKRecord.ID
    var title: String
    var body: String
    var modified: Date
}

@MainActor
final class CloudKitManager: ObservableObject {
    @Published var notes: [CKNote] = []
    @Published var statusMessage: String = "Ready"
    @Published var lastError: String?

    private let container = CKContainer.default() // Uses the app's iCloud container from capabilities.
    private var privateDB: CKDatabase { container.privateCloudDatabase }

    /// Checks iCloud account status so we can surface helpful guidance in UI.
    func checkAccountStatus() async {
        do {
            let status = try await container.accountStatus()
            switch status {
            case .available:
                statusMessage = "iCloud available ✔︎"
            case .noAccount:
                statusMessage = "Sign into iCloud in Settings to use CloudKit."
            case .restricted:
                statusMessage = "CloudKit restricted on this device."
            case .couldNotDetermine:
                statusMessage = "Could not determine iCloud status. Try again."
            case .temporarilyUnavailable:
                statusMessage = "CloudKit is temporarily unavailable."
            @unknown default:
                statusMessage = "Unknown iCloud status."
            }
        } catch {
            lastError = "Account status error: \(error.localizedDescription)"
        }
    }

    /// Creates and saves a very small CKRecord in the private database.
    /// - Record type: "Note" (you must create this type in CloudKit Dashboard
    ///   or run in development schema).
    func saveSampleNote() async {
        let record = CKRecord(recordType: "Note")
        record["title"] = "Hello CloudKit" as NSString
        record["body"] = "Saved from the sample app at \(Date())" as NSString

        do {
            _ = try await privateDB.save(record)
            statusMessage = "Saved new Note record."
            // Refresh list so UI reflects the newly saved item.
            await fetchNotes()
        } catch {
            lastError = "Save failed: \(error.localizedDescription)"
        }
    }

    /// Fetches up to 20 "Note" records from the private database.
    func fetchNotes() async {
        let query = CKQuery(recordType: "Note", predicate: NSPredicate(value: true))

        do {
            // Modern async API available on iOS 17+. Results come back as
            // an AsyncSequence of match results we can iterate.
            let (results, _) = try await privateDB.records(
                matching: query,
                desiredKeys: ["title", "body"],
                resultsLimit: 20
            )

            var fetched: [CKNote] = []
            for (_, result) in results {
                switch result {
                case .success(let record):
                    let note = CKNote(
                        id: record.recordID,
                        title: record["title"] as? String ?? "(Untitled)",
                        body: record["body"] as? String ?? "",
                        modified: record.modificationDate ?? Date()
                    )
                    fetched.append(note)
                case .failure(let error):
                    // Capture the first error but keep looping to show partial data.
                    lastError = "Fetch partial failure: \(error.localizedDescription)"
                }
            }

            notes = fetched.sorted { $0.modified > $1.modified }
            statusMessage = "Fetched \(notes.count) record(s)."
        } catch {
            lastError = "Query failed: \(error.localizedDescription)"
        }
    }
}

