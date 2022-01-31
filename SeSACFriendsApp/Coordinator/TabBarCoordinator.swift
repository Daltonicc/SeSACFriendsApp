//
//  HomeCoordinator.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/31.
//

import UIKit

final class TabBarCoordinator: NSObject, Coordinator {

    weak var parentCoordinator: AppCoordinator?

    var presenter: UINavigationController
    var childCoordinators: [Coordinator]

    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.childCoordinators = []
    }

    func start() {

        let tabBarController = UITabBarController()

        let homeViewController = UINavigationController(rootViewController: HomeViewController())
//        homeViewController = UIImage(named: "First")
        homeViewController.tabBarItem.title = "홈"
        let homeCoordinator = HomeCoordinator(presenter: homeViewController)
        homeCoordinator.parentCoordinator = self
        childCoordinators.append(homeCoordinator)

        let shopViewController = UINavigationController(rootViewController: ShopViewController())
//        shopViewController = UIImage(named: "Second")
        shopViewController.tabBarItem.title = "새싹샵"
        let shopCoordinator = ShopCoordinator(presenter: shopViewController)
        shopCoordinator.parentCoordinator = self
        childCoordinators.append(shopCoordinator)

        let friendsViewController = UINavigationController(rootViewController: FriendsViewController())
//        friendsViewController = UIImage(named: "Third")
        friendsViewController.tabBarItem.title = "새싹친구"
        let friendsCoordinator = FriendsCoordinator(presenter: friendsViewController)
        friendsCoordinator.parentCoordinator = self
        childCoordinators.append(friendsCoordinator)

        let myProfileViewController = UINavigationController(rootViewController: MyProfileViewController())
//        myProfileViewController = UIImage(named: "Fourth")
        myProfileViewController.tabBarItem.title = "내정보"
        let myProfileCoordinator = MyProfileCoordinator(presenter: myProfileViewController)
        myProfileCoordinator.parentCoordinator = self
        childCoordinators.append(myProfileCoordinator)

        tabBarController.viewControllers = [homeViewController, shopViewController, friendsViewController, myProfileViewController]

        presenter.pushViewController(tabBarController, animated: true)
    }

    func childDidFinish(_ child: Coordinator?, completion: () -> Void) {

        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                completion()
                break
            }
        }
    }

    func finish() {

        parentCoordinator?.childDidFinish(self, completion: {

        })
    }
}
