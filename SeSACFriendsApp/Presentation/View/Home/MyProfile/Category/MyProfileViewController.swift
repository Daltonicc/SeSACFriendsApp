//
//  MyProfileViewContrller.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/31.
//

import UIKit
import RxSwift
import RxCocoa

// API 개선
final class MyProfileViewController: BaseViewController {

    let mainView = MyProfileView()
    var viewModel: MyProfileViewModel?

    var userData: UserData?

    let disposeBag = DisposeBag()

    deinit {
        print("MyProfile Deinit")
    }

    override func loadView() {
        super.loadView()

        self.view = mainView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel?.getUserInfo { [weak self] userData in
            self?.userData = userData
            self?.mainView.yourNameLabel.text = self?.userData?.yourName
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "내 정보"

    }

    override func setViewConfig() {
        super.setViewConfig()

        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(MyProfileTableViewCell.self, forCellReuseIdentifier: MyProfileTableViewCell.identifier)

        mainView.topButton.rx.tap
            .bind { [weak self] in
                self?.addPressAnimationToButton(self?.mainView.topButton ?? CustomButton()) { [weak self] _ in
                    self?.viewModel?.showDetailProfile()
                }
            }
            .disposed(by: disposeBag)
    }

    override func textfieldConfig() {
        super.textfieldConfig()

    }
}

extension MyProfileViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyProfileTableViewCell.identifier, for: indexPath) as? MyProfileTableViewCell else { return UITableViewCell() }

        cell.cellConfiguration(row: indexPath.row)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }

}
