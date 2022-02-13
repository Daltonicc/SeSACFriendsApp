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
        label.text = "이메일을 입력해 주세요"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .display1
        return label
    }()
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "휴대폰 번호 변경 시 인증을 위해 사용해요"
        label.font = .title2r
        label.textColor = .gray7
        return label
    }()
    let emailTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView()
        textField.textFieldState = .inactive
        textField.mainTextField.placeholder = "SeSAC@email.com"
        textField.mainTextField.text = ""
        return textField
    }()
    let nextButton: CustomButton = {
        let button = CustomButton()
        button.buttonState = .disable
        button.setTitleColor(.white, for: .normal)
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
        addSubview(subTitleLabel)
        addSubview(emailTextField)
        addSubview(nextButton)
    }

    func setUpConstraint() {

        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(30)
            make.leading.equalTo(self.snp.leading).inset(16)
            make.trailing.equalTo(self.snp.trailing).inset(16)
            make.height.equalTo(48)
        }
        emailTextField.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-72)
            make.leading.equalTo(self.snp.leading).inset(16)
            make.trailing.equalTo(self.snp.trailing).inset(16)
            make.height.equalTo(48)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(emailTextField.snp.top).offset(-72)
            make.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subTitleLabel.snp.top).offset(-8)
            make.centerX.equalToSuperview()
        }
    }
}
