//
//  BaseButton.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/20.
//

import UIKit

class BaseButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpConfig()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpConfig() {

    }
}
