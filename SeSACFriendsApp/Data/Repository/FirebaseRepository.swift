//
//  FirebaseRepository.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/09.
//

import UIKit
import FirebaseAuth

final class FirebaseRepository {

    func requestFirebaseAuth(textField: UITextField) {

        //상황별 토스트 메세지 띄워주기
        PhoneAuthProvider.provider().verifyPhoneNumber("+82) \(textField.text ?? "")", uiDelegate: nil) { verificationID, error in
            if let error = error {
                 print(error.localizedDescription)
                 return
            }
            UserDefaultsRepository.saveidForCredentialFirebase(credentialId: verificationID!)
        }
    }

    func checkCredential(textField: UITextField, completion: @escaping () -> Void) {

        let credential = PhoneAuthProvider.provider().credential(withVerificationID: UserDefaultsRepository.fetchCredentialIdForFirebase(), verificationCode: textField.text ?? "")

        Auth.auth().signIn(with: credential) { success, error in
            if error == nil {
                let currentUser = Auth.auth().currentUser
                currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
                    if let error = error {
                      print("idToken error: \(error)")
                      return
                    }

                    if let idToken = idToken {
                        UserDefaultsRepository.saveIDToken(idToken: idToken)
                        print("Firebase IDToken: \(idToken)")
                        completion()
                    }
                    // 상황별 토스트 메시지 띄워주기
                }
            } else {

            }
        }
    }

    func refreshIDToken(completion: @escaping () -> Void) {

        Auth.auth().currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                return
            }

            if let idToken = idToken {
                UserDefaultsRepository.saveIDToken(idToken: idToken)
                completion()
            }

        }
    }
}
