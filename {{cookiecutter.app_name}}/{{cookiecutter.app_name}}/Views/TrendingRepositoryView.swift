//
//  TrendingRepositoryView.swift
//  {{cookiecutter.app_name}}
//
//  Created by Md. Arman Morshed on 30/11/21.
//

import SwiftUI

struct TrendingRepositoryView: View {
    @EnvironmentObject var viewModel: TrendingGithubViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach(viewModel.trendingRepositories, id: \.self) { repository in
                            HStack(alignment: .top ,spacing: 20) {
                                AsyncImage(
                                    url: URL(string: repository.avatar ?? ""),
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
                                    Text(repository.author ?? "")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Text(repository.name ?? "")
                                        .font(.body)
                                    HStack {
                                        Image(systemName: "star.fill")
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 16, height: 16)
                                        Text("\(repository.stars ?? 0)")
                                            .font(.body)
                                    }
                                    
                                    HStack {
                                        Image("fork_icon")
                                            .resizable()
                                            .renderingMode(.template)
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 18, height: 20)
                                        Text("\(repository.forks ?? 0)")
                                            .font(.body)
                                    }
                                    Divider()
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                if viewModel.isLoadingRepositoryView {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(width: 800, height: 800, alignment: .center)
                }
            }
            .navigationTitle("Trending Repositories")
            .onAppear {
                viewModel.getTrendingRepositories()
                viewModel.trendingDevelopers = []
            }
            .alert(viewModel.appError?.title ?? "", isPresented: $viewModel.isShowingAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}

struct TrendingRepositoryView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingRepositoryView()
    }
}
