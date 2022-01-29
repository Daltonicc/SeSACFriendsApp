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
    var viewModel = GenderViewModel()

    let disposeBag = DisposeBag()

    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        print("idToken값: \(UserDefaults.standard.string(forKey: "uidToken")!)")
    }

    override func setViewConfig() {

        viewModel.checkValidation(manButton: mainView.manButton, womanButton: mainView.womanButton, nextButton: mainView.nextButton)

        mainView.nextButton.rx.tap
            .bind {
                self.addPressAnimationToButton(self.mainView.nextButton) { _ in
                    self.viewModel.checkButtonState(button: self.mainView.nextButton)
                }
            }
            .disposed(by: disposeBag)
    }
}
