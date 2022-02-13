//
//  LoginView.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/23.
//
import UIKit
import SnapKit

final class LoginView: UIView, ViewRepresentable {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "새싹 서비스 이용을 위해\n휴대폰 번호를 입력해 주세요"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .display1
        return label
    }()
    let phoneNumberTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView()
        textField.textFieldState = .inactive
        textField.mainTextField.placeholder = "휴대폰 번호(-없이 숫자만 입력)"
        textField.mainTextField.keyboardType = .numberPad
        textField.mainTextField.text = ""
        return textField
    }()
    let authButton: CustomButton = {
        let button = CustomButton()
        button.buttonState = .disable
        button.setTitleColor(.white, for: .normal)
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
        addSubview(phoneNumberTextField)
        addSubview(authButton)
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
            make.trailing.equalTo(self.snp.trailing).inset(16)
            make.height.equalTo(48)
        }
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(phoneNumberTextField.snp.top).offset(-72)
            make.centerX.equalToSuperview()
        }
    }

}
