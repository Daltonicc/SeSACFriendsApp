//
//  LoginUseCase.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit

final class LoginUseCase {

    let firebaseRepository: FirebaseRepositoryInterface

    init(firebaseRepository: FirebaseRepositoryInterface) {
        self.firebaseRepository = firebaseRepository
    }

    func requestFirebase(textField: UITextField) {

        firebaseRepository.requestFirebaseAuth(textField: textField)
    }
    
}
