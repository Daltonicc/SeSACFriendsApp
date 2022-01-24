//
//  LoginViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/01/23.
//

import Foundation
import Moya

final class LoginViewModel {

    var phoneNumber: Observable<String> = Observable("")
    var authNumber: Observable<String> = Observable("")
    var yourID: String = ""
    
}
