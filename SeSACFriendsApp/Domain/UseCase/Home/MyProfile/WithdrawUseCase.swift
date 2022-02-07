//
//  WithdrawUseCase.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/06.
//

import UIKit

final class WithdrawUseCase {

    let repository: WithdrawRepository

    init(repository: WithdrawRepository) {
        self.repository = repository
    }

    func withdrawUserData(completion: @escaping () -> Void) {

        repository.withdrawUserData { statusCode in
            switch statusCode {
            case 200: completion()
            case 401:
                FirebaseIDToken.refreshIDToken { [weak self] in
                    self?.repository.withdrawUserData(completion: { statusCode in
                        guard statusCode == 200 else { return }
                        completion()
                    })
                }
            default: print("withdraw Default")
            }
        }
    }
}
