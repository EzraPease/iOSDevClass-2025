//
//  ContentView.swift
//  GeometryReader
//
//  Created by Ezra Pease on 1/6/26.
//

import SwiftUI

struct ProfileCardView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @State private var viewModel = ProfileCardViewModel()
    
    var rowCount: Int {
        var rowCount = viewModel.profileCardList.count / columnCount
        if viewModel.profileCardList.count % columnCount != 0 {
            rowCount += 1
        }
        return rowCount
    }
    var columnCount: Int {
        horizontalSizeClass == .compact ? 2 : 3
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    ForEach(0..<rowCount, id: \.self) { row in
                        HStack {
                            
                            Spacer()
                            
                            ForEach(0..<columnCount, id: \.self) { column in
                                buildCardCell(row: row, column: column)
                                    .frame(width: geometry.size.width / CGFloat(columnCount) - 10, height: 200)
                            }
                            
                            Spacer()
                        }
                    }
                }
            }
        }
        .padding()
        .background(.cyan)
    }
    
    func personIndex(row: Int, column: Int) -> Int? {
        let index = row * columnCount + column
        if index > viewModel.profileCardList.count - 1 { return nil }
        return index
    }
    
    @ViewBuilder
    private func buildCardCell(row: Int, column: Int) -> some View {
        if let personIndex = personIndex(row: row, column: column) {
            RoundedRectangle(cornerRadius: 20)
                .fill(.green)
                .overlay {
                    VStack(spacing: 10) {
                        Image(systemName: viewModel.profileCardList[personIndex].image)
                        Text(viewModel.profileCardList[personIndex].text)
                    }
                }
        } else {
            Color.clear
        }
    }
}

#Preview {
    ProfileCardView()
}
