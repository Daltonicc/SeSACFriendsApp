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

    init(coordinator: HomeCoordinator, useCase: ChatUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
}
