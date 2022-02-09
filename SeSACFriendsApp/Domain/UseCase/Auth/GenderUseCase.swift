//
//  GenderUseCase.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/05.
//

import UIKit

final class GenderUseCase {

    let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }

    func requestRegisterUserByUseCase(completion: @escaping (Result<UserData?, UserNetworkError>) -> Void) {
        repository.requestRegisterUser(completion: completion)
    }
}
