//
//  GenderView.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit
import SnapKit

final class GenderView: UIView, ViewRepresentable {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "성별을 선택해 주세요"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .display1
        return label
    }()
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "새싹 찾기 기능을 이용하기 위해서 필요해요!"
        label.font = .title2r
        label.textColor = .gray7
        return label
    }()
    let manButton: CustomButton = {
        let button = CustomButton()
        button.buttonState = .outline
        button.setImage(UIImage(named: "ManImage"), for: .normal)
        return button
    }()
    let womanButton: CustomButton = {
        let button = CustomButton()
        button.buttonState = .outline
        button.setImage(UIImage(named: "WomanImage"), for: .normal)
        return button
    }()
    let nextButton: CustomButton = {
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
        addSubview(subTitleLabel)
        addSubview(manButton)
        addSubview(womanButton)
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
        manButton.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-32)
            make.leading.equalTo(self.snp.leading).inset(16)
            make.height.equalTo(120)
            make.width.equalTo(self).multipliedBy(0.45)
        }
        womanButton.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-32)
            make.leading.equalTo(manButton.snp.trailing).offset(12)
            make.trailing.equalTo(self.snp.trailing).inset(16)
            make.height.equalTo(120)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(manButton.snp.top).offset(-32)
            make.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subTitleLabel.snp.top).offset(-8)
            make.centerX.equalToSuperview()
        }
    }
}
