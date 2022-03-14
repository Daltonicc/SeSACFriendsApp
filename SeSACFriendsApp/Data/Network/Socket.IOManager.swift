//
//  SocketIOManager.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/22.
//

import Foundation
import SocketIO
import SwiftUI

class SocketIOManager: NSObject {

    static let shared = SocketIOManager()

    var manager: SocketManager!
    var socket: SocketIOClient!

    let url = URL(string: APIKey.baseURL)!

    override init() {
        super.init()

        manager = SocketManager(socketURL: url, config: [
                    .log(true),
                    .compress
                ])

        socket = manager.defaultSocket

        socket.on(clientEvent: .connect) { data, ack in
            print("Socket is Connected", data, ack)
            self.socket.emit("changesocketid", UserDefaultsRepository.fetchYourUIDForChat())
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
