//
//  LoginCoordinator.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/24.
//

import UIKit

final class LoginCoordinator: NSObject, Coordinator {

    var presenter: UINavigationController

    var childCoordinators: [Coordinator]

    var viewModel: LoginViewModel? // 수정 필요

    init(presenter: UINavigationController, viewModel: LoginViewModel? = LoginViewModel()) {
        self.presenter = presenter
        self.childCoordinators = []
//        self.viewModel = viewModel
    }

    func start() {

        let LoginView = LoginViewController()
//        LoginView.viewModel = viewModel
        presenter.pushViewController(LoginView, animated: true)
    }

}
