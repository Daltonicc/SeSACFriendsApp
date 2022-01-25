//
//  EmailView.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit
import SnapKit

final class EmailView: UIView, ViewRepresentable {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임을 입력해 주세요"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .display1
        return label
    }()
    let nicknameTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView()
        textField.textFieldState = .inactive
        textField.mainTextField.placeholder = "10자 이내로 입력"
        textField.mainTextField.text = ""
        return textField
    }()
    let authButton: CustomButton = {
        let button = CustomButton()
        button.buttonState = .disable
        button.setTitle("다음", for: .normal)
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
        addSubview(nicknameTextField)
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
        nicknameTextField.snp.makeConstraints { make in
            make.bottom.equalTo(authButton.snp.top).offset(-72)
            make.leading.equalTo(self.snp.leading).inset(16)
            make.trailing.equalTo(self.snp.trailing).inset(16)
            make.height.equalTo(48)
        }
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nicknameTextField.snp.top).offset(-72)
            make.centerX.equalToSuperview()
        }
    }
}
