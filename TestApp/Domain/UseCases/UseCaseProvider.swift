//
//  UseCaseProvider.swift
//  Domain
//
//  Created by Md. Arman Morshed on 30/11/21.
//

import Foundation

public protocol UseCaseProvider {
    func makeTrendingGithubUseCase() -> TrendingGithubUseCase
}
