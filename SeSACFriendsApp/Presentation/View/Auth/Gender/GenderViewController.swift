//
//  GenderViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit
import RxSwift
import RxCocoa

/*
 구현해야할 것

 1. 상황별 토스트 메세지

 */
final class GenderViewController: BaseViewController {

    let mainView = GenderView()
    var viewModel: GenderViewModel?

    let disposeBag = DisposeBag()

    deinit {
        print("Gender Deinit")
    }

    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }

    override func setViewConfig() {

        viewModel?.checkValidation(manButton: mainView.manButton, womanButton: mainView.womanButton, nextButton: mainView.nextButton)

        mainView.nextButton.rx.tap
            .bind { [weak self] in
                self?.addPressAnimationToButton(self?.mainView.nextButton ?? CustomButton()) { [weak self] _ in
                    self?.viewModel?.checkButtonState(
                        button: self?.mainView.nextButton ?? CustomButton(),
                        completion: { [weak self] message in
                            self?.mainView.makeToast(message)
                    })
                }
            }
            .disposed(by: disposeBag)
    }

    override func navigationItemConfig() {

        navigationItem.leftBarButtonItem = backBarButton

        backBarButton.target = self
        backBarButton.rx.tap
            .bind { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
