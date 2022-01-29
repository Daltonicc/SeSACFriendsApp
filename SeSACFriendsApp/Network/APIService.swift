//
//  APIService.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/29.
//

import Foundation
import Moya

enum SeSACFriendsAPI {
    case loginToFriendsApp
}

extension SeSACFriendsAPI: TargetType {

    var baseURL: URL {
        return URL(string: APIKey.baseURL)!
    }

    var path: String {
        switch self {
        case .loginToFriendsApp:
            return "/user"
        }
    }

    var method: Moya.Method {
        switch self {
        case .loginToFriendsApp: return .get
        }
    }

    var task: Task {
        switch self {
        case .loginToFriendsApp:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .loginToFriendsApp:
            return [
                "Content-Type": "application/x-www-form-urlencoded",
                "idToken": UserDefaults.standard.string(forKey: "uidToken")!
            ]
        }

    }

}
