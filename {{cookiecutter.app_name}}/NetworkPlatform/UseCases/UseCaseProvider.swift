//
//  UseCaseProvider.swift
//  NetworkPlatform
//
//  Created by Md. Arman Morshed on 30/11/21.
//

import Foundation
import Domain

public struct UseCaseProvider: Domain.UseCaseProvider {
    private let networkProvider: NetworkProvider
    
    public init() {
        networkProvider = NetworkProvider()
    }
    
    public func makeTrendingGithubUseCase() -> Domain.TrendingGithubUseCase {
        return TrendingGithubUseCase(network: networkProvider.makeTrendingGithubNetworking())
    }
}
