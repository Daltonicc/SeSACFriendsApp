//
//  MyQueueStateResponseDTO.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/18.
//

import Foundation

struct MyQueueStateResponseDTO: Codable {
    let dodged, matched, reviewed: Int
    let matchedNick, matchedUid: String?
}

extension MyQueueStateResponseDTO {
    func toDomain() -> MyQueueStateData {
        return .init(dodged: dodged,
                     matched: matched,
                     youGotReview: reviewed,
                     friendNicknameWhoIsMatched: matchedNick,
                     friendUIDWhoIsMatched: matchedUid)
    }
}
