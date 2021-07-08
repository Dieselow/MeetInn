//
//  PartnerResource.swift
//  MeetInn
//
//  Created by Louis Dumont on 06/07/2021.
//

import Foundation
struct PartnerResource: APIResource {
    var token: String?
    
    var body: Dictionary<String, String>?
    
    typealias ModelType = Array<PartnerModel>
    
    var httpMethod: String {
        return "GET"
    }
    
    var id: Int?
    
    var methodPath: String {
        return "/partner"
    }
    
    var filter: String? {
        return nil
    }
}
