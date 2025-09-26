//
//  ContentView.swift
//  Property Wrapper Following Along
//
//  Created by Ezra Pease on 9/26/25.
//

import SwiftUI

/*
 
 1. Request your dog to be walked
 2. Specify the number of dogs to be walked
 3. Specify the name of the dog(s)
 
 
 */


struct ContentView: View {
    
    @State var dogApp = DogApp()
    
    @State var newDogName = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Dog Walker")
                .font(.largeTitle)
            VStack {
                Text("My Dogs")
                    .font(.title)
                ForEach(dogApp.dogs) { dog in
                    Text(dog.name)
                }
            }
            
            Spacer()
            TextField("New Dog Name", text: $newDogName)
                .font(.title2)
            
            Button(action: { addDog() },
                   label: {
                HStack {
                    Spacer()
                    Text("Add a dog")
                    Image(systemName: "dog.fill")
                    Spacer()
                }
            }
            )
            .font(.largeTitle)
            .buttonStyle(.glassProminent)
        }
        .padding()
    }
    
    func addDog() {
        guard !newDogName.isEmpty else { return }
        dogApp.dogs.append(Dog(name: newDogName))
        newDogName = ""
    }
}

#Preview {
    ContentView()
}
