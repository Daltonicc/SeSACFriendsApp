//
//  UIViewController+Extension.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/23.
//

import Foundation
import UIKit

extension UIViewController {

    func addPressAnimationToButton(_ viewToAnimate: UIView, completion: ((Bool) -> Void)?) {

        UIView.animate(withDuration: 0.05, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {

            viewToAnimate.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)

        }) { _ in

            UIView.animate(withDuration: 0.05, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn, animations: {

                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)

            }, completion: completion)
        }
    }

    func changeDateFormatting(date: Date, dateFormat: String) -> String {

//        let getDate = date.addingTimeInterval(60 * 60 * 9)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)

    }

    func changeDateForSave(date: Date) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let new = dateFormatter.string(from: date)
        print(new)

        UserDefaultsRepository.saveBirth(birth: new)
    }

    func locationAlertConfigure() {

        let alert = UIAlertController(title: "주의!", message: "위치 서비스 기능이 꺼져 있습니다. 새싹찾기 기능 사용을 위해 위치 서비스 기능을 켜주세요.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
        let settingMoveAction = UIAlertAction(title: "설정", style: .default) { _ in

            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }

        alert.addAction(okAction)
        alert.addAction(settingMoveAction)

        self.present(alert, animated: true, completion: nil)
    }
}
