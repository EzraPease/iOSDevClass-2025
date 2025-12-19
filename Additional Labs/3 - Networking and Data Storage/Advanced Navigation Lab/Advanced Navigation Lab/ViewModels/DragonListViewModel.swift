//
//  DragonListViewModel.swift
//  Advanced Navigation Lab
//
//  Created by Ezra Pease on 12/19/25.
//

import SwiftUI


class DragonListViewModel {
    let dragonList: [Dragon] = [
        Dragon(image: "dragon.fire", lore: "A fierce fire-breather from the volcanic ridges of Pyra Peak.", age: 312, fireType: "Fire"),
        Dragon(image: "dragon.plant", lore: "A silent glider over the planes, sprouting flowers at a glance.", age: 189, fireType: "Pollen"),
        Dragon(image: "dragon.sky", lore: "Her roar summons thunderheads that coil around mountain spires.", age: 427, fireType: "Lightning"),
        Dragon(image: "dragon.earth", lore: "Guardian of hidden caverns, its scales shimmer like granite and gold.", age: 540, fireType: "Earth"),
        Dragon(image: "dragon.water", lore: "Tales say its wake becomes mist that guides lost sailors home.", age: 256, fireType: "Steam"),
        Dragon(image: "dragon.space", lore: "A moonless silhouette, seen only in reflections and rumors.", age: 378, fireType: "Voidflame"),
        Dragon(image: "dragon.toxic", lore: "Hard to even be near, can melt, or poisen all who come near", age: 801, fireType: "sludge")
    ]
}
