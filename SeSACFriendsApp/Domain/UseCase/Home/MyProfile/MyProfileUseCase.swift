//
//  MyProfileUseCase.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/05.
//

import UIKit

final class MyProfileUseCase {

    let repository: MyProfileRepository

    init(repository: MyProfileRepository) {
        self.repository = repository
    }

    func getUserData(completion: @escaping (UserData) -> Void) {

        repository.getUserInfo { statusCode, userData in
            switch statusCode {
            case 200: completion(userData!)
            default: print("default")
            }
        }
    }
}
