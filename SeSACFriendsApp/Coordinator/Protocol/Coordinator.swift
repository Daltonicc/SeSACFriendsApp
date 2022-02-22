//
//  Coordinator.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/23.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {

    var presenter: UINavigationController { get set }

    var childCoordinators: [Coordinator] { get set }

    func start()
    func finish()

}

extension Coordinator {

    // alert 관련 메서드들
    func showAlertView(alertStyle: CustomAlertStyle, friendsID: String?) {

        let alertView = AlertViewController()

        alertView.viewModel = AlertViewModel(coordinator: self,
                                                   useCase: AlertUseCase(
                                                    repository: UserRepository(),
                                                    queueRepository: QueueRepository(),
                                                    firebaseRepository: FirebaseRepository()))
        alertView.viewModel?.friendsID = friendsID
        alertView.mainView.alertViewStyle = alertStyle
        alertView.modalTransitionStyle = .crossDissolve
        alertView.modalPresentationStyle = .overCurrentContext

        presenter.present(alertView, animated: true, completion: nil)
    }

    // Chat
    func showChatView() {

        let chatView = ChatViewController()

        chatView.viewModel = ChatViewModel(coordinator: self,
                                           yourUID: UserDefaultsRepository.fetchYourUIDForChat(),
                                           otherUID: UserDefaultsRepository.fetchOtherUIDForChat(),
                                           useCase: ChatUseCase(repository: ChatRepository(),
                                                                firebaseRepository: FirebaseRepository()))
        presenter.pushViewController(chatView, animated: true)
    }
}
