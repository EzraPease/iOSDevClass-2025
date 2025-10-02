//
//  SpaceshipScreen.swift
//  State Spaceship (aka Stateship)
//
//  Created by Jane Madsen on 9/29/25.
//

import SwiftUI

@Observable class ShipComputer {
    var availablePower = 10
    var heading = ""
}

struct SpaceshipScreen: View {
    @State private var myShip = ShipComputer()
    
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
            
            Text("Available Power: \(myShip.availablePower)")
            
        }
        .environment(myShip)
        .padding()
    }
}

struct HelmStation: View {
    @Environment(ShipComputer.self) private var ship
    var body: some View {
        @Bindable var ship = ship
        
        HStack {
            CrewChair(crewMember: .dog)
            
            TextField("Heading", text: $ship.heading)
        }
    }
}

struct WeaponsStation: View {
    @Environment(ShipComputer.self) private var ship
    @State private var weaponsOn = false
    private let weaponsCost = 3
    
    var body: some View {
        @Bindable var ship = ship
        
        HStack {
            CrewChair(crewMember: .cat)
            
            VStack {
                Toggle("Weapons Power: \(weaponsOn ? weaponsCost : 0)", isOn: $weaponsOn)
                    .onChange(of: weaponsOn) { _, isOn in
                        // Add logic to remove/add 3 power to the system when enabled/disabled
                        if isOn {
                            if ship.availablePower >= weaponsCost {
                                ship.availablePower -= weaponsCost
                            } else {
                                weaponsOn = false
                            }
                        } else if ship.availablePower >= 3 {
                            ship.availablePower += weaponsCost
                        }
                    }
                
                Button("Fire!") {
                    // Add logic to only allow firing if power is available
                    print("PEW!")
                }
                .disabled(!weaponsOn)
            }
        }
    }
}

struct ShieldStation: View {
    @Environment(ShipComputer.self) private var ship
    @State private var shieldsCost = 0
    @State private var maxShieldCost = 10
    
    var body: some View {
        HStack {
            CrewChair(crewMember: .lizard)
            
            Stepper("Shield Power: \(shieldsCost)", value: $shieldsCost, in: 0...maxShieldCost)
                .onChange(of: shieldsCost) { oldValue, newValue in
                    if ship.availablePower < 1 {
                        maxShieldCost = shieldsCost - 1
                    }
                    if newValue > oldValue {
                        ship.availablePower -= 1
                    } else {
                        ship.availablePower += 1
                    }
                }
        }
    }
}

struct EngineStation: View {
    @Environment(ShipComputer.self) private var ship
    var body: some View {
        HStack {
            CrewChair(crewMember: .hare)
            Stepper("Engine Power: \(0)", value: .constant(0), in: 0...10)
            
        }
    }
}

struct CrewChair: View {
    @Environment(ShipComputer.self) private var ship
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
