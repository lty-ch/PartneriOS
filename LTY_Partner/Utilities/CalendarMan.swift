//
//  CalendarMan.swift
//  LTY_Partner
//
//  Created by CTS on 24/07/23.
//

import Foundation
import UIKit
import EventKit

class CalendarMan {
    
    static var sharedInstance = CalendarMan()
    
    private init() {

    }
    
    func saveEventToCalendar(title: String, startDate: Date, endDate: Date, notes: String?, completion: @escaping (Bool, Error?) -> Void) {
        let eventStore = EKEventStore()
        
        // Check for calendar access permission
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            // We already have access to the calendar, save the event
            createAndSaveEvent(eventStore: eventStore, title: title, startDate: startDate, endDate: endDate, notes: notes, completion: completion)
            
        case .denied, .restricted:
            // User has denied or restricted calendar access, handle it appropriately
            let error = NSError(domain: "CalendarAccessError", code: 0, userInfo: nil)
            completion(false, error)
            
        case .notDetermined:
            // Request calendar access if not determined
            eventStore.requestAccess(to: .event) { (granted, error) in
                if granted {
                    self.createAndSaveEvent(eventStore: eventStore, title: title, startDate: startDate, endDate: endDate, notes: notes, completion: completion)
                } else {
                    completion(false, error)
                }
            }
        @unknown default:
            fatalError("New case for EKAuthorizationStatus is available. Handle it accordingly.")
        }
    }

    private func createAndSaveEvent(eventStore: EKEventStore, title: String, startDate: Date, endDate: Date, notes: String?, completion: @escaping (Bool, Error?) -> Void) {
        // Create the event and set its properties
        let event = EKEvent(eventStore: eventStore)
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.notes = notes
        
        // Set calendar, for example, you can use the default calendar here
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        do {
            // Save the event
            try eventStore.save(event, span: .thisEvent, commit: true)
            completion(true, nil)
        } catch {
            completion(false, error)
        }
    }

}

