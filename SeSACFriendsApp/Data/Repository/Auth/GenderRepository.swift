//
//  GenderRepository.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/29.
//

import Foundation
import Moya

final class GenderRepository {

    func requestRegisterUser() {

        let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber")!
        let fcmToken = UserDefaults.standard.string(forKey: "FCMToken")!
        let nick = UserDefaults.standard.string(forKey: "nickname")!
        let birth = UserDefaults.standard.string(forKey: "birth")!
        let email = UserDefaults.standard.string(forKey: "email")!
        let gender = UserDefaults.standard.integer(forKey: "gender")

        print(phoneNumber, fcmToken, nick, birth, email, gender)

        let provider = MoyaProvider<SeSACFriendsAPI>()
        provider.request(.registerFriend(phoneNumber, fcmToken, nick, birth, email, gender)) { (result) in
            switch result {
            case let .success(Response):
                let data = try? Response.map(GetUser.self)
                print(data)
                let statusCode = Response.statusCode
                print("상태코드 :\(statusCode)")

            case let .failure(MoyaError):
                let errorCode = MoyaError.errorCode
                print("에러코드: \(errorCode)")
                print(MoyaError.localizedDescription)
            }
        }
    }
}
