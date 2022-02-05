//
//  BaseViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/24.
//

import UIKit

class BaseViewController: UIViewController {

    let backBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.image = UIImage(systemName: "arrow.left")
        barButton.tintColor = .black
        return barButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewConfig()
        textfieldConfig()
        navigationItemConfig()
    }

    func setViewConfig() {
        view.backgroundColor = .white
    }

    func textfieldConfig() {}
    func navigationItemConfig() {}
}
