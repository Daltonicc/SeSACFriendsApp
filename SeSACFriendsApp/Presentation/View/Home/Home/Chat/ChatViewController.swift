//
//  ChatViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/20.
//

import UIKit
import RxSwift
import RxCocoa

final class ChatViewController: BaseViewController {

    let mainView = ChatView()

    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        mainView.plusView.isHidden = true
    }

    override func navigationItemConfig() {

        title = "Friend's Name"
        navigationItem.leftBarButtonItem = backBarButton
        navigationItem.rightBarButtonItem = mainView.plusMenuBarButton

        backBarButton.target = self
        backBarButton.rx.tap
            .bind { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)

        mainView.plusMenuBarButton.target = self
        mainView.plusMenuBarButton.rx.tap
            .bind { [weak self] in
                self?.mainView.plusView.isHidden.toggle()
            }
            .disposed(by: disposeBag)
    }

    override func setViewConfig() {

    }

    override func buttonConfig() {

    }

}
