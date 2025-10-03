//
//  SpaceshipScreen.swift
//  State Spaceship (aka Stateship)
//
//  Created by Jane Madsen on 9/29/25.
//

import SwiftUI

@Observable class ShipComputer {
    var availablePower = 10
    var heading = "SYSTEM OFFLINE"
    
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
    @State private var weaponsUsed = false
    @State var inChair: Bool = false
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
                                weaponsUsed = true
                            } else {
                                weaponsOn = false
                            }
                        } else if !isOn && weaponsUsed {
                            ship.availablePower += weaponsCost
                            weaponsUsed = false
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
    @State var inChair: Bool = false
    
    var body: some View {
        HStack {
            CrewChair(crewMember: .lizard)
            
            Stepper("Shield Power: \(shieldsCost)", value: $shieldsCost, in: 0...10)
            
                .onChange(of: shieldsCost) { oldValue, newValue in
                    let difference = newValue - oldValue
                    
                    ship.availablePower -= difference
                    
                    if ship.availablePower < 0 {
                        shieldsCost = oldValue
                    }
                }
        }
    }
}

struct EngineStation: View {
    @Environment(ShipComputer.self) private var ship
    @State private var engineCost = 0
    @State var inChair: Bool = false
    
    var body: some View {
        HStack {
            CrewChair(crewMember: .hare)
            Stepper("Engine Power: \(engineCost)", value: $engineCost, in: 0...10)
            
                .onChange(of: engineCost) { oldValue, newValue in
                    let difference = newValue - oldValue
                    
                    ship.availablePower -= difference
                    
                    if ship.availablePower < 0 {
                        engineCost = oldValue
                    }
                }
        }
    }
}

struct CrewChair: View {
    @Environment(ShipComputer.self) private var ship
    var crewMember: Crew
    
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
