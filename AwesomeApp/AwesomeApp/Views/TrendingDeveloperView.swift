//
//  TrendingDeveloperView.swift
//  AwesomeApp
//
//  Created by Md. Arman Morshed on 30/11/21.
//

import SwiftUI

struct TrendingDeveloperView: View {
    @EnvironmentObject var viewModel: TrendingGithubViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach(viewModel.trendingDevelopers, id: \.self) { developer in
                            VStack(alignment: .leading) {
                                HStack(alignment: .top ,spacing: 20) {
                                    AsyncImage(
                                        url: URL(string: developer.avatar ?? ""),
                                        content: { image in
                                            image.resizable()
                                                .frame(width: 72, height: 72)
                                                .clipShape(Circle())
                                        },
                                        placeholder: {
                                            Image(systemName: "photo.circle.fill")
                                                .font(.system(size: 64))
                                                .foregroundColor(.gray)
                                        }
                                    )
                                    
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(developer.name ?? "")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                        Text(developer.username ?? "")
                                            .font(.body)
                                        Text(developer.url ?? "")
                                            .font(.footnote)
                                    }
                                }
                                Divider()
                            }
                        }
                    }
                    .padding()
                }
                
                if viewModel.isLoadingDeveloperView {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(width: 800, height: 800, alignment: .center)
                }
            }
            .navigationTitle("Trending Developers")
            .onAppear {
                viewModel.getTrendingDevelopers()
                viewModel.trendingRepositories = []
            }
            .alert(viewModel.appError?.title ?? "", isPresented: $viewModel.isShowingAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}

struct TrendingDeveloperView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingDeveloperView()
    }
}
