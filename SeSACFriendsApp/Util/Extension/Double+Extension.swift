//
//  Double+Extension.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/09.
//

import UIKit

extension Double {
    var changeToGreedLatitude: Int {
        let number = String((self + 90) * 1000)
        return Int(number.substring(from: 0, to: 4))!
    }
    var changeToGreedLongitude: Int {
        let number = String((self + 180) * 1000)
        return Int(number.substring(from: 0, to: 4))!
    }
}
