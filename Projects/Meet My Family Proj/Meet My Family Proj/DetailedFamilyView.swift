//
//  DetailedFamilyView.swift
//  Meet My Family Proj
//
//  Created by Ezra Pease on 10/9/25.
//

import SwiftUI

struct DetailedFamilyView: View {

    let family: MyFamily
    
    var body: some View {
        VStack {
            List {
                Section("Name"){
                    Text(family.firstName)
                }
            }
        }
    }
}

