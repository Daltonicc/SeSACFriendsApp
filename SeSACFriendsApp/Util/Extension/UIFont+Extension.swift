//
//  UIFont+Extension.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/20.
//

import UIKit

struct Font {

    static let notoSansKRr = "NotoSansKR-Regular"
    static let notoSansKRm = "NotoSansKR-Medium"
}

extension UIFont {

    static var display1: UIFont {
        UIFont(name: Font.notoSansKRr, size: 20) ?? .systemFont(ofSize: 20)
    }
    static var title1m: UIFont {
        UIFont(name: Font.notoSansKRm, size: 16) ?? .systemFont(ofSize: 16)
    }
    static var title2r: UIFont {
        UIFont(name: Font.notoSansKRr, size: 16) ?? .systemFont(ofSize: 16)
    }
    static var title3m: UIFont {
        UIFont(name: Font.notoSansKRm, size: 14) ?? .systemFont(ofSize: 14)
    }
    static var title4r: UIFont {
        UIFont(name: Font.notoSansKRr, size: 14) ?? .systemFont(ofSize: 14)
    }
    static var title5m: UIFont {
        UIFont(name: Font.notoSansKRm, size: 12) ?? .systemFont(ofSize: 12)
    }
    static var title5r: UIFont {
        UIFont(name: Font.notoSansKRr, size: 12) ?? .systemFont(ofSize: 12)
    }
    static var title6r: UIFont {
        UIFont(name: Font.notoSansKRr, size: 12) ?? .systemFont(ofSize: 12)
    }
    static var body1m: UIFont {
        UIFont(name: Font.notoSansKRm, size: 16) ?? .systemFont(ofSize: 16)
    }
    static var body2r: UIFont {
        UIFont(name: Font.notoSansKRr, size: 16) ?? .systemFont(ofSize: 16)
    }
    static var body3r: UIFont {
        UIFont(name: Font.notoSansKRr, size: 14) ?? .systemFont(ofSize: 14)
    }
    static var body4r: UIFont {
        UIFont(name: Font.notoSansKRr, size: 12) ?? .systemFont(ofSize: 12)
    }
    static var captionR: UIFont {
        UIFont(name: Font.notoSansKRr, size: 10) ?? .systemFont(ofSize: 10)
    }
}
