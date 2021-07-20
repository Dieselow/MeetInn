//
//  SchedulingProvider.swift
//  MeetInn
//
//  Created by Louis Dumont on 20/07/2021.
//

import Foundation
import EventKit
import MapKit

class SchedulingProvider {
    
    static func addEventToCalendar(title: String, startDate: Date, endDate: Date,latitude: Double,longitude: Double, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        let eventStore : EKEventStore = EKEventStore()
        
        // 'EKEntityTypeReminder' or 'EKEntityTypeEvent'
        
        eventStore.requestAccess(to: .event) { (granted, error) in
            
            if (granted) && (error == nil) {
                print("granted \(granted)")
                print("error \(String(describing: error))")
                
                let event:EKEvent = EKEvent(eventStore: eventStore)
                
                event.title = title
                event.startDate = Date()
                event.endDate = Date()            
                event.structuredLocation = EKStructuredLocation(mapItem: MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))))
                event.calendar = eventStore.defaultCalendarForNewEvents
                let alarm = EKAlarm(relativeOffset: -3600) //1 hour
                event.addAlarm(alarm)
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let error as NSError {
                    print("failed to save event with error : \(error)")
                }
                print("Saved Event")
            }
            else{
                
                print("failed to save event with error : \(String(describing: error)) or access not granted")
            }
        }
    }
}
