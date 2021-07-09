//
//  ReservationViewModel.swift
//  MeetInn
//
//  Created by Louis Dumont on 07/07/2021.
//

import Foundation
class ReservationViewModel: ObservableObject {
    @Published private(set) var isLoading = false
    @Published var isLoggedIn = false
    let defaults = UserDefaults.standard
    private var request: ReservationRequest?
    @Published var timeslots: Array<Timeslot> = []

    
    func getTimeSlots(partnerId: String) -> Void {
        guard !isLoading else { return }
        isLoading = true
        let resource = TimeslotResource(id: partnerId)
        let request = TimeslotRequest(request: resource.request)
        request.execute { [weak self] data,response,error in
            self?.isLoading = false
            
            if data != nil {
                self?.timeslots = data!
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
    
    func getTimeStampsDays(timestamps: Array<Timeslot>) {
        var slots  = [[String]]()
        for index in (0...timestamps.count - 1){
            let timestamp = timestamps[index]
            let date = Date(timeIntervalSince1970: Double(timestamp.startDate))
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            let components = Calendar.current.dateComponents([.day, .month], from: date)
            let day = components.day
            let month = components.month
            print(day,month)
        }
        
        
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
