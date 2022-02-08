//
//  OnQueueResponseDTO.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/09.
//

import Foundation

// MARK: - OnQueue
struct OnQueueResponseDTO: Codable {
    let fromQueueDB, fromQueueDBRequested: [FromQueueDB]
    let fromRecommend: [String]
}

// MARK: - FromQueueDB
struct FromQueueDB: Codable {
    let uid, nick: String
    let lat, long: Double
    let reputation: [Int]
    let hf, reviews: [String]
    let gender, type, sesac, background: Int
}

extension OnQueueResponseDTO {
    func toDomain() -> OtherUserDataList {
        return .init(otherUsers: fromQueueDB.map { $0.toDomain() },
                     otherRequestUsers: fromQueueDBRequested.map { $0.toDomain() },
                     recommendHobbyList: fromRecommend)
    }
}

extension FromQueueDB {
    func toDomain() -> OtherUserData {
        return .init(nickname: nick,
                     userLatitude: lat,
                     userLongitude: long,
                     reputation: reputation,
                     wantHobby: hf,
                     reviews: reviews,
                     gender: gender,
                     lookingForGender: type,
                     sesacImage: sesac,
                     backgroundImage: background)
    }
}

