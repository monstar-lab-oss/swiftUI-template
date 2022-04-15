//
//  TrendingGithubViewModel.swift
//  TestApp
//
//  Created by Md. Arman Morshed on 30/11/21.
//

import Foundation
import Combine
import Domain
import NetworkPlatform

class TrendingGithubViewModel: ObservableObject {
    
    @Published var appError: AppError?
    @Published var trendingRepositories: [TrendingRepository] = []
    @Published var trendingDevelopers: [TrendingUser] = []
    @Published var isLoadingDeveloperView: Bool = false
    @Published var isLoadingRepositoryView: Bool = false
    @Published var isShowingAlert: Bool = false
    
    private var bag = Set<AnyCancellable>()
    private let provider: Domain.UseCaseProvider
    
    init(provider: Domain.UseCaseProvider = NetworkPlatform.UseCaseProvider()) {
        self.provider = provider
    }
    
    func getTrendingRepositories() {
        DispatchQueue.main.async {
            self.isLoadingRepositoryView = true
        }
        provider.makeTrendingGithubUseCase()
            .trendingRepositories(language: "swift", since: "")
            .sink(receiveCompletion: { completion in
                DispatchQueue.main.async {
                    self.isLoadingRepositoryView = false
                }
                
                guard case let .failure(error) = completion else { return }
                DispatchQueue.main.async {
                    self.isShowingAlert = true
                    self.appError = error
                }
            }, receiveValue: { repositories in
                DispatchQueue.main.async {
                    self.trendingRepositories = repositories
                }
            })
            .store(in: &bag)
    }
    
    func getTrendingDevelopers() {
        DispatchQueue.main.async {
            self.isLoadingDeveloperView = true
        }
        provider.makeTrendingGithubUseCase()
            .trendingDeveloper(language: "swift", since: "")
            .sink(receiveCompletion: { completion in
                DispatchQueue.main.async {
                    self.isLoadingDeveloperView = false
                }
                
                guard case let .failure(error) = completion else { return }
                DispatchQueue.main.async {
                    self.isShowingAlert = true
                    self.appError = error
                }
                
            }, receiveValue: { developers in
                DispatchQueue.main.async {
                    self.trendingDevelopers = developers
                }
            })
            .store(in: &bag)
        
    }
}
