//
//  UserDataModel.swift
//  MeetInn
//
//  Created by Louis Dumont on 11/06/2021.
//

import Foundation

struct Roles: Encodable {
    let Id: String?
    let role: String?
}
extension Roles: Decodable {
    enum CodingKeys: String, CodingKey {
        case Id = "id"
        case role = "role"
    }
}
struct UserRegisteredModel {
    let Id: String?
    let email: String?
    let password: String?
    let createdAt: String
    let roles: [Roles]
    let partners: [Roles]
    
}
extension UserRegisteredModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case Id = "id"
        case email = "email"
        case password = "password"
        case createdAt = "createDate"
        case roles = "roles"
        case partners = "partners"
    }
}
