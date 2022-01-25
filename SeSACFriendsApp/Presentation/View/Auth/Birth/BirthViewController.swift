//
//  BirthViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit

final class BirthViewController: BaseViewController {

    let mainView = BirthView()
    var viewModel = BirthViewModel()

    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setViewConfig() {

    }

    override func textfieldConfig() {

    }
}
