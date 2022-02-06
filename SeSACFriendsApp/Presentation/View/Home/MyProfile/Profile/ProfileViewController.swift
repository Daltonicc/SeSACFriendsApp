//
//  ProfileViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/05.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import RangeSeekSlider

final class ProfileViewController: BaseViewController {

    let mainView = ProfileView()
    var viewModel: ProfileViewModel?

    let disposeBag = DisposeBag()

    deinit {
        print("Profile Deinit")
    }

    override func loadView() {
        super.loadView()

        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        withdrawButtonConfig()
    }

    override func setViewConfig() {
        super.setViewConfig()

        mainView.ageRangeSlider.delegate = self

        mainView.nameLabel.text = viewModel?.userData?.yourName
        mainView.hobbyTextField.mainTextField.text = viewModel?.userData?.hobby
        mainView.ageRangeLabel.text = "\(viewModel!.userData!.ageMin) - \(viewModel!.userData!.ageMax)"

        switch viewModel?.userData?.gender {
        case 0:
            mainView.womanButton.backgroundColor = .baseGreen
            mainView.womanButton.setTitleColor(.white, for: .normal)
        case 1:
            mainView.manButton.backgroundColor = .baseGreen
            mainView.manButton.setTitleColor(.white, for: .normal)
        default: print("Gender Default")
        }

        if viewModel?.userData?.numberSearchable == 1 {
            mainView.numberSearchSwitch.isOn = true
        }

        mainView.ageRangeSlider.selectedMinValue = CGFloat(viewModel!.userData!.ageMin)
        mainView.ageRangeSlider.selectedMaxValue = CGFloat(viewModel!.userData!.ageMax)

        viewModel?.checkGender(manButton: mainView.manButton, womanButton: mainView.womanButton)
        viewModel?.checkHobby(textField: mainView.hobbyTextField.mainTextField)
        viewModel?.checkNumberSearchable(searchSwitch: mainView.numberSearchSwitch)
    }

    override func textfieldConfig() {
        super.textfieldConfig()

        mainView.hobbyTextField.mainTextField.delegate = self
        mainView.hobbyTextField.mainTextField.addTarget(self, action: #selector(nicknameTextFieldDidChange(textfield:)), for: .editingChanged)
    }

    override func navigationItemConfig() {

        navigationItem.title = "정보 관리"
        navigationItem.leftBarButtonItem = backBarButton
        navigationItem.rightBarButtonItem = mainView.saveBarButton

        backBarButton.target = self
        backBarButton.rx.tap
            .bind { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)

        mainView.saveBarButton.target = self
        mainView.saveBarButton.rx.tap
            .bind { [weak self] in
                self?.viewModel?.updateUserData {
                    self?.navigationController?.popViewController(animated: true)
                }
            }
            .disposed(by: disposeBag)
    }

    func withdrawButtonConfig() {

        mainView.withDrawButton.rx.tap
            .bind { [weak self] in
                self?.viewModel?.withdrawUserData()
            }
            .disposed(by: disposeBag)
    }

    @objc func nicknameTextFieldDidChange(textfield: UITextField) {

        checkMaxLength(textField: mainView.hobbyTextField.mainTextField, maxLength: 10)
    }
}

extension ProfileViewController: RangeSeekSliderDelegate {

    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {

        viewModel?.userData?.ageMin = Int(minValue)
        viewModel?.userData?.ageMax = Int(maxValue)
        mainView.ageRangeLabel.text = "\(Int(minValue)) - \(Int(maxValue))"
    }

}

extension ProfileViewController: UITextFieldDelegate {

    func checkMaxLength(textField: UITextField, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        mainView.hobbyTextField.textFieldState = .focus

    }

    func textFieldDidEndEditing(_ textField: UITextField) {

        mainView.hobbyTextField.textFieldState = .active
    }
}
