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
    @Environment(\.colorScheme) private var colorScheme
    @State private var myShip = ShipComputer()
    
    var isDarkMode: Bool { colorScheme == .dark }
    
    var body: some View {
        
        let sectionGradient = RadialGradient(
            colors: colorScheme == .dark ? [.white, .gray] : [.gray, .white],
            center: .topLeading,
            startRadius: 5,
            endRadius: 75)
        
        Form {
            Section("Helm Station") {
                HelmStation()
                    .foregroundStyle(isDarkMode ? .white : .black)
            }
            .foregroundStyle(sectionGradient)
            
            Section("Weapons Station") {
                WeaponsStation()
                    .foregroundStyle(isDarkMode ? .white : .black)
                
            }
            .foregroundStyle(sectionGradient)
            
            
            Section("Shield Station") {
                ShieldStation()
                    .foregroundStyle(isDarkMode ? .white : .black)
            }
            .foregroundStyle(sectionGradient)
            
            Section("Engine Station") {
                EngineStation()
                    .foregroundStyle(isDarkMode ? .white : .black)
            }
            .foregroundStyle(sectionGradient)
            
            Text("Available Power: \(myShip.availablePower)")
                .bold()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .listRowBackground(RadialGradient(
                    colors: isDarkMode ? [.gray, .black] : [.gray, .white],
                    center: .bottomLeading,
                    startRadius: isDarkMode ? 30 : 5,
                    endRadius: 250))
        }
        .scrollContentBackground(.hidden)
        .background(RadialGradient(
            colors: [.blue, .black],
            center: .topTrailing,
            startRadius: 5,
            endRadius: 1150))
        .environment(myShip)
        //        .padding()
    }
}

//struct PowerView: View {
//    @Environment(ShipComputer.self) private var ship
//
//    var body: some View {
//        @Bindable var ship = ship
//
//        Text("Available Power: \(ship.availablePower)")
//            .font(.largeTitle)
//    }
//}

struct HelmStation: View {
    @Environment(ShipComputer.self) private var ship
    @State var inChair: Bool = false
    
    var body: some View {
        @Bindable var ship = ship
        
        HStack {
            CrewChair(crewMember: .dog, inChair: $inChair)
            
            TextField("Heading", text: $ship.heading)
                .disabled(!inChair)
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
            CrewChair(crewMember: .cat, inChair: $inChair)
            
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
                    .disabled(!inChair)
                
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
    @State private var maxShieldPower = 10
    
    var body: some View {
        HStack {
            CrewChair(crewMember: .lizard, inChair: $inChair)
            
            Stepper("Shield Power: \(shieldsCost)", value: $shieldsCost, in: 0...10)
            
                .onChange(of: shieldsCost) { oldValue, newValue in
                    let difference = newValue - oldValue
                    
                    ship.availablePower -= difference
                    
                    if ship.availablePower < 0 {
                        shieldsCost = oldValue
                    }
                }
                .disabled(!inChair)
        }
    }
}

struct EngineStation: View {
    @Environment(ShipComputer.self) private var ship
    @State private var engineCost = 0
    @State var inChair: Bool = false
    
    var body: some View {
        HStack {
            CrewChair(crewMember: .hare, inChair: $inChair)
            Stepper("Engine Power: \(engineCost)", value: $engineCost, in: 0...10)
            
                .onChange(of: engineCost) { oldValue, newValue in
                    let difference = newValue - oldValue
                    
                    ship.availablePower -= difference
                    
                    if ship.availablePower < 0 {
                        engineCost = oldValue
                    }
                }
                .disabled(!inChair)
        }
    }
}

struct CrewChair: View {
    @Environment(ShipComputer.self) private var ship
    var crewMember: Crew
    @Binding var inChair: Bool
    
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
        .buttonStyle(.plain)
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
