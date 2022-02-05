//
//  ProfileView.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/01.
//

import UIKit
import SnapKit
import RangeSeekSlider

final class ProfileView: UIView, ViewRepresentable {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()

    // MARK: - Card View

    let cardView: UIView = {
        let view = UIView()
        return view
    }()
    let cardBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.ProfileDetail.seSACBackground.image
        return imageView
    }()
    let cardSesacImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.ProfileDetail.seSACImage.image
        return imageView
    }()
    let titleView: UIView = {
        let view = UIView()
        return view
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "김새싹"
        label.font = .title1m
        return label
    }()
    let detailButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        return button
    }()

    // MARK: - Detail View

    let detailView: UIView = {
        let view = UIView()
        return view
    }()
    let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "내 성별"
        label.font = .title4r
        return label
    }()
    let manButton: CustomButton = {
        let button = CustomButton()
        button.titleLabel?.font = .title4r
        button.setTitle("남자", for: .normal)
        return button
    }()
    let womanButton: CustomButton = {
        let button = CustomButton()
        button.titleLabel?.font = .title4r
        button.setTitle("여자", for: .normal)
        return button
    }()
    let hobbyLabel: UILabel = {
        let label = UILabel()
        label.text = "자주 하는 취미"
        label.font = .title4r
        return label
    }()
    let hobbyTextField: CustomTextFieldView = {
        let textfield = CustomTextFieldView()
        textfield.mainTextField.textColor = .black
        textfield.mainTextField.font = .title4r
        textfield.mainTextField.placeholder = "취미를 입력해 주세요"
        return textfield
    }()
    let numberSearchLabel: UILabel = {
        let label = UILabel()
        label.text = "내 번호 검색 허용"
        label.font = .title4r
        return label
    }()
    let numberSearchSwitch: UISwitch = {
        let numberSwitch = UISwitch()
        numberSwitch.thumbTintColor = .white
        numberSwitch.onTintColor = .green
        return numberSwitch
    }()
    let ageLabel: UILabel = {
        let label = UILabel()
        label.font = .title4r
        label.text = "상대방 연령대"
        return label
    }()
    let ageRangeLabel: UILabel = {
        let label = UILabel()
        label.font = .title3m
        label.text = "18 - 65"
        label.textColor = .green
        return label
    }()
    let ageRangeSlider: RangeSeekSlider = {
        let slider = RangeSeekSlider()
        slider.minValue = 18
        slider.maxValue = 65
        slider.enableStep = true
        slider.step = 1
        slider.handleColor = .green
        slider.colorBetweenHandles = .green
        slider.tintColor = .gray2
        slider.hideLabels = true
        return slider
    }()
    let withDrawLabel: UIButton = {
        let button = UIButton()
        button.setTitle("회원 탈퇴", for: .normal)
        button.titleLabel?.font = .title4r
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

        addSubview(scrollView)

        scrollView.addSubview(cardView)
        scrollView.addSubview(detailView)

        cardView.addSubview(cardBackgroundImageView)
        cardView.addSubview(cardSesacImageView)
        cardView.addSubview(titleView)

            titleView.addSubview(nameLabel)
            titleView.addSubview(detailButton)

        detailView.addSubview(genderLabel)
        detailView.addSubview(manButton)
        detailView.addSubview(womanButton)
        detailView.addSubview(hobbyLabel)
        detailView.addSubview(hobbyTextField)
        detailView.addSubview(numberSearchLabel)
        detailView.addSubview(numberSearchSwitch)
        detailView.addSubview(ageLabel)
        detailView.addSubview(ageRangeLabel)
        detailView.addSubview(ageRangeSlider)
        detailView.addSubview(withDrawLabel)
    }

    func setUpConstraint() {

        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }

        // MARK: - Card View

        cardView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.leading.equalTo(self).inset(16)
            make.trailing.equalTo(self).inset(16)
            make.height.equalTo(252)
        }
        cardBackgroundImageView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(194)
        }


        // MARK: - Detail View

        detailView.snp.makeConstraints { make in
            make.top.equalTo(cardView.snp.bottom).offset(10)
            make.leading.equalTo(self).inset(16)
            make.trailing.equalTo(self).inset(16)
            make.bottom.equalTo(self)
        }

        genderLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(womanButton)
            make.trailing.equalTo(manButton.snp.leading).offset(8)
            make.height.equalTo(48)
        }
        manButton.snp.makeConstraints { make in
            make.trailing.equalTo(womanButton.snp.leading).inset(-8)
            make.top.equalTo(womanButton)
            make.width.equalTo(56)
            make.height.equalTo(48)
        }
        womanButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(28)
            make.width.equalTo(56)
            make.height.equalTo(48)
        }
        hobbyLabel.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalTo(hobbyTextField.snp.leading).offset(8)
            make.height.equalTo(48)
        }
        hobbyTextField.snp.makeConstraints { make in
            make.top.equalTo(hobbyLabel)
            make.trailing.equalToSuperview()
            make.width.equalTo(160)
            make.height.equalTo(48)
        }
        numberSearchLabel.snp.makeConstraints { make in
            make.top.equalTo(hobbyLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalTo(numberSearchSwitch.snp.leading).offset(8)
            make.height.equalTo(48)
        }
        numberSearchSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(numberSearchLabel)
            make.trailing.equalToSuperview()
            make.height.equalTo(28)
            make.width.equalTo(52)
        }
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(numberSearchLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalTo(ageRangeLabel.snp.leading).offset(8)
            make.height.equalTo(48)
        }
        ageRangeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ageLabel)
            make.trailing.equalToSuperview()
            make.width.equalTo(50)
        }
        ageRangeSlider.snp.makeConstraints { make in
            make.top.equalTo(ageLabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        withDrawLabel.snp.makeConstraints { make in
            make.top.equalTo(ageRangeSlider.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
            make.bottom.equalToSuperview()
        }
    }
}
