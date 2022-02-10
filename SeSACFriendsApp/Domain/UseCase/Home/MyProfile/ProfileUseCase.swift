//
//  ProfileUseCase.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/05.
//

import UIKit

final class ProfileUseCase {

    let repository: UserRepository
    let firebaseRepository: FirebaseRepository

    init(repository: UserRepository, firebaseRepository: FirebaseRepository) {
        self.repository = repository
        self.firebaseRepository = firebaseRepository
    }

    func getUserData(completion: @escaping (Result<UserData, UserNetworkError>) -> Void) {
        repository.getUserInfo { (result) in
            switch result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                //파베 토큰 만료면 토큰 갱신 요청
                if error == .firebaseIdTokenExpired {
                    self.firebaseRepository.refreshIDToken {
                        self.repository.getUserInfo(completion: { (result) in
                            switch result {
                            case let .success(data): completion(.success(data))
                            case let .failure(error): completion(.failure(error))
                            }
                        })
                    }
                } else {
                    completion(.failure(error))
                }
            }
        }
    }

    func updateUserData(parameter: [String: Any], completion: @escaping (UserNetworkError?) -> Void) {

        repository.updateUserData(parameter: parameter) { [weak self] error in
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
