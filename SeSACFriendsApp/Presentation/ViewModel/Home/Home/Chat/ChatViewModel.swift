//
//  ChatViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/20.
//

import UIKit

final class ChatViewModel: ViewModel {

    weak var coordinator: HomeCoordinator?
    let useCase: ChatUseCase
    let otherUID: String

    var chatList: [ChatData] = []

    init(coordinator: HomeCoordinator, otherUID: String, useCase: ChatUseCase) {
        self.coordinator = coordinator
        self.otherUID = otherUID
        self.useCase = useCase
    }

    func postChat(completion: @escaping (String?) -> Void) {

        let parameter: [String: Any] = [
            "chat": "테스트"
        ]

        useCase.postChat(parameter: parameter, otherUID: otherUID) { [weak self] (result) in
            switch result {
            case let .success(data):
                self?.chatList.append(data)
                completion(nil)
            case let .failure(error):
                completion(error.errorDescription)
            }
        }
    }
}
