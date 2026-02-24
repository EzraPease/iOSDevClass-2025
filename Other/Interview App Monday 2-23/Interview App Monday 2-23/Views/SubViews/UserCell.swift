//
//  UserCell.swift
//  Interview App Monday 2-23
//
//  Created by Ezra Pease on 2/23/26.
//

import SwiftUI

struct UserCell: View {
    @State var user: User
    
    var body: some View {
            HStack {
                Image(systemName: user.selected ? "checkmark.diamond.fill" : "diamond")
                    .background(user.selected ? .green : .red)
                    .padding(.horizontal, 3)
                Text("Name:")
                    .bold()
                Text(user.username)
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(.cyan.gradient)
            .cornerRadius(10)
    }
}

#Preview {
    UserCell(user: User(username: "Example Name", orderIndex: 1))
}
