//
//  WithdrawView.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/06.
//

import UIKit
import SnapKit

final class WithdrawView: UIView, ViewRepresentable {

    let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .body1m
        label.text = "정말 탈퇴하시겠습니까?"
        return label
    }()
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .title4r
        label.text = "탈퇴하시면 새싹 프렌즈를 이용할 수 없어요ㅠ"
        return label
    }()
    let cancelButton: CustomButton = {
        let button = CustomButton()
        button.buttonState = .cancel
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    let okButton: CustomButton = {
        let button = CustomButton()
        button.buttonState = .fill
        button.setTitle("확인", for: .normal)
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

        addSubview(alertView)

        alertView.addSubview(titleLabel)
        alertView.addSubview(subtitleLabel)
        alertView.addSubview(cancelButton)
        alertView.addSubview(okButton)
    }

    func setUpConstraint() {

        alertView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.height.equalTo(156)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        cancelButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.equalTo(okButton.snp.leading).offset(-8)
            make.width.equalTo(okButton)
            make.height.equalTo(48)
        }

        okButton.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(cancelButton)
            make.height.equalTo(48)
        }
    }
}
