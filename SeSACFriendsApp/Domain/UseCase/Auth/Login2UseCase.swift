//
//  Login2UseCase.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit
import FirebaseAuth

final class Login2UseCase {

    let repository: Login2Repository

    init(repository: Login2Repository) {
        self.repository = repository
    }

    func checkCredential(textField: UITextField, completion: @escaping (Int) -> Void) {

        let credential = PhoneAuthProvider.provider().credential(withVerificationID: LoginViewModel.yourIDForFirebase, verificationCode: textField.text ?? "")

        Auth.auth().signIn(with: credential) { success, error in
            if error == nil {
                let currentUser = Auth.auth().currentUser
                currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
                    if let error = error {
                      print("idToken error: \(error)")
                      return
                    }

                    if let idToken = idToken {
                        UserDefaults.standard.set(idToken, forKey: "uidToken")
                        print("Firebase IDToken: \(idToken)")
    
                        self.repository.getUserInfo { statusCode in
                            completion(statusCode)
                        }
                    }
                    // 상황별 토스트 메시지 띄워주기
                }
            } else {

            }
        }

    }
}
