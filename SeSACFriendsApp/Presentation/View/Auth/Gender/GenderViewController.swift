//
//  GenderViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit

final class GenderViewController: BaseViewController {

    let mainView = GenderView()
    var viewModel = GenderViewModel()

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
