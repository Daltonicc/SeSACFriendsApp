//
//  ChatRepositoryInterface.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/22.
//

import Foundation

protocol ChatRepositoryInterface {
    func postChat(parameter: [String: Any], otherUID: String, completion: @escaping (Result<ChatData, ChatError>) -> Void)
}
