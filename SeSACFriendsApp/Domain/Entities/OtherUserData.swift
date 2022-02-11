//
//  OtherUserData.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/09.
//

import Foundation

struct OtherUserData {

    let nickname: String
    let userLatitude: Double
    let userLongitude: Double
    let reputation: [Int]
    let wantHobby: [String]
    let reviews: [String]
    let gender: Int
    let lookingForGender: Int
    let sesacImage: Int
    let backgroundImage: Int
}

struct OtherUserDataList {

    let otherUsers: [OtherUserData]
    let otherRequestUsers: [OtherUserData]
    let recommendHobbyList: [String]
}
