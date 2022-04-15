//
//  Networking.swift
//  NetworkPlatform
//
//  Created by Rokon on 1/4/21.
//  Copyright © 2021 Interspeed. All rights reserved.
//

import Foundation
import Moya
import CombineMoya
import Combine
import Alamofire

class OnlineProvider<Target> where Target: Moya.TargetType {
    private let online: AnyPublisher<Bool, Never>
    private let provider: MoyaProvider<Target>
    private var authprovider = MoyaProvider<AuthAPI>()

    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider<Target>.neverStub,
         session: Session = MoyaProvider<Target>.defaultAlamofireSession(),
         plugins: [PluginType] = [VerbosePlugin(verbose: true)],
         trackInflights: Bool = false,
         online: AnyPublisher<Bool, Never>) {
        self.online = online
        self.provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, session: session, plugins: plugins, trackInflights: trackInflights)
    }

    func request(_ target: Target) -> AnyPublisher<Moya.Response, MoyaError>  {
        return provider.requestPublisher(target)
            .tryCatch({[weak self]  error -> AnyPublisher<Moya.Response, MoyaError> in
                guard let `self` = self else { throw error }
                // 401 Error, update access token
                if let response = error.response,
                   let statusCode = HTTPStatusCode(rawValue: response.statusCode),
                   statusCode == .unauthorized {
                    // TODO: handle network retry
                    return self.fetchAccessToken(target: target)
                } else {
                    throw error
                }
            })
        // TODO: investigate
            .mapError{ $0 as! MoyaError }
            .handleEvents(receiveOutput: { response in
                print(response.statusCode)
            }, receiveCompletion: { completion in
                print(completion)
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    // TODO: handle network error
                    //self.networkPopup(error.localizedDescription)
                }
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func networkLoading(_ loading: Bool) {
        let sender = NetworkLoadingNotificationSender(loading)
        NotificationCenter.default.post(name: NetworkLoadingNotificationSender.notification, object: sender)
    }

    func networkPopup(_ msg: String) {
        let sender = NetworkInfoNotificationSender(msg)
        NotificationCenter.default.post(name: NetworkInfoNotificationSender.notification, object: sender)
    }
    
    
    func fetchAccessToken(target: Target) -> AnyPublisher<Moya.Response, MoyaError> {

        return authprovider
            .requestPublisher(.accessToken)
            .handleEvents( receiveOutput: { response in

            }, receiveCompletion: { completion in
                switch completion {
                case .finished:
                    // TODO: Update new tokens
                    break
                case .failure(let error):
                    print("error: \(error)")
                    // TODO: delete existing token and logout from app
                }

            })
            .flatMap( {_ in // TODO: fix use weak self
                return self.request(target)
            }).eraseToAnyPublisher()


    }
}
