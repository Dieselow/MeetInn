//
//  ReservationViewModel.swift
//  MeetInn
//
//  Created by Louis Dumont on 07/07/2021.
//

import Foundation
struct ReservationViewModel {
    
    func convertDate(timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}
