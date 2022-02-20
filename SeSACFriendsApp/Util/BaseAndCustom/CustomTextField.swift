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
    case chat
    case chatFocus
    case error
    case success
}

final class CustomTextFieldView: UIView {

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
    var sendButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Home.Chat.sendImage.image, for: .normal)
        return button
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
        addSubview(sendButton)
        
    }

    func setUpConfig() {

        statusLabel.isHidden = true
        mainTextField.isEnabled = true
        sendButton.isHidden = true

        switch textFieldState {
        case .inactive:
            animatedColor(color: .gray3)
        case .focus:
            animatedColor(color: .focus)
        case .active:
            animatedColor(color: .gray3)
        case .chat:
            lineView.isHidden = true
            mainTextField.backgroundColor = .gray1
            mainTextField.placeholder = "메세지를 입력하세요"
            sendButton.isHidden = false
            sendButton.setImage(Asset.Home.Chat.sendImage.image.resized(to: CGSize(width: 30, height: 30)), for: .normal)
            layer.cornerRadius = 10
            backgroundColor = .gray1

            mainTextField.snp.remakeConstraints { make in
                make.leading.equalTo(self.snp.leading).inset(16)
                make.centerY.equalToSuperview()
            }
        case .chatFocus:
            sendButton.setImage(Asset.Home.Chat.sendFillImage.image.resized(to: CGSize(width: 30, height: 30)), for: .normal)
        case .error:
            animatedColor(color: .error)
            statusLabel.isHidden = false
        case .success:
            animatedColor(color: .success)
            statusLabel.isHidden = false
        }
    }

    func animatedColor(color: UIColor) {

        UIView.animate(withDuration: 0.1,
                       delay: 0.0,
                       options: .allowAnimatedContent,
                       animations: { self.lineView.backgroundColor = color }, completion: nil)
    }

    func setUpConstraint() {

        mainTextField.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).inset(16)
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
        sendButton.snp.makeConstraints { make in
            make.leading.equalTo(mainTextField.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
}
