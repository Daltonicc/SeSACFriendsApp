//
//  AlertUseCase.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/06.
//

import UIKit

final class AlertUseCase {

    let repository: UserRepositoryInterface
    let queueRepository: QueueRepositoryInterface
    let firebaseRepository: FirebaseRepositoryInterface

    init(repository: UserRepositoryInterface, queueRepository: QueueRepositoryInterface, firebaseRepository: FirebaseRepositoryInterface) {
        self.repository = repository
        self.queueRepository = queueRepository
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

    func hobbyRequest(parameter: [String: Any], completion: @escaping (QueueNetworkError?) -> Void) {

        queueRepository.hobbyRequest(parameter: parameter) { [weak self] error in
            if let error = error {
                // 토큰 에러일 경우에만 파베 레포로 넘겨서 갱신요청.
                // 다른 에러면 그대로 뷰모델로 넘겨줌.
                // 성공하면 nil값 넘겨줌.
                switch error {
                case .firebaseIdTokenExpired:
                    self?.firebaseRepository.refreshIDToken {
                        self?.queueRepository.hobbyRequest(parameter: parameter, completion: { _ in
                            completion(nil)
                        })
                    }
                case .friendAlreadyRequest: print("friendAlreadyRequest") // 나중에 처리 ㄱ

                default: completion(error)
                }
            } else {
                completion(nil)
            }
        }
    }
}
