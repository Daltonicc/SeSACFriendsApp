//
//  UIButton+Extension.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/20.
//

import UIKit

extension UIButton {

    func buttonConfig(title: String, color: UIColor, isEnabled: Bool) {
        setTitle(title, for: .normal)
        self.isEnabled = isEnabled
        tintColor = color
    }
}
