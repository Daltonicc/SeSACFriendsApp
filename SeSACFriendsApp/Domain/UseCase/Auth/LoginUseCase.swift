//
//  LoginUseCase.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit
import FirebaseAuth

final class LoginUseCase {

    func requestFirebase(textField: UITextField) {

        //상황별 토스트 메세지 띄워주기
        PhoneAuthProvider.provider().verifyPhoneNumber("+82) \(textField.text ?? "")", uiDelegate: nil) { [weak self] verificationID, error in
            if let error = error {
                 print(error.localizedDescription)
                 return
            }
            LoginViewModel.yourIDForFirebase = verificationID!
        }
    }
    
}
