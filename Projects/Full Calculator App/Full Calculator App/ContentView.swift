//
//  ContentView.swift
//  Full Calculator App
//
//  Created by Ezra Pease on 9/26/25.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        HStack {
            VStack {
                Text("Placeholder")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.gray)
                
                Spacer()
                
                HStack {
                    Button("1") {
                        
                    }
                    .padding()
                    .background(.gray, in: Circle())
                    Button("2") {
                        
                    }
                    .padding()
                    .background(.gray, in: Circle())
                    Button("3") {
                        
                    }
                    .padding()
                    .background(.gray, in: Circle())
                    
                }
                HStack {
                    Button("4") {
                        
                    }
                    .padding()
                    .background(.gray, in: Circle())
                    Button("5") {
                        
                    }
                    .padding()
                    .background(.gray, in: Circle())
                    Button("6") {
                        
                    }
                    .padding()
                    .background(.gray, in: Circle())
                }
                HStack {
                    Button("7") {
                        
                    }
                    .padding()
                    .background(.gray, in: Circle())
                    Button("8") {
                        
                    }
                    .padding()
                    .background(.gray, in: Circle())
                    Button("9") {
                        
                    }
                    .padding()
                    .background(.gray, in: Circle())
                }
                Button("10") {
                    
                }
                .padding()
                .background(.gray, in: Circle())
            }
            VStack {
                Button("+") {
                    
                }
                Button("-") {
                    
                }
                Button("x") {
                    
                }
                Button("/") {
                    
                }
            }
        }
        Spacer()
        
    }
}

#Preview {
    ContentView()
}


