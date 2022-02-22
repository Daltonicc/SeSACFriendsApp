//
//  ChatViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/20.
//

import UIKit

final class ChatViewModel: ViewModel {

    weak var coordinator: Coordinator?
    let useCase: ChatUseCase
    let yourUID: String
    let otherUID: String

    var chatList: [ChatData] = []

    init(coordinator: Coordinator, yourUID: String, otherUID: String, useCase: ChatUseCase) {
        self.coordinator = coordinator
        self.yourUID = yourUID
        self.otherUID = otherUID
        self.useCase = useCase
    }

    func postChat(chatMessage: String, completion: @escaping (String?) -> Void) {

        let parameter: [String: Any] = [
            "chat": chatMessage
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
