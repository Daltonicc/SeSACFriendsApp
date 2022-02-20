//
//  ChatView.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/20.
//

import UIKit
import SnapKit

final class ChatView: UIView, ViewRepresentable {

    let plusMenuBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.image = Asset.Home.Chat.plusMenuImage.image.resized(to: CGSize(width: 20, height: 20))
        barButton.tintColor = .black
        return barButton
    }()
    let plusView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    let menuView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .red
        return stackView
    }()
    let reportButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Home.Chat.reportImage.image, for: .normal)
        return button
    }()
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Home.Chat.cancelImage.image, for: .normal)
        return button
    }()
    let reviewButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Home.Chat.reviewImage.image, for: .normal)
        return button
    }()
    let chatTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    let chatTextView: CustomTextFieldView = {
        let textView = CustomTextFieldView()
        textView.textFieldState = .chat
        return textView
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

        addSubview(chatTableView)
        addSubview(chatTextView)
        addSubview(plusView)
        plusView.addSubview(menuView)
        menuView.addArrangedSubview(reportButton)
        menuView.addArrangedSubview(cancelButton)
        menuView.addArrangedSubview(reviewButton)
    }

    func setUpConstraint() {

        plusView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
        chatTableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(chatTextView.snp.top).offset(16)
        }
        chatTextView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(52)
        }

        // MARK: - PlusView

        menuView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(72)
        }

    }
}
