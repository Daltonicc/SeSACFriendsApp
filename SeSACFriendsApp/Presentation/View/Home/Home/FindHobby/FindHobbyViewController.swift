//
//  FindHobbyViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/10.
//

import UIKit
import RxSwift
import RxCocoa

final class FindHobbyViewController: BaseViewController {

    let mainView = FindHobbyView()
    var viewModel: FindHobbyViewModel?

    let disposeBag = DisposeBag()

    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    override func navigationItemConfig() {

        navigationItem.leftBarButtonItem = backBarButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainView.searchBar)

        backBarButton.target = self
        backBarButton.rx.tap
            .bind { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }

    override func setViewConfig() {

    }

    override func textfieldConfig() {

    }
}
