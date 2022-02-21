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

        mainView.chatTableView.delegate = self
        mainView.chatTableView.dataSource = self
        mainView.chatTableView.register(MyChatTableViewCell.self, forCellReuseIdentifier: MyChatTableViewCell.identifier)
        mainView.chatTableView.register(YourChatTableViewCell.self, forCellReuseIdentifier: YourChatTableViewCell.identifier)
    }

    override func buttonConfig() {

    }

}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let myCell = tableView.dequeueReusableCell(withIdentifier: MyChatTableViewCell.identifier, for: indexPath) as? MyChatTableViewCell else { return UITableViewCell() }
        guard let yourCell = tableView.dequeueReusableCell(withIdentifier: YourChatTableViewCell.identifier, for: indexPath) as? YourChatTableViewCell else { return UITableViewCell() }

        return myCell
    }
}
