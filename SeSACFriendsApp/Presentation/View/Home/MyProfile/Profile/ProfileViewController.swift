//
//  ProfileViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/05.
//

import UIKit

final class ProfileViewController: BaseViewController {

    let mainView = ProfileView()

    override func loadView() {
        super.loadView()

        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "정보 관리"
    }

    override func setViewConfig() {
        super.setViewConfig()

    }

    override func textfieldConfig() {
        super.textfieldConfig()
        
    }
}
