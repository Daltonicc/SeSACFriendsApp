//
//  WithdrawViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/06.
//

import UIKit
import RxSwift
import RxCocoa

final class WithdrawViewController: BaseViewController {

    let mainView = CustomAlertView()

    var viewModel: WithdrawViewModel?

    let disposeBag = DisposeBag()

    override func loadView() {
        super.loadView()

        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black.withAlphaComponent(0.5)
    }

    override func setViewConfig() {
        super.setViewConfig()

        mainView.okButton.rx.tap
            .bind { [weak self] in
                self?.addPressAnimationToButton(self?.mainView.okButton ?? CustomButton(), completion: { [weak self] _ in
                    self?.viewModel?.withdrawUserData(completion: { [weak self] message in
                        self?.mainView.makeToast(message)
                    })
                })
            }
            .disposed(by: disposeBag)

        mainView.cancelButton.rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
}
