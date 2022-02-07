//
//  ProfileUseCase.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/05.
//

import UIKit

final class ProfileUseCase {

    let repository: ProfileRepository

    init(repository: ProfileRepository) {
        self.repository = repository
    }

    func updateUserData(parameter: [String: Any], completion: @escaping () -> Void) {

        repository.updateUserData(parameter: parameter) { statusCode in
            switch statusCode {
            case 200: completion()
            case 401:
                FirebaseIDToken.refreshIDToken { [weak self] in
                    self?.repository.updateUserData(parameter: parameter, completion: { statusCode in
                        guard statusCode == 200 else { return }
                        completion()
                    })
                }
            default: print("updateUser Default")
            }
        }
    }
    
}
