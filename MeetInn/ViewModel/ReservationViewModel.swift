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
    func convertDate(timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func createReservation(timeSlotId: String, partnerId: String, completion: @escaping (Bool,String?) -> Void) {
        if let user  = try? JSONDecoder().decode(UserModel.self, from: defaults.object(forKey: "currentUser") as! Data) {
            let params = ["owner": user.Id, "invitedUsers": []] as? Dictionary<String, String>
            guard !isLoading else { return }
            isLoading = true
            let resource = ReservationResource(body: params, id: timeSlotId, token: user.token)
            let request = ReservationRequest(request: resource.request)
            request.execute { [weak self] result in
                self?.isLoading = false
                if (result != nil) {
                    completion(true,"oui ça marche")
                }
                else {
                    completion(false, "something happenned")
                }
            }
            
        }
        else {
            completion(false,"something happened")
        }
    }
}
