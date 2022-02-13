//
//  FindFriendsViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/13.
//

import UIKit

final class FindFriendsViewController: BaseViewController {

    let mainView = FindFriendsView()
    var viewModel: FindFriendsViewModel?

    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .baseGreen
    }

    override func setViewConfig() {
        super.setViewConfig()

    }

    override func navigationItemConfig() {
        super.navigationItemConfig()

    }

}
