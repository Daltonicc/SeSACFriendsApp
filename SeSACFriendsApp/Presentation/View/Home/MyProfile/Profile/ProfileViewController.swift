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

final class ProfileViewController: BaseViewController {

    let mainView = ProfileView()
    var viewModel: ProfileViewModel?

    let disposeBag = DisposeBag()

    override func loadView() {
        super.loadView()

        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func setViewConfig() {
        super.setViewConfig()

    }

    override func textfieldConfig() {
        super.textfieldConfig()
        
    }

    override func navigationItemConfig() {

        navigationItem.title = "정보 관리"
        navigationItem.leftBarButtonItem = backBarButton
        navigationItem.rightBarButtonItem = mainView.saveBarButton

        backBarButton.target = self
        backBarButton.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)

        mainView.saveBarButton.target = self
        mainView.saveBarButton.rx.tap
            .bind {
                print("저장!")
            }
            .disposed(by: disposeBag)
    }
}
