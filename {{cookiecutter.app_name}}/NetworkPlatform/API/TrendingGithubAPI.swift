//
//  TrendingGithubAPI.swift
//  NetworkPlatform
//
//  Created by Md. Arman Morshed on 26/11/21.
//

import Foundation
import Moya

enum TrendingGithubAPI {
    case trendingRepositories(language: String, since: String)
    case trendingDevelopers(language: String, since: String)
    case languages
}

extension TrendingGithubAPI: TargetType, ProductAPIType {

    var baseURL: URL {
        return  URL(string: Configs.Network.trendingGithubBaseUrl)!
    }

    var path: String {
        switch self {
        case .trendingRepositories: return "/repositories"
        case .trendingDevelopers: return "/developers"
        case .languages: return "/languages"
        }
    }

    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }

    var headers: [String: String]? {
        return nil
    }

    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self {
        case .trendingRepositories(let language, let since),
             .trendingDevelopers(let language, let since):
            params["language"] = language
            params["since"] = since
        default: break
        }
        return params
    }

    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    var sampleData: Data {
        // TODO: Need to provide provide stubbed response using R.swift
        return Data()
    }

    public var task: Task {
        if let parameters = parameters {
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
        return .requestPlain
    }

    var addXAuth: Bool {
        switch self {
        default: return false
        }
    }
}


