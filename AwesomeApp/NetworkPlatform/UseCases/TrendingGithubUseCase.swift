//
//  TrendingGithubUseCase.swift
//  NetworkPlatform
//
//  Created by Md. Arman Morshed on 30/11/21.
//

import Combine
import Domain

struct TrendingGithubUseCase: Domain.TrendingGithubUseCase {
    private let network: TrendingGithubNetworking

    init(network: TrendingGithubNetworking) {
        self.network = network
    }

    func trendingRepositories(language: String, since: String) -> AnyPublisher<[TrendingRepository], AppError> {
        return network.trendingRepositories(language: language, since: since)
            .eraseToAnyPublisher()
    }

    func trendingDeveloper(language: String, since: String) -> AnyPublisher<[TrendingUser], AppError> {
        return network.trendingDevelopers(language: language, since: since)
            .eraseToAnyPublisher()
    }
}
