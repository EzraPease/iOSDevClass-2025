//
//  TimeLineView.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/12/25.
//

import SwiftUI


struct TimeLineView: View {
    @State private var viewModel = TimeLineViewModel()
    
    
    var body: some View {
        VStack {
            Text("Timeline")
                .font(.largeTitle)
                .bold()
                .underline()
//                .frame(maxHeight: .infinity)
                .padding()
            ScrollView {
                ForEach(viewModel.timeLinePosts.indices.shuffled(), id: \.self) { index in
                    let viewModel = viewModel.timeLinePosts[index]
                    VStack {
                        Text(viewModel.title)
                        
                        if let image = viewModel.image {
                            AsyncImage(url: image) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .frame(maxWidth: 400, maxHeight: 400)
                                    //                                    .scaledToFit()
                                        .padding()
                                case .failure:
                                    Image(systemName: "photo")
                                    //                                        .resizable()
                                    //                                        .scaledToFit()
                                default:
                                    ProgressView()
                                }
                            }
                        }
                        Text(viewModel.description)
                        Spacer()
                    }
                    .padding(.vertical)
                }
            }
        }
    }
}

#Preview {
    TimeLineView()
}
