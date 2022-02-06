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

        // 유저 데이터 같이 넘겨주기
        profileView.viewModel = ProfileViewModel(coordinator: self,
                                                 userData: userData,
                                                 useCase: ProfileUseCase(
                                                    repository: ProfileRepository()))
        presenter.pushViewController(profileView, animated: true)
    }

    func showWithdrawView() {

        let withdrawView = WithdrawViewController()

        withdrawView.viewModel = WithdrawViewModel(coordinator: self,
                                                   useCase: WithdrawUseCase(
                                                    repository: WithdrawRepository()))
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
