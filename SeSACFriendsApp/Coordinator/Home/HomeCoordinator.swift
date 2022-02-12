//
//  HomeCoordinator.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/31.
//

import UIKit

final class HomeCoordinator: NSObject, Coordinator {

    weak var parentCoordinator: TabBarCoordinator?

    var presenter: UINavigationController
    var childCoordinators: [Coordinator]

    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.childCoordinators = []
    }

    func start() {

    }

    func showFindHobbyView(region: Int, yourLatitude: Double, yourLongitude: Double) {

        let findHobbyView = FindHobbyViewController()

        findHobbyView.viewModel = FindHobbyViewModel(coordinator: self,
                                                     yourRegion: region,
                                                     yourLatitude: yourLatitude,
                                                     yourLongitude: yourLongitude,
                                                     useCase: FindHobbyUseCase(
                                                        repository: QueueRepository(),
                                                        firebaseRepository: FirebaseRepository()))

        presenter.pushViewController(findHobbyView, animated: true)

    }

    func finish() {

        parentCoordinator?.childDidFinish(self, completion: {

        })
    }
}
