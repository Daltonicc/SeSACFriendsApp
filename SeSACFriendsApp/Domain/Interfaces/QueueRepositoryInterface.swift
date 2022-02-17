//
//  QueueRepositoryInterface.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/11.
//

import Foundation

protocol QueueRepositoryInterface {
    func fetchAroundUserData(parameter: [String: Any], completion: @escaping (Result<OtherUserDataList, QueueNetworkError>) -> Void)
    func requestFindFriends(parameter: [String: Any], completion: @escaping (QueueNetworkError?) -> Void)
    func suspendFindFriends(completion: @escaping (QueueNetworkError?) -> Void)
    func hobbyRequest(parameter: [String: Any], completion: @escaping (QueueNetworkError?) -> Void)
}
