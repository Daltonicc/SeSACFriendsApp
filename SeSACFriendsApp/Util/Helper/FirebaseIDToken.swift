//
//  FirebaseIDToken.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/06.
//

import Foundation
import FirebaseAuth

final class FirebaseIDToken {

    static func refreshIDToken(completion: @escaping () -> Void) {

        Auth.auth().currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                return
            }

            if let idToken = idToken {
                UserDefaults.standard.set(idToken, forKey: UserDefaultKey.idToken)
                completion()
            }

        }
    }
}
