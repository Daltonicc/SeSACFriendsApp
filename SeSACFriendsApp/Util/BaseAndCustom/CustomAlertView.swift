//
//  WithdrawView.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/06.
//

import UIKit
import SnapKit

enum CustomAlertStyle: String {
    case withdraw
    case friendsRequest
    case friendsAccept
}

final class CustomAlertView: UIView, ViewRepresentable {

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

    var alertViewStyle: CustomAlertStyle = .withdraw {
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

        addSubview(alertView)

        alertView.addSubview(titleLabel)
        alertView.addSubview(subtitleLabel)
        alertView.addSubview(cancelButton)
        alertView.addSubview(okButton)
    }

    func setUpConfig() {

        switch alertViewStyle {
        case .withdraw:
            titleLabel.text = "정말 탈퇴하시겠습니까?"
            subtitleLabel.text = "탈퇴하시면 새싹 프렌즈를 이용할 수 없어요ㅠ"
        case .friendsRequest:
            titleLabel.text = "취미 같이 하기를 요청할게요!"
            subtitleLabel.text = "요청이 수락되면 30분 후에 리뷰를 남길 수 있어요"
        case .friendsAccept:
            titleLabel.text = "취미 같이 하기를 수락할까요?"
            subtitleLabel.text = "요청을 수락하면 채팅창에서 대화를 나눌 수 있어요"
        }
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
