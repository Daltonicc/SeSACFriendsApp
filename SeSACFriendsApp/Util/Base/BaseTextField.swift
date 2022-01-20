//
//  CustomTextField.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/20.
//

import UIKit
import SnapKit

enum TextFieldState: String {
    case inactive
    case focus
    case active
    case disable
    case error
    case success
}

class BaseTextFieldView: UIView {

    var mainTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Placeholder"
        textfield.borderStyle = .none
        textfield.layer.cornerRadius = 5
        textfield.addLeftPadding()
        return textfield
    }()
    var lineView: UIView = {
        let view = UIView()
        return view
    }()
    var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = "실패 이유"
        label.isHidden = true
        return label
    }()

    var textFieldState: TextFieldState = .inactive {
        didSet {
            setUpConfig()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpView()
        setUpConfig()
        setUpConstraint()

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }

    func setUpView() {

        addSubview(mainTextField)
        addSubview(lineView)
        addSubview(statusLabel)
        
    }

    func setUpConfig() {

        statusLabel.isHidden = true
        mainTextField.isEnabled = true

        switch textFieldState {
        case .inactive:
            animatedColor(color: .gray3)
        case .focus:
            animatedColor(color: .focus)
        case .active:
            animatedColor(color: .gray3)
        case .disable:
            lineView.backgroundColor = .white
            mainTextField.backgroundColor = .gray3
            mainTextField.isEnabled = false
        case .error:
            animatedColor(color: .error)
            statusLabel.isHidden = false
        case .success:
            animatedColor(color: .success)
            statusLabel.isHidden = false
        }
    }

    func animatedColor(color: UIColor) {

        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: .allowAnimatedContent,
                       animations: { self.lineView.backgroundColor = color }, completion: nil)
    }

    func setUpConstraint() {

        mainTextField.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).inset(16)
            make.trailing.equalTo(self.snp.trailing).inset(16)
            make.top.equalTo(self.snp.top).inset(10)
        }
        lineView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).inset(16)
            make.trailing.equalTo(self.snp.trailing).inset(16)
            make.top.equalTo(mainTextField.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).inset(16)
            make.trailing.equalTo(self.snp.trailing).inset(16)
            make.top.equalTo(lineView.snp.bottom).offset(16)
        }
    }
}
