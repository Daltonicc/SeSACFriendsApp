//
//  APIService.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/29.
//

import Foundation
import Moya

enum SeSACFriendsAPI {

    // Auth
    case loginToFriendsApp
    case registerFriend(parameter: [String: Any])

    // Profile
    case updateUserData(parameter: [String: Any])
    case withdrawUser

}

extension SeSACFriendsAPI: TargetType {

    var baseURL: URL {
        return URL(string: APIKey.baseURL)!
    }

    var path: String {
        switch self {

        // Auth
        case .loginToFriendsApp: return "/user"
        case .registerFriend: return "/user"

        // Profile
        case .updateUserData: return "/user/update/mypage"
        case .withdrawUser: return "/user/withdraw"
        }
    }

    var method: Moya.Method {
        switch self {

        // Auth
        case .loginToFriendsApp: return .get
        case .registerFriend: return .post

        // Profile
        case .updateUserData: return .post
        case .withdrawUser: return .post
        }
    }

    var task: Task {
        switch self {

        // Auth
        case .loginToFriendsApp:
            return .requestPlain
        case .registerFriend(let parameter):
            return .requestParameters(parameters: parameter, encoding: URLEncoding.httpBody)

        // Profile
        case .updateUserData(let parameter):
            return .requestParameters(parameters: parameter, encoding: URLEncoding.httpBody)
        case .withdrawUser:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        default:
            return [
                "Content-Type": "application/x-www-form-urlencoded",
                "idtoken": UserDefaults.standard.string(forKey: UserDefaultKey.idToken)!
            ]
        }
    }
}
