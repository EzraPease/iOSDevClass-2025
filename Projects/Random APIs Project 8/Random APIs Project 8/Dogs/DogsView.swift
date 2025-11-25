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
    @State private var selectedDog: DogListCell? = nil
    @State private var imageURL: URL?
    @State private var dogName = ""
    @State private var saveDogDisabled = false
    @State private var editIsPresented = false
    
    init(apiController: DogAPIController) {
        self.apiController = apiController
    }
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        NavigationStack {
            VStack {
                // Main Dog - Large photo at the top
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
            TextField("Name Me?", text: $dogName) // Field for naming the dog
            // Button for saving the dog image and name
            Button {
                saveDogDisabled = true
                // Sets dogName to a default when none is entered before saving dog
                if dogName.isEmpty {
                    dogName = "No Name Entered"
                }
                if let imageURL {
                    viewModel.dogList.append(DogListCell(image: imageURL, name: dogName))
                } else {
                    print("Unable to save image")
                }
                Task {
                    do {
                        let urlString = try await apiController.fetchDogImage()
                        imageURL = URL(string: urlString)
                    } catch {
                        print(error)
                    }
                    try? await Task.sleep(nanoseconds: 1_200_000_000)
                    saveDogDisabled = false
                }
                dogName = "" // Clears the dog name when generating a new dog image
                
                // Debugging Prints
                print(viewModel.dogList)
                print("Saved Dogs: \(viewModel.dogList.count)")
            } label: {
                Text("Save Dog | Generate New One")
            }
            .disabled(saveDogDisabled)
            .padding(8)
            .glassEffect()
            // Lists all the currently saved dogs (Image and Name)
            List($viewModel.dogList) { $dog in
                HStack {
                    Button {
                        editIsPresented = true
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
            .sheet(item: $selectedDog) { dog in
                NavigationStack {

                        DogDetailView(currentDog: dog)
                            .presentationDetents([.large, .medium])
                }
            }
        }
        .task {
            do {
                let urlString = try await apiController.fetchDogImage()
                imageURL = URL(string: urlString)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ParentView()
}
