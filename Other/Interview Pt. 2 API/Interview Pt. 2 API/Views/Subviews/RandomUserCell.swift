//
//  RandomUserCell.swift
//  Interview Pt. 2 API
//
//  Created by Ezra Pease on 2/24/26.
//

import SwiftUI

struct RandomUserCell: View {
    @State var users: APIResponse
    
    var body: some View {
        Text("Random User Cell")
    }
}

#Preview {
    RootView()
}
