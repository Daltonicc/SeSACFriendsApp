//
//  MyProfileViewContrller.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/31.
//

import UIKit
import RxSwift
import RxCocoa

final class MyProfileViewController: BaseViewController {

    let mainView = MyProfileView()

    let disposeBag = DisposeBag()

    override func loadView() {
        super.loadView()

        self.view = mainView

        navigationController?.title = "내 정보"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setViewConfig() {
        super.setViewConfig()

        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(MyProfileTableViewCell.self, forCellReuseIdentifier: MyProfileTableViewCell.identifier)
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
