//
//  FirebaseRepositoryInterface.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/11.
//

import UIKit

protocol FirebaseRepositoryInterface {
    func requestFirebaseAuth(textField: UITextField)
    func checkCredential(textField: UITextField, completion: @escaping () -> Void)
    func refreshIDToken(completion: @escaping () -> Void)
}
