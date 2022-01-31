//
//  AppCoordinator.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/24.
//

import UIKit

final class AppCoordinator: NSObject, Coordinator {

    var presenter: UINavigationController
    var childCoordinators: [Coordinator]

    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        self.presenter = UINavigationController()
        self.childCoordinators = []
    }

    func start() {

        window.rootViewController = presenter

        let coordinator = AuthCoordinator(presenter: presenter)
        childCoordinators.append(coordinator)

        //최초 로그인 시에 온보딩 뷰
        coordinator.startOnboardingView()

        window.makeKeyAndVisible()
    }

    func startHome() {

        //홈뷰로 이동
        let tabBarController = HomeTabBarController()
        window.rootViewController = tabBarController

        let coordinator = HomeCoordinator(presenter: presenter)
        childCoordinators.append(coordinator)

        coordinator.start()
    }

    func childDidFinish(_ child: Coordinator?) {

        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

