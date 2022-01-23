//
//  Coordinator.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/23.
//

import Foundation
import UIKit

protocol Coordinator {

    var childCoordinators: [Coordinator] { get set}
    var nav: UINavigationController { get set }

    func startOnboardingVC()
    func startLoginVC()
    func startLogin2VC()
}

final class MainCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var nav: UINavigationController

    init(nav: UINavigationController) {
        self.nav = nav
    }

    func startOnboardingVC() {

        let vc = OnboardingViewController()
        vc.coordinator = self
        nav.pushViewController(vc, animated: true)
    }

    func startLoginVC() {

        let vc = LoginViewController()
        vc.coordinator = self
        nav.pushViewController(vc, animated: true)
    }

    func startLogin2VC() {

        let vc = Login2ViewController()
        vc.coordinator = self
        nav.pushViewController(vc, animated: true)
    }

}
