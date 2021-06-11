//
//  JWTTokenModel.swift
//  MeetInn
//
//  Created by Louis Dumont on 11/06/2021.
//

import Foundation

struct JWTTokenModel {
    let token: String?
}

extension JWTTokenModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case token = "token"
    }
}
