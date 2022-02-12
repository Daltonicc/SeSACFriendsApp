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

    func showProfileView() {

        let profileView = ProfileViewController()

        profileView.viewModel = ProfileViewModel(coordinator: self,
                                                 useCase: ProfileUseCase(
                                                    repository: UserRepository(),
                                                    firebaseRepository: FirebaseRepository()))
        presenter.pushViewController(profileView, animated: true)
    }

    func showWithdrawView() {

        let withdrawView = WithdrawViewController()

        withdrawView.viewModel = WithdrawViewModel(coordinator: self,
                                                   useCase: WithdrawUseCase(
                                                    repository: UserRepository(),
                                                    firebaseRepository: FirebaseRepository()))
        withdrawView.modalTransitionStyle = .crossDissolve
        withdrawView.modalPresentationStyle = .overCurrentContext

        presenter.present(withdrawView, animated: true, completion: nil)
    }

    func finish() {

        parentCoordinator?.childDidFinish(self, completion: { [weak self] in
            self?.parentCoordinator?.finish()
        })
    }
}
