//
//  GenderUseCase.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/05.
//

import UIKit

final class GenderUseCase {

    let repository: GenderRepository

    init(repository: GenderRepository) {
        self.repository = repository
    }

    func requestRegisterUserByUseCase(completion: @escaping (Int) -> Void) {
        repository.requestRegisterUser { [weak self] statusCode in
            completion(statusCode)
        }
    }
}
