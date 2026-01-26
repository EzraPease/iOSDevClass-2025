//
//  DogsView.swift
//  Random APIs Project 8
//
//  Created by Ezra Pease on 11/21/25.
//

import SwiftUI


struct DogsView: View {
    @Environment(DogListViewModel.self) private var viewModel
    @State private var apiController: DogAPIController
    @State private var selectedDog: DogListCell? = nil // Variable used for editing specific dogs in the list
    @State private var imageURL: URL?
    @State private var dogName = ""
    @State private var saveDogDisabled = false
    @State private var noNameErrorPresented = false
    @State private var dogNameTextField = "Dog Name..."
    
    init(apiController: DogAPIController) {
        self.apiController = apiController
    }
    
    private func playHaptic() { // Haptic function
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                dogImageView()
                
                // Button for saving the dog image and name
                HStack {
                    saveButton()
                    
                    if saveDogDisabled {
                        ProgressView()
                    }
                }
                dogListView()
                // Lists all the currently saved dogs (Image and Name)
                // Sheet for viewing dog details / editing the name
            }
        }
        // Refreshes / fetches a new image whenver the view is shown
        .task {
            do {
                let dog = try await apiController.fetchDog()
                imageURL = dog.message
            } catch {
                print(error)
            }
        }
        .sheet(item: $selectedDog) { dog in
            NavigationStack {
                DogDetailView(currentDog: dog)
                    .environment(viewModel)
                    .presentationDetents([.large, .medium])
            }
        }
    }
    
    func dogImageView() -> some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 4)
            case .failure:
                Image(systemName: "photo")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
            @unknown default:
                EmptyView()
            }
        }
        .frame(height: 300)
    }
    
    func textFieldView() -> some View {
        TextField(
            "",
            text: $dogName,
            prompt: Text(dogNameTextField)
                .foregroundStyle(noNameErrorPresented ? .red : .secondary)
                .bold(noNameErrorPresented)
        ) // Field for setting dog name
    }
    
    func saveButton() -> some View {
        Button(action: saveDog) {
            Text(saveDogDisabled ? "Saving..." : "Save Dog | Generate New One")
                .animation(.none)
        }
        .disabled(saveDogDisabled)
        .padding(8)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
    
    func dogListView() -> some View {
        List(viewModel.dogList) { dog in
            HStack {
                Button {
                    selectedDog = dog
                    //                        print(selectedDog)
                } label: {
                    AsyncImage(url: dog.image) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .shadow(radius: 4)
                                .frame(maxWidth: 100, maxHeight: 100)
                        case .failure:
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundColor(.secondary)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                
                
                Spacer()
                Text(dog.name)
            }
        }
    }
    
    private func saveDog() {
        playHaptic() // Plays a haptic when the button is clicked
        saveDogDisabled = true
        // Sets dogName to a default when none is entered before saving dog
        if dogName.isEmpty {
            print("No dog name entered")
            
            dogNameTextField = "Please input name..."
            noNameErrorPresented = true
            
            Task {
                try? await Task.sleep(nanoseconds: 450_000_000) // Temporary button disable for .45 seconds
                saveDogDisabled = false
            }
            Task {
                try? await Task.sleep(nanoseconds: 30 * 1_000_000_000) // Temporary text to indicate a dog needs a name inputed (lasts for 5 seconds)
                noNameErrorPresented = false
                dogNameTextField = "Dog Name..."
            }
        } else {
            if let imageURL {
                viewModel.dogList.append(DogListCell(image: imageURL, name: dogName))
            } else {
                print("Unable to save image")
            }
            Task {
                do {
                    let dog = try await apiController.fetchDog()
                    imageURL = dog.message
                } catch {
                    print(error)
                }
                try? await Task.sleep(nanoseconds: 1_200_000_000)
                saveDogDisabled = false
            }
            dogName = "" // Clears the dog name when generating a new dog image
        }
        
        // Debugging Prints
        print(viewModel.dogList)
        print("Saved Dogs: \(viewModel.dogList.count)")
        
    }
}

#Preview {
    ParentView()
}
