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
    case registerFriend(_ phoneNumber: String?, _ fcmToken: String?, _ nick: String?, _ birth: String?, _ email: String?, _ gender: String?)
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
        case .registerFriend(let phoneNumber, let fcmToken, let nick, let birth, let email, let gender):
            let parameter: [String: Any] = [
                "phoneNumber": phoneNumber ?? "",
                "FCMToken": fcmToken ?? "",
                "nick": nick ?? "",
                "birth": birth ?? "",
                "email": email ?? "",
                "gender": gender ?? 0
            ]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        switch self {
        case .loginToFriendsApp:
            return [
                "Content-Type": "application/x-www-form-urlencoded",
                "idToken": UserDefaults.standard.string(forKey: "uidToken")!
            ]
        case .registerFriend:
            return [
                "Content-Type": "application/x-www-form-urlencoded",
                "idToken": UserDefaults.standard.string(forKey: "uidToken")!
            ]
        }

    }

}
