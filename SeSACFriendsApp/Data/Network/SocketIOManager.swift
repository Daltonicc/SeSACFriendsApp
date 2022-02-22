//
//  SocketIOManager.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/22.
//

import Foundation
import SocketIO
import SwiftUI

//class SocketIOManager: NSObject {
//
//    let token = "Token"
//
//    static let shared = SocketIOManager()
//
//    // 서버에서 메시지를 주고 받기 위한 클래스.
//    var manager: SocketManager!
//
//    // 클라이언트 소켓
//    var socket: SocketIOClient!
//
//    override init() {
//        super.init()
//
//        let url = URL(string: APIKey.baseURL)!
//        manager = SocketManager(socketURL: url, config: [
//            .log(true),
//            .compress,
//            .extraHeaders(["auth": token])
//        ])
//
//        socket = manager.defaultSocket // "/"로 된 룸
//
//        //소켓 연결 메서드
//        socket.on(clientEvent: .connect) { data, ack in
//            print("Socket Is CONNECTED", data, ack)
//        }
//
//        //소켓 연결 해제 메서드
//        socket.on(clientEvent: .disconnect) { data, ack in
//            print("Socket is DISCONNECTED", data, ack)
//        }
//
//        //소켓 채팅 듣는 메서드, sesac 이벤트로 날아온 데이터를 수신
//        // 데이터 수신 -> 디코딩 -> 모델에 추가 -> 갱신
//
//        socket.on("sesac") { dataArray, ack in
//            print("SESAC RECEIVED", dataArray)
//            let data = dataArray[0] as! NSDictionary
//            let chat = data["text"] as! String
//            let name = data["name"] as! String
//            let createdAt = data["createdAt"] as! String
//
//            print("Check",chat, name, createdAt)
//
//            NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self, userInfo: ["chat": chat, "name": name, "createdAt": createdAt])
//         }
//    }
//
//    func establishConnection() {
//        socket.connect()
//    }
//
//    func coloseConnection() {
//        socket.disconnect()
//    }
//
//}

class SocketIOManager: NSObject {

    static let shared = SocketIOManager()

    var manager: SocketManager!
    var socket: SocketIOClient!

    let url = URL(string: APIKey.baseURL)!

    override init() {
        super.init()

        manager = SocketManager(socketURL: url, config: [
                    .log(true),
                    .compress,
                ])
        socket = manager.defaultSocket

        socket.on(clientEvent: .connect) { [weak self] data, ack in
            print("Socket is Connected", data, ack)
            self?.socket.emit("changesocketid", UserDefaultsRepository.fetchYourUIDForChat())
        }

        socket.on(clientEvent: .disconnect) { data, ack in
            print("Socket is Disconnected", data, ack)
        }

        socket.on("chat") { dataArray, ack in
            let data = dataArray[0] as! NSDictionary
            let __v = data["__v"] as! Int
            let _id = data["_id"] as! String
            let chat = data["chat"] as! String
            let createdAt = data["createdAt"] as! String
            let from = data["from"] as! String
            let to = data["to"] as! String

            NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self, userInfo: ["__v": __v, "_id": _id, "chat": chat, "createdAt": createdAt, "from": from, "to": to])
        }
    }
    func establishConnection() {
        socket.connect()

    }
    func closeConnection() {
        socket.disconnect()

    }
}
//    func sendMessage(message: String, nickname: String) {
//        socket.emit("event", ["message" : "This is a test message"])
//        socket.emit("event1", [["name" : "ns"], ["email" : "@naver.com"]])
//        socket.emit("event2", ["name" : "ns", "email" : "@naver.com"])
//        socket.emit("msg", ["nick": nickname, "msg" : message])
//
//    }
