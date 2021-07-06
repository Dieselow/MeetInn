//
//  PartnerModel.swift
//  MeetInn
//
//  Created by Louis Dumont on 06/07/2021.
//

import Foundation
struct PartnerModel: Hashable, Codable,Identifiable {
    var id: String
    var name: String
    var phoneNumber: String
    var address: AddressModel?
    var createDate: String
    var timeSlots: Array<String>
}

struct AddressModel: Hashable,Encodable {
    var latitude: Double
    var longitude: Double
    var type: String
    var name: String
    var number: String
    var postalCode: String
    var street: String
    var confidence: Double
    var region: String
    var regionCode: String
    var county: String
    var locality: String
    var administrativeArea: String
    var neighborhood: String
    var country: String
    var countryCode: String
    var continent: String
    var label: String
}

extension AddressModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case postalCode = "postal_code"
        case latitude = "latitude"
        case longitude = "longitude"
        case type = "type"
        case name = "name"
        case number = "number"
        case street = "street"
        case confidence = "confidence"
        case region = "region"
        case regionCode = "region_code"
        case county = "county"
        case locality = "locality"
        case administrativeArea = "administrative_area"
        case neighborhood = "neighbourhood"
        case country = "country"
        case countryCode = "country_code"
        case continent = "continent"
        case label = "label"
    }
}
