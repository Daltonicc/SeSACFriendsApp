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
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    let saveBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "저장"
        barButton.tintColor = .black
        return barButton
    }()

    // MARK: - Card View

    let cardView: CustomCardView = {
        let view = CustomCardView()
        return view
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
        button.buttonState = .inactive
        button.layer.borderColor = UIColor.gray4.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = .body3r
        button.setTitleColor(.black, for: .normal)
        button.setTitle("남자", for: .normal)
        return button
    }()
    let womanButton: CustomButton = {
        let button = CustomButton()
        button.buttonState = .inactive
        button.layer.borderColor = UIColor.gray4.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = .body3r
        button.setTitleColor(.black, for: .normal)
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
        numberSwitch.onTintColor = .baseGreen
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
        label.textColor = .baseGreen
        return label
    }()
    let ageRangeSlider: RangeSeekSlider = {
        let slider = RangeSeekSlider()
        slider.minValue = 18
        slider.maxValue = 65
        slider.enableStep = true
        slider.step = 1
        slider.handleColor = .baseGreen
        slider.colorBetweenHandles = .baseGreen
        slider.tintColor = .gray2
        slider.hideLabels = true
        return slider
    }()
    let withDrawButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원 탈퇴", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .title4r
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpView()
        setUpConstraint()

//        cardView.cardButton.isHidden = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpView() {

        addSubview(scrollView)

        scrollView.addSubview(cardView)
        scrollView.addSubview(detailView)

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
        detailView.addSubview(withDrawButton)
    }

    func setUpConstraint() {

        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }

        // MARK: - Card View

        cardView.snp.makeConstraints { make in
            make.top.equalTo(scrollView)
            make.leading.equalTo(scrollView).inset(16)
            make.trailing.equalTo(scrollView).inset(16)
            make.height.equalTo(252)
            make.width.equalTo(UIScreen.main.bounds.width - 32)
        }

        // MARK: - Detail View

        detailView.snp.makeConstraints { make in
            make.top.equalTo(cardView.snp.bottom).offset(10)
            make.leading.equalTo(scrollView).inset(16)
            make.trailing.equalTo(scrollView).inset(16)
            make.bottom.equalTo(scrollView)
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
            make.width.equalTo(180)
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
        withDrawButton.snp.makeConstraints { make in
            make.top.equalTo(ageRangeSlider.snp.bottom)
            make.leading.equalToSuperview()
            make.height.equalTo(48)
            make.bottom.equalToSuperview()
        }
    }
}
