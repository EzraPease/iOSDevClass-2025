//
//  ContentView.swift
//  CloudKitAiExample
//
//  Created by Ezra Pease on 1/14/26.
//

import SwiftUI
import CloudKit

struct ContentView: View {
    @StateObject private var cloudKit = CloudKitManager()
    @State private var isWorking = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    hero
                    setupSteps
                    sampleButtons
                    notesList
                    codeWalkthrough
                    troubleshooting
                }
                .padding()
            }
            .navigationTitle("CloudKit Primer")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task { await cloudKit.checkAccountStatus() }
                    } label: {
                        Label("Check iCloud", systemImage: "icloud")
                    }
                    .disabled(isWorking)
                }
            }
        }
        .task {
            // Initial status + fetch when the view appears.
            await cloudKit.checkAccountStatus()
            await cloudKit.fetchNotes()
        }
    }

    private var hero: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Learn CloudKit")
                .font(.largeTitle.bold())
            Text("This screen walks through enabling CloudKit, then shows the minimal code to save and fetch a record from your private database.")
                .foregroundStyle(.secondary)
        }
    }

    private var setupSteps: some View {
        VStack(alignment: .leading, spacing: 8) {
            sectionHeader("1) Enable CloudKit")
            stepRow(number: "1", text: "Open Xcode → Targets → Signing & Capabilities.")
            stepRow(number: "2", text: "Add the CloudKit capability. Xcode creates the iCloud container.")
            stepRow(number: "3", text: "Run on a device signed into iCloud. (Sim works if signed in.)")
            stepRow(number: "4", text: "In CloudKit Dashboard, create a Record Type named “Note” with String fields “title” and “body”. In development, the first save can also auto-create the schema.")
            statusBubble
        }
    }

    private var sampleButtons: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("2) Try it")
            HStack {
                Button {
                    isWorking = true
                    Task {
                        await cloudKit.saveSampleNote()
                        isWorking = false
                    }
                } label: {
                    Label("Save sample note", systemImage: "square.and.arrow.down")
                }
                .buttonStyle(.borderedProminent)
                .disabled(isWorking)

                Button {
                    isWorking = true
                    Task {
                        await cloudKit.fetchNotes()
                        isWorking = false
                    }
                } label: {
                    Label("Fetch notes", systemImage: "arrow.clockwise")
                }
                .buttonStyle(.bordered)
                .disabled(isWorking)
            }

            if isWorking {
                ProgressView("Talking to CloudKit…")
            }

            if let error = cloudKit.lastError {
                Label(error, systemImage: "exclamationmark.triangle")
                    .foregroundStyle(.orange)
                    .font(.footnote)
            }
        }
    }

    private var notesList: some View {
        VStack(alignment: .leading, spacing: 8) {
            sectionHeader("3) Data returned")
            if cloudKit.notes.isEmpty {
                Text("No records yet. Save one, then fetch.")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(cloudKit.notes) { note in
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(note.title).bold()
                            Spacer()
                            Text(note.modified, format: .dateTime.hour().minute())
                                .foregroundStyle(.secondary)
                                .font(.caption)
                        }
                        Text(note.body)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
            }
        }
    }

    private var codeWalkthrough: some View {
        VStack(alignment: .leading, spacing: 8) {
            sectionHeader("4) Minimal code")
            Text("CloudKitManager.swift shows the exact calls: create a record, save, query. Key bits are pasted below for quick reference.")
                .foregroundStyle(.secondary)

            // Inline code excerpts so beginners can read without leaving the screen.
            Group {
                codeBlock(title: "Save a record",
                          """
                let record = CKRecord(recordType: "Note")
                record["title"] = "Hello CloudKit" as NSString
                record["body"] = "Saved from the app" as NSString
                try await privateDB.save(record)
                """)

                codeBlock(title: "Query records",
                          """
                let query = CKQuery(recordType: "Note", predicate: NSPredicate(value: true))
                let (results, _) = try await privateDB.records(matching: query, desiredKeys: ["title", "body"])
                for result in results {
                    if case let .success(record) = result {
                        let title = record["title"] as? String
                    }
                }
                """)
            }
        }
    }

    private var troubleshooting: some View {
        VStack(alignment: .leading, spacing: 8) {
            sectionHeader("Troubleshooting tips")
            bullet("If saves fail, confirm the “Note” type exists in CloudKit Dashboard or run once in development to auto-create it.")
            bullet("Use a real device signed into the same Apple ID used in Xcode signing.")
            bullet("CloudKit works offline; writes queue and sync when online. Errors appear here.")
            bullet("Private DB data is per-user; switch Apple ID to see a fresh, empty dataset.")
        }
    }

    // MARK: - Helpers

    private func sectionHeader(_ text: String) -> some View {
        Text(text)
            .font(.title3.bold())
    }

    private func bullet(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
            Text(text)
        }
        .foregroundStyle(.secondary)
    }

    private func stepRow(number: String, text: String) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Text(number)
                .font(.headline)
                .frame(width: 24, height: 24)
                .background(Circle().fill(.blue.opacity(0.15)))
            Text(text)
        }
    }

    private func statusBubble(forcedText: String? = nil) -> some View {
        Text(forcedText ?? cloudKit.statusMessage)
            .font(.footnote)
            .padding(8)
            .background(.blue.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }

    private var statusBubble: some View {
        statusBubble()
    }

    private func codeBlock(title: String, _ code: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title).bold()
            Text(code)
                .font(.system(.footnote, design: .monospaced))
                .padding()
                .background(.black.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }
}

#Preview {
    ContentView()
}
