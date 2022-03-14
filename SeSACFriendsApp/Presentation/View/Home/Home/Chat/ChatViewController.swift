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
    var viewModel: ChatViewModel?

    var list: [ChatData] = []

    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        mainView.plusView.isHidden = true

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        SocketIOManager.shared.closeConnection()
    }

    override func navigationItemConfig() {

        title = "Friend's Name"
        navigationItem.leftBarButtonItem = backBarButton
        navigationItem.rightBarButtonItem = mainView.plusMenuBarButton

        backBarButton.target = self
        backBarButton.rx.tap
            .bind { [weak self] in
                self?.navigationController?.popToRootViewController(animated: true)
            }
            .disposed(by: disposeBag)

        mainView.plusMenuBarButton.target = self
        mainView.plusMenuBarButton.rx.tap
            .bind { [weak self] in
                self?.mainView.plusView.isHidden.toggle()
            }
            .disposed(by: disposeBag)

        mainView.chatTextView.sendButton.rx.tap
            .bind { [weak self] in
                self?.viewModel?.postChat(chatMessage: self?.mainView.chatTextView.mainTextField.text ?? "",
                                          completion: { errorMessage in
                    self?.mainView.makeToast(errorMessage)
                    self?.mainView.chatTableView.reloadData()
                    self?.mainView.chatTextView.mainTextField.text = ""
                })
            }
            .disposed(by: disposeBag)
    }

    override func setViewConfig() {

        mainView.chatTableView.delegate = self
        mainView.chatTableView.dataSource = self
        mainView.chatTableView.register(MyChatTableViewCell.self, forCellReuseIdentifier: MyChatTableViewCell.identifier)
        mainView.chatTableView.register(YourChatTableViewCell.self, forCellReuseIdentifier: YourChatTableViewCell.identifier)
        mainView.chatTableView.separatorStyle = .none

        SocketIOManager.shared.establishConnection()

        NotificationCenter.default.addObserver(self, selector: #selector(getMessage(notification:)), name: NSNotification.Name("getMessage"), object: nil)
    }

    override func buttonConfig() {

        mainView.reportButton.rx.tap
            .bind { [weak self] in

            }
            .disposed(by: disposeBag)

        mainView.cancelButton.rx.tap
            .bind { [weak self] in

            }
            .disposed(by: disposeBag)

        mainView.reviewButton.rx.tap
            .bind { [weak self] in

            }
            .disposed(by: disposeBag)
    }

    @objc func getMessage(notification: NSNotification) {

        print("getMessage!!!!")

        let chat = notification.userInfo!["chat"] as! String
        let toID = notification.userInfo!["to"] as! String
        let fromID = notification.userInfo!["from"] as! String
        let createdAt = notification.userInfo!["createdAt"] as! String

        let value = ChatData(toID: toID, fromID: fromID, chatMessage: chat, createdAt: createdAt)

        viewModel?.chatList.append(value)
        print(viewModel?.chatList)

        mainView.chatTableView.reloadData()
//        mainView.chatTableView.scrollToRow(at: IndexPath(row: viewModel?.chatList.count - 1, section: 0), at: .bottom, animated: false)
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.chatList.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let myCell = tableView.dequeueReusableCell(withIdentifier: MyChatTableViewCell.identifier, for: indexPath) as? MyChatTableViewCell else { return UITableViewCell() }
        guard let yourCell = tableView.dequeueReusableCell(withIdentifier: YourChatTableViewCell.identifier, for: indexPath) as? YourChatTableViewCell else { return UITableViewCell() }

        let data = viewModel?.chatList[indexPath.row]

        if data?.fromID == viewModel?.yourUID {
            myCell.myChatLabel.text = data?.chatMessage
            return myCell
        } else {
            yourCell.yourChatLabel.text = data?.chatMessage
            return yourCell
        }
    }
}
