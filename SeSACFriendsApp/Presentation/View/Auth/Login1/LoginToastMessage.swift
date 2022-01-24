//
//  LoginError.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/24.
//

import UIKit

enum LoginToastMessage {
    case success
    case unauthorizedNumber
    case tooMuchRequest
    case etcError

    func makeMessage(state: LoginToastMessage, viewController: UIViewController) {

        switch state {
        case .success:
            viewController.view.makeToast("전화 번호 인증 시작", point: CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2), title: nil, image: nil, completion: nil)
        case .unauthorizedNumber:
            viewController.view.makeToast("유효하지 않은 전화번호 형식입니다.", point: CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2), title: nil, image: nil, completion: nil)
        case .tooMuchRequest:
            viewController.view.makeToast("잠시 후 시도해주세요", point: CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2), title: nil, image: nil, completion: nil)
        case .etcError:
            viewController.view.makeToast("다시 시도해주세요", point: CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2), title: nil, image: nil, completion: nil)
        }

    }
}
