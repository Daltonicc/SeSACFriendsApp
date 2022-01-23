//
//  Login2View.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/23.
//

import UIKit
import SnapKit

final class Login2View: UIView, ViewRepresentable {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "새싹 서비스 이용을 위해\n휴대폰 번호를 입력해 주세요"
        label.textAlignment = .center
        label.font = .display1
        return label
    }()
    let subTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    let stackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    let phoneNumberTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView()
        textField.textFieldState = .inactive
        textField.mainTextField.placeholder = "휴대폰 번호(-없이 숫자만 입력)"
        textField.mainTextField.keyboardType = .numberPad
        return textField
    }()
    let limitTimeLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "05:00"
        return label
    }()
    let resendButton: CustomButton = {
        let button = CustomButton()
        button.isHidden = true
        button.buttonState = .fill
        button.setTitle("재전송", for: .normal)
        return button
    }()
    let authButton: CustomButton = {
        let button = CustomButton()
        button.buttonState = .disable
        button.setTitle("인증 문자 받기", for: .normal)
        return button
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

        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(stackView)
        addSubview(authButton)

        stackView.addSubview(phoneNumberTextField)
        stackView.addSubview(resendButton)

        phoneNumberTextField.addSubview(limitTimeLabel)
    }

    func setUpConstraint() {

    }

}
