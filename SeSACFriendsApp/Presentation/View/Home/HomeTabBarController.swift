//
//  HomeTabBarController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/31.
//

import UIKit

final class HomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTabBar()
    }

    func setUpTabBar() {

        let homeViewController = UINavigationController(rootViewController: HomeViewController())
//        homeViewController = UIImage(named: "First")
        homeViewController.tabBarItem.title = "홈"

        let shopViewController = UINavigationController(rootViewController: ShopViewController())
//        shopViewController = UIImage(named: "Second")
        shopViewController.tabBarItem.title = "새싹샵"

        let friendsViewController = UINavigationController(rootViewController: FriendsViewController())
//        friendsViewController = UIImage(named: "Third")
        friendsViewController.tabBarItem.title = "새싹친구"

        let myProfileViewController = UINavigationController(rootViewController: MyProfileViewController())
//        myProfileViewController = UIImage(named: "Fourth")
        myProfileViewController.tabBarItem.title = "내정보"

        viewControllers = [homeViewController, shopViewController, friendsViewController, myProfileViewController]
    }
}
