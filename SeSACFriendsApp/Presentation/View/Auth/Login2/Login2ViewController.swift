//
//  Login2ViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/24.
//

import UIKit

final class Login2ViewController: BaseViewController {

    weak var coordinator: MainCoordinator?
    let mainView = Login2View()
    let viewModel = LoginViewModel()

    override func loadView() {
        super.loadView()

        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setViewConfig() {
        super.setViewConfig()
        
    }
}
