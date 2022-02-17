//
//  AlertViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/06.
//

import UIKit
import RxSwift
import RxCocoa

final class AlertViewController: BaseViewController {

    let mainView = CustomAlertView()

    var viewModel: AlertViewModel?

    override func loadView() {
        super.loadView()

        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black.withAlphaComponent(0.5)
    }

    override func buttonConfig() {
        super.buttonConfig()

        switch mainView.alertViewStyle {
        case .withdraw:
            mainView.okButton.rx.tap
                .bind { [weak self] in
                    self?.addPressAnimationToButton(self?.mainView.okButton ?? CustomButton(), completion: { [weak self] _ in
                        self?.viewModel?.withdrawUserData(completion: { [weak self] message in
                            self?.mainView.makeToast(message)
                        })
                    })
                }
                .disposed(by: disposeBag)

        case .friendsRequest:
            mainView.okButton.rx.tap
                .bind { [weak self] in
                    self?.addPressAnimationToButton(self?.mainView.okButton ?? CustomButton(), completion: { [weak self] _ in
                        self?.viewModel?.hobbyRequest(completion: { [weak self] message in
                            self?.mainView.makeToast(message, duration: 0.5, completion: { [weak self] _ in
                                self?.dismiss(animated: true, completion: nil)
                            })
                        })
                    })
                }
                .disposed(by: disposeBag)
            
        case .friendsAccept:
            mainView.okButton.rx.tap
                .bind { [weak self] in
                    self?.addPressAnimationToButton(self?.mainView.okButton ?? CustomButton(), completion: { [weak self] _ in

                    })
                }
                .disposed(by: disposeBag)
        }

        mainView.cancelButton.rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
}
