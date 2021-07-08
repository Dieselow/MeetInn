//
//  ReservationModel.swift
//  MeetInn
//
//  Created by Louis Dumont on 08/07/2021.
//

import Foundation

struct ReservationModel: Hashable,Codable {
    var owner: String
    var invitedUsers: Array<String>
}
