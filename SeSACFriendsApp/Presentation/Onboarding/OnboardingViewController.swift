//
//  ViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/18.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {

    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        label.text = "테스트"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 100)
        label.textColor = .myGreen

        view.addSubview(label)

        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

    }
}
