//
//  ReservationViewModel.swift
//  MeetInn
//
//  Created by Louis Dumont on 07/07/2021.
//

import Foundation

struct TimeslotDate {
    var dayName : String = ""
    var dayNumber : Int = 0
    var year: Int = 0
    var month: String = ""
    var timeslots: [Timeslot] = []
}

class ReservationViewModel: ObservableObject {
    @Published private(set) var isLoading = false
    @Published var isLoggedIn = false
    let defaults = UserDefaults.standard
    private var request: ReservationRequest?
    @Published var timeslots: Array<Timeslot> = []
    @Published var timeslotsDates : Array<(key: String, value: TimeslotDate)> = []
    
    
    func getTimeSlots(partnerId: String) -> Void {
        guard !isLoading else { return }
        isLoading = true
        let resource = TimeslotResource(id: partnerId)
        let request = TimeslotRequest(request: resource.request)
        request.execute { [weak self] data,response,error in
            self?.isLoading = false
            
            if data != nil {
                self?.timeslots = data!
                self?.timeslotsDates = (self?.getTimeStampsDays(timestamps: (self?.timeslots)!))!
            }
            
        }
        
    }
    func convertDate(timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func getTimeStampsDays(timestamps: Array<Timeslot>) -> Array<(key: String, value: TimeslotDate)> {
        var slots: [String : TimeslotDate] = [:]
        for index in (0...timestamps.count - 1){
            let timestamp = timestamps[index]
            let date = Date(timeIntervalSince1970: Double(timestamp.startDate))
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            let components = Calendar.current.dateComponents([.day, .month,.year], from: date)
            let day = components.day!
            let month = components.month!
            let year = components.year!
            var timeslotDate = TimeslotDate()
            dateFormatter.dateFormat = "EEEE"
            timeslotDate.dayName = dateFormatter.string(from: date)
            dateFormatter.dateFormat = "LLLL"
            timeslotDate.month = dateFormatter.string(from: date)
            let slotIndex = month + day + year
            let keyExists = slots[String(slotIndex)] != nil
            if keyExists {
                continue
            }
            for indexbis in (0...timestamps.count - 1){
                let current = timestamps[indexbis]
                let date = Date(timeIntervalSince1970: Double(timestamp.startDate))
                let components = Calendar.current.dateComponents([.day, .month,.year], from: date)
                let dayCurrent = components.day!
                let monthCurrent = components.month!
                let yearCurrent = components.year!
                if(dayCurrent != day || monthCurrent != month || yearCurrent != year){
                    continue
                }
                timeslotDate.timeslots.append(current)
            }
            
            slots[String(slotIndex)] = timeslotDate
        }
        
        return slots.sorted(by: { $0.0 < $1.0 })
        
    }
    
    func createReservation(timeSlotId: String, partnerId: String, completion: @escaping (Bool,String?) -> Void) {
        if let user  = try? JSONDecoder().decode(UserModel.self, from: defaults.object(forKey: "currentUser") as! Data) {
            let params = ["owner": user.Id] as Dictionary<String, String>
            guard !isLoading else { return }
            isLoading = true
            let resource = ReservationResource(body: params, id: timeSlotId, token: user.token)
            let request = ReservationRequest(request: resource.request)
            request.execute { [weak self] result,response,error in
                self?.isLoading = false
                if (error == nil) {
                    completion(true,nil)
                }
                else {
                    completion(false, error)
                }
            }
            
        }
        else {
            completion(false,"something happened")
        }
    }
}
