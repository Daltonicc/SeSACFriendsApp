//
//  ViewController.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/18.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {

    let label = UILabel()
    let textField = UITextField()
    let button1 = UIButton()
    var testView = BaseTextFieldView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(testView)
        view.addSubview(button1)
        testView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
        button1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(testView.snp.bottom).offset(30)
            make.width.height.equalTo(100)

        }
        button1.addTarget(self, action: #selector(button1Clicked), for: .touchUpInside)
        button1.setTitle("asdasdasd", for: .normal)
        button1.backgroundColor = .black
    }

    @objc func button1Clicked() {

        testView.textFieldState = .error
    }
}

/*
 이슈
 1. 텍스트 필드의 보더 중에서 바텀에만 보더를 주고 싶었는데 코드를 구현해도 제대로 보더 표시가 안됐던 이슈 존재.
  -> 해결: viewDidLoad가 아닌 viewDidLayoutSubviews에서 관련 코드를 구현해줘야 함. addSubview가 끝난다음에 호출해야 하기 때문.

 */
