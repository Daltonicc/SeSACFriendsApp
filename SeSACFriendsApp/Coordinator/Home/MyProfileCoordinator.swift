//
//  MyProfileCoordinator.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/31.
//

import UIKit

final class MyProfileCoordinator: NSObject, Coordinator {

    weak var parentCoordinator: TabBarCoordinator?

    var presenter: UINavigationController
    var childCoordinators: [Coordinator]

    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.childCoordinators = []
    }

    func start() {
        
    }

    func showProfileView(userData: UserData) {

        let profileView = ProfileViewController()
        profileView.viewModel = ProfileViewModel(coordinator: self,
                                                 userData: userData,
                                                 useCase: ProfileUseCase(
                                                    repository: ProfileRepository()))
        presenter.pushViewController(profileView, animated: true)
    }

    func finish() {

        parentCoordinator?.childDidFinish(self, completion: {

        })
    }
}
