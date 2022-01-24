//
//  LoginViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/23.
//

import Foundation
import Moya

final class LoginViewModel {

    static var yourID: String = ""

    var phoneNumber: Observable<String> = Observable("")
    var authNumber: Observable<String> = Observable("")

}
