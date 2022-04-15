//
//  TrendingGithubUseCase.swift
//  Domain
//
//  Created by Md. Arman Morshed on 23/11/21.
//

import Foundation
import Combine

public protocol TrendingGithubUseCase {
    func trendingRepositories(language: String, since: String) -> AnyPublisher<[TrendingRepository], AppError>
    func trendingDeveloper(language: String, since: String) -> AnyPublisher<[TrendingUser], AppError>
}
