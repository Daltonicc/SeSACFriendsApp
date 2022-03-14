//
//  ChatUseCase.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/21.
//

import Foundation

final class ChatUseCase {

    let repository: ChatRepositoryInterface
    let firebaseRepository: FirebaseRepositoryInterface

    init(repository: ChatRepositoryInterface, firebaseRepository: FirebaseRepositoryInterface) {
        self.repository = repository
        self.firebaseRepository = firebaseRepository
    }

    func postChat(parameter: [String: Any], otherUID: String, completion: @escaping (Result<ChatData, ChatError>) -> Void) {

        repository.postChat(parameter: parameter, otherUID: otherUID) { [weak self] (result) in
            switch result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                if error == .firebaseIdTokenExpired {
                    self?.firebaseRepository.refreshIDToken {
                        self?.repository.postChat(parameter: parameter, otherUID: otherUID, completion: { (result) in
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
}
