//
//  UserRepositoryInterface.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/11.
//

import Foundation

protocol UserRepositoryInterface {
    func getUserInfo(completion: @escaping (Result<UserData, UserNetworkError>) -> Void)
    func requestRegisterUser(completion: @escaping (UserNetworkError?) -> Void)
    func updateUserData(parameter: [String: Any], completion: @escaping (UserNetworkError?) -> Void)
    func withdrawUserData(completion: @escaping (UserNetworkError?) -> Void)
}
