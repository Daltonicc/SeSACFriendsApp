//
//  BaseButton.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/20.
//

import UIKit

enum ButtonState: String {
    case inactive
    case fill
    case outline
    case cancel
    case disable
    case base
    case request
    case accept
}

final class CustomButton: UIButton {

    var buttonState: ButtonState = .inactive {
        didSet {
            setUpConfig()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpConfig()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpConfig() {

        backgroundColor = .white
        tintColor = .black
        layer.cornerRadius = 5
        layer.borderColor = UIColor.white.cgColor

        switch buttonState {
        case .inactive:
            self.layer.borderColor = UIColor.gray4.cgColor
            setTitleColor(.black, for: .normal)
        case .fill:
            tintColor = .white
            setTitleColor(.white, for: .normal)
            backgroundColor = .baseGreen
        case .outline:
            self.layer.borderColor = UIColor.baseGreen.cgColor
            tintColor = .baseGreen
        case .cancel:
            backgroundColor = .gray2
        case .disable:
            tintColor = .gray3
            backgroundColor = .gray6
        case .base:
            setTitleColor(.black, for: .normal)
        case .request:
            backgroundColor = .error
            setTitleColor(.white, for: .normal)
        case .accept:
            backgroundColor = .success
            setTitleColor(.white, for: .normal)
        }
    }
}
