//
//  SpaceshipScreen.swift
//  State Spaceship (aka Stateship)
//
//  Created by Jane Madsen on 9/29/25.
//

import SwiftUI

class ShipComputer {
    var availablePower = 10
    var heading = ""
}

struct SpaceshipScreen: View {
    var body: some View {
        Form {
            Section("Helm Station") {
                HelmStation()
            }
            
            Section("Weapons Station") {
                WeaponsStation()
            }
            
            Section("Shield Station") {
                ShieldStation()
            }
            
            Section("Engine Station") {
                EngineStation()
            }
            
            Text("Available Power: \(0)")

        }
        .padding()
    }
}

struct HelmStation: View {
    var body: some View {
        HStack {
            CrewChair(crewMember: .dog)
            
            TextField("Heading", text: .constant("SYSTEM OFFLINE"))
        }
    }
}

struct WeaponsStation: View {
    var body: some View {
        HStack {
            CrewChair(crewMember: .cat)
            
            VStack {
                Toggle("Weapons Power: \(0)", isOn: .constant(false))
                //            .onChange(of: isOn) {
                //                // Add logic to remove/add 3 power to the system when enabled/disabled
                //            }
                
                Button("Fire!") {
                    // Add logic to only allow firing if power is available
                    print("PEW!")
                }
                .disabled(true)
            }
        }
    }
}

struct ShieldStation: View {
    var body: some View {
        HStack {
            CrewChair(crewMember: .lizard)
            
            Stepper("Shield Power: \(0)", value: .constant(0), in: 0...10)
        }
    }
}

struct EngineStation: View {
    var body: some View {
        HStack {
            CrewChair(crewMember: .hare)
            Stepper("Engine Power: \(0)", value: .constant(0), in: 0...10)

        }
    }
}

struct CrewChair: View {
    var crewMember: Crew
    @State var inChair: Bool = false
    
    var body: some View {
        Button {
            inChair.toggle()
        } label: {
            if inChair {
                crewMember.icon
            } else {
                Image(systemName: "person.slash")
            }
        }
        .padding(5)
        .background {
            Circle()
                .foregroundStyle(.gray)
        }
    }
}

enum Crew: String {
    case dog
    case cat
    case lizard
    case hare
    
    var icon: Image {
        switch self {
        case .dog:
            Image(systemName: "dog")
        case .cat:
            Image(systemName: "cat")
        case .lizard:
            Image(systemName: "lizard")
        case .hare:
            Image(systemName: "hare")
        }
    }
}

#Preview {
    SpaceshipScreen()
}
