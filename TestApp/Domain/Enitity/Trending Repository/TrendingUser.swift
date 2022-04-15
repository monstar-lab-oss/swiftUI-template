//
//  TrendingUser.swift
//  Domain
//
//  Created by Md. Arman Morshed on 23/11/21.
//

import Foundation

public struct TrendingUser: Codable {
    public var username: String?
    public var name: String?
    public var url: String?
    public var sponsorUrl: String?
    public var avatar: String?
    public var repo: UserRepo?
   
    public init(username: String?,
         name: String?,
         sponsorUrl: String?,
         url: String?,
         avatar: String?,
         repo: UserRepo?) {

        self.username = username
        self.name = name
        self.url = url
        self.avatar = avatar
        self.repo = repo
        self.sponsorUrl = sponsorUrl
    }
    
    enum CodingKeys: String, CodingKey {
        case username, name, url, sponsorUrl, avatar, repo
    }
}

extension TrendingUser: Hashable {
    public static func == (lhs: TrendingUser, rhs: TrendingUser) -> Bool {
        return lhs.username == rhs.username
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(username)
    }
}
