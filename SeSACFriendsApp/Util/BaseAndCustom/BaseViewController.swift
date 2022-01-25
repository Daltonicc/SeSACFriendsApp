//
//  BaseViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setViewConfig()
        textfieldConfig()
    }

    func setViewConfig() {
        view.backgroundColor = .white
    }

    func textfieldConfig() {}
}
