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

//        BirthViewModel.birth = new
        UserDefaults.standard.set(new, forKey: "birth")
    }
}
