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
        label.text = "인증번호가 문자로 전송되었어요"
        label.textAlignment = .center
        label.font = .display1
        return label
    }()
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "(최대 소모 20초)"
        label.font = .title2r
        label.textColor = .gray7
        return label
    }()
    let phoneNumberTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView()
        textField.textFieldState = .inactive
        textField.mainTextField.placeholder = "인증번호 입력"
        textField.mainTextField.keyboardType = .numberPad
        return textField
    }()
    let limitTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "05:00"
        label.textColor = .baseGreen
        label.font = .title3m
        return label
    }()
    let resendButton: CustomButton = {
        let button = CustomButton()
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
        addSubview(phoneNumberTextField)
        addSubview(resendButton)
        addSubview(authButton)
        addSubview(limitTimeLabel)

//        phoneNumberTextField.addSubview(limitTimeLabel)
    }

    func setUpConstraint() {

        authButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(30)
            make.leading.equalTo(self.snp.leading).inset(16)
            make.trailing.equalTo(self.snp.trailing).inset(16)
            make.height.equalTo(48)
        }
        phoneNumberTextField.snp.makeConstraints { make in
            make.bottom.equalTo(authButton.snp.top).offset(-72)
            make.leading.equalTo(self.snp.leading).inset(16)
            make.trailing.equalTo(resendButton.snp.leading)
            make.height.equalTo(40)
        }
        resendButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing).inset(16)
            make.bottom.equalTo(authButton.snp.top).offset(-72)
            make.height.equalTo(40)
            make.width.equalTo(72)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(phoneNumberTextField.snp.top).offset(-72)
            make.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subTitleLabel.snp.top).offset(-8)
            make.centerX.equalToSuperview()
        }
//        limitTimeLabel.snp.makeConstraints { make in
//            make.top.equalTo(self.snp.top).inset(5)
//            make.trailing.equalTo(self.snp.trailing).inset(10)
//            make.width.equalTo(20)
//        }
        limitTimeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(authButton.snp.top).offset(-72)
            make.trailing.equalTo(resendButton.snp.leading).offset(-25)
            make.height.equalTo(40)
        }
    }

}
