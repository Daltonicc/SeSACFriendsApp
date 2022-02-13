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

    // Home
    case findSeSACAroundYou(parameter: [String: Any])
    case requestFindFriends(parameter: [String: Any])
    case suspendFindFriends

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

        // Home
        case .findSeSACAroundYou: return "/queue/onqueue"
        case .requestFindFriends, .suspendFindFriends: return "/queue"

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

        // Home
        case .findSeSACAroundYou: return .post
        case .requestFindFriends: return .post
        case .suspendFindFriends: return .delete

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

        // Home
        case .findSeSACAroundYou(let parameter):
            return .requestParameters(parameters: parameter, encoding: URLEncoding.httpBody)
        case .requestFindFriends(let parameter):
            return .requestParameters(parameters: parameter, encoding: URLEncoding(arrayEncoding: .noBrackets))
        case .suspendFindFriends:
            return .requestPlain

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
                "idtoken": UserDefaultsRepository.fetchUserIDToken()
            ]
        }
    }
//      나중에 적용 시키기 - 코드 200만 success로 받아줌.
//    var validationType: ValidationType {
//        return .customCodes([200])
//    }
}
