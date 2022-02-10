//
//  Login2UseCase.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit

final class Login2UseCase {

    let repository: UserRepository
    let firebaseRepository: FirebaseRepository

    init(repository: UserRepository, firebaseRepository: FirebaseRepository) {
        self.repository = repository
        self.firebaseRepository = firebaseRepository
    }

    func checkCredential(textField: UITextField, completion: @escaping (Result<UserData, UserNetworkError>) -> Void) {

        firebaseRepository.checkCredential(textField: textField) {
            self.repository.getUserInfo(completion: completion)
        }
    }
}
