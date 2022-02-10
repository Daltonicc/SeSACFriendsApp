//
//  UserDefaultRepository.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/06.
//

import Foundation

final class UserDefaultsRepository {

    static func saveFirstLoginCheck(check: Bool) {
        UserDefaults.standard.set(check, forKey: UserDefaultKey.firstLoginCheck)
    }

    static func saveidForCredentialFirebase(credentialId: String) {
        UserDefaults.standard.set(credentialId, forKey: UserDefaultKey.credentialId)
    }

    static func saveFCMToken(fcmToken: String) {
        UserDefaults.standard.set(fcmToken, forKey: UserDefaultKey.fcmToken)
    }

    static func saveIDToken(idToken: String) {
        UserDefaults.standard.set(idToken, forKey: UserDefaultKey.idToken)
    }

    static func savePhoneNumber(phoneNumber: String) {
        UserDefaults.standard.set(phoneNumber, forKey: UserDefaultKey.phoneNumber)
    }

    static func saveNickname(nickname: String) {
        UserDefaults.standard.set(nickname, forKey: UserDefaultKey.nickname)
    }

    static func saveBirth(birth: String) {
        UserDefaults.standard.set(birth, forKey: UserDefaultKey.birth)
    }

    static func saveEmail(email: String) {
        UserDefaults.standard.set(email, forKey: UserDefaultKey.email)
    }

    static func saveGender(gender: Int) {
        UserDefaults.standard.set(gender, forKey: UserDefaultKey.gender)
    }

    static func fetchFirstLoginCheck() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultKey.firstLoginCheck)
    }
    static func fetchUserNickname() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultKey.nickname)!
    }

    static func fetchCredentialIdForFirebase() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultKey.credentialId)!
    }

    static func requestRegisterUser() -> [String: Any] {

        let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber")!
        let fcmToken = UserDefaults.standard.string(forKey: "FCMToken")!
        let nick = UserDefaults.standard.string(forKey: "nickname")!
        let birth = UserDefaults.standard.string(forKey: "birth")!
        let email = UserDefaults.standard.string(forKey: "email")!
        let gender = UserDefaults.standard.integer(forKey: "gender")

        let parameter: [String: Any] = [
            "phoneNumber": phoneNumber,
            "FCMtoken": fcmToken,
            "nick": nick,
            "birth": birth,
            "email": email,
            "gender": gender
        ]

        return parameter
    }
}
