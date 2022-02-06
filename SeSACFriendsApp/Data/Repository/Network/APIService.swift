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
    case registerFriend(parameter: [String: Any])

}

extension SeSACFriendsAPI: TargetType {

    var baseURL: URL {
        return URL(string: APIKey.baseURL)!
    }

    var path: String {
        switch self {
        case .loginToFriendsApp: return "/user"
        case .registerFriend: return "/user"
        }
    }

    var method: Moya.Method {
        switch self {
        case .loginToFriendsApp: return .get
        case .registerFriend: return .post
        }
    }

    var task: Task {
        switch self {
        case .loginToFriendsApp:
            return .requestPlain
        case .registerFriend(let parameter):
            return .requestParameters(parameters: parameter, encoding: URLEncoding.httpBody)
        }
    }

    var headers: [String: String]? {
        switch self {
        default:
            return [
                "Content-Type": "application/x-www-form-urlencoded",
                "idtoken": UserDefaults.standard.string(forKey: "uidToken")!
            ]
        }
    }
}
