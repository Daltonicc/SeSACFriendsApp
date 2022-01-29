//
//  GenderViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/25.
//

import UIKit
import RxSwift
import RxCocoa

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
    }

    override func setViewConfig() {

        viewModel.checkValidation(manButton: mainView.manButton, womanButton: mainView.womanButton)

        mainView.nextButton.rx.tap
            .bind {

            }
            .disposed(by: disposeBag)
    }
}
