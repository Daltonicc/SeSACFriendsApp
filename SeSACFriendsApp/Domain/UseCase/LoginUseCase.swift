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

        PhoneAuthProvider.provider().verifyPhoneNumber("+82) \(textField.text ?? "")", uiDelegate: nil) { verificationID, error in
            if let error = error {
                 print(error.localizedDescription)
                 return
            }
            LoginViewModel.yourID = verificationID!
        }
    }
    
}
