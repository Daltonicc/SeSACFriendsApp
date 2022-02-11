//
//  WithdrawUseCase.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/06.
//

import UIKit

final class WithdrawUseCase {

    let repository: UserRepositoryInterface
    let firebaseRepository: FirebaseRepositoryInterface

    init(repository: UserRepositoryInterface, firebaseRepository: FirebaseRepositoryInterface) {
        self.repository = repository
        self.firebaseRepository = firebaseRepository
    }

    func withdrawUserData(completion: @escaping (UserNetworkError?) -> Void) {

        repository.withdrawUserData { [weak self] error in
            if let error = error {
                // 토큰 에러일 경우에만 파베 레포로 넘겨서 갱신요청.
                // 다른 에러면 그대로 뷰모델로 넘겨줌.
                // 성공하면 nil값 넘겨줌.
                if error == .firebaseIdTokenExpired {
                    self?.firebaseRepository.refreshIDToken {
                        self?.repository.requestRegisterUser { _ in
                            completion(nil)
                        }
                    }
                } else {
                    completion(error)
                }
            } else {
                completion(nil)
            }
        }
    }
}
