//
//  TrendingGithubNetworking.swift
//  NetworkPlatform
//
//  Created by Md. Arman Morshed on 26/11/21.
//

import Foundation
import Moya
import Combine
import Domain

struct TrendingGithubNetworking: NetworkingType {
    typealias T = TrendingGithubAPI
    let provider: OnlineProvider<T>
    
    static func defaultNetworking() -> Self {
        return  TrendingGithubNetworking(provider: OnlineProvider(endpointClosure: TrendingGithubNetworking.endpointsClosure(), requestClosure: TrendingGithubNetworking.endpointResolver(), stubClosure: TrendingGithubNetworking.APIKeysBasedStubBehaviour, online: Just(true).setFailureType(to: Never.self).eraseToAnyPublisher()))
    }
    
    static func stubbingNetworking() -> Self {
        return  TrendingGithubNetworking(provider: OnlineProvider(endpointClosure: endpointsClosure(), requestClosure: TrendingGithubNetworking.endpointResolver(), stubClosure: MoyaProvider.immediatelyStub, online: Just(true).setFailureType(to: Never.self).eraseToAnyPublisher()))
    }
    
    func request(_ target: T) -> AnyPublisher<Moya.Response, MoyaError> {
        let actualRequest = provider.request(target)
        return actualRequest
    }
    
    private func trendingRequestObject<T: Codable>(_ target: TrendingGithubAPI, type: T.Type) -> AnyPublisher<T, AppError> {
        return request(target)
            .filterSuccessfulStatusCodes()
            .map(T.self)
            .mapError({ error -> AppError in
                AppError(code: error.errorCode, title: nil, message: error.localizedDescription)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
    
    private func trendingRequestArray<T: Codable>(_ target: TrendingGithubAPI, type: T.Type) -> AnyPublisher<[T], AppError> {
        return request(target)
            .filterSuccessfulStatusCodes()
            .map([T].self)
            .mapError({ error -> AppError in
                AppError(code: error.errorCode, title: nil, message: error.localizedDescription)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}


extension TrendingGithubNetworking {
    func trendingRepositories(language: String, since: String) -> AnyPublisher<[TrendingRepository], AppError> {
        return trendingRequestArray(.trendingRepositories(language: language, since: since), type: TrendingRepository.self)
    }

    func trendingDevelopers(language: String, since: String) ->  AnyPublisher<[TrendingUser], AppError> {
        return trendingRequestArray(.trendingDevelopers(language: language, since: since), type: TrendingUser.self)
    }
}
