//
//  BirthView.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit
import SnapKit

final class BirthView: UIView, ViewRepresentable {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "생년월일을 입력해주세요"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .display1
        return label
    }()
    let yearTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView()
        textField.textFieldState = .inactive
        textField.mainTextField.isEnabled = false
        textField.mainTextField.placeholder = ""
        textField.mainTextField.text = "1990"
        return textField
    }()
    let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "년"
        label.font = .title2r
        label.textAlignment = .center
        return label
    }()
    let monthTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView()
        textField.textFieldState = .inactive
        textField.mainTextField.isEnabled = false
        textField.mainTextField.text = "1"
        return textField
    }()
    let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "월"
        label.font = .title2r
        label.textAlignment = .center
        return label
    }()
    let dayTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView()
        textField.textFieldState = .inactive
        textField.mainTextField.isEnabled = false
        textField.mainTextField.text = "1"
        return textField
    }()
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "일"
        label.font = .title2r
        label.textAlignment = .center
        return label
    }()
    let nextButton: CustomButton = {
        let button = CustomButton()
        button.buttonState = .disable
        button.setTitle("다음", for: .normal)
        return button
    }()
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        return datePicker
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
        addSubview(yearTextField)
        addSubview(yearLabel)
        addSubview(monthTextField)
        addSubview(monthLabel)
        addSubview(dayTextField)
        addSubview(dayLabel)
        addSubview(nextButton)
        addSubview(datePicker)
    }

    func setUpConstraint() {

        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(30)
            make.leading.equalTo(self.snp.leading).inset(16)
            make.trailing.equalTo(self.snp.trailing).inset(16)
            make.height.equalTo(48)
        }
        yearTextField.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-72)
            make.leading.equalTo(self.snp.leading).inset(16)
            make.height.equalTo(48)
            make.width.equalTo(self).multipliedBy(0.27)
        }
        yearLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-72)
            make.leading.equalTo(yearTextField.snp.trailing).offset(-10)
            make.height.equalTo(48)
        }
        monthTextField.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-72)
            make.leading.equalTo(yearLabel.snp.trailing).offset(5)
            make.height.equalTo(48)
            make.width.equalTo(self).multipliedBy(0.27)
        }
        monthLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-72)
            make.leading.equalTo(monthTextField.snp.trailing).offset(-10)
            make.height.equalTo(48)
        }
        dayTextField.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-72)
            make.leading.equalTo(monthLabel.snp.trailing)
            make.height.equalTo(48)
            make.width.equalTo(self).multipliedBy(0.28)
        }
        dayLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-72)
            make.leading.equalTo(dayTextField.snp.trailing).offset(-10)
            make.height.equalTo(48)
        }
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(yearTextField.snp.top).offset(-72)
            make.centerX.equalToSuperview()
        }
        datePicker.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }
}
