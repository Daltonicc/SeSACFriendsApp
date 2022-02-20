//
//  ChatView.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/20.
//

import UIKit

final class ChatView: UIView, ViewRepresentable {

    let plusMenuBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()

        return barButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraint()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpView() {

    }

    func setUpConstraint() {

    }
}
