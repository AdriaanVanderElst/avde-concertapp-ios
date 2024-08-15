//
//  ConcertList.swift
//  concertapp
//
//  Created by Adriaan Vander Elst on 10/08/2024.
//

import Foundation

struct ConcertList {
    
    private static let mockData = [
       // generate mockdata for 10 concerts
        
        Concert(id: 1, name: "Concert 1", date: Date(), address: Concert.Address(street: "Street 1", number: "1", city: "City 1"), isConfirmed: true, details: Concert.Details(time: "20:00", price: 20.0, organizer: "Organizer 1", phoneNumber: "123456789", email: "", comment: nil)),
        Concert(id: 2, name: "Concert 2", date: Date(), address: Concert.Address(street: "Street 2", number: "2", city: "City 2"), isConfirmed: true, details: Concert.Details(time: "20:00", price: 20.0, organizer: "Organizer 2", phoneNumber: "123456789", email: "", comment: nil)),
        Concert(id: 3, name: "Concert 3", date: Date(), address: Concert.Address(street: "Street 3", number: "3", city: "City 3"), isConfirmed: true, details: Concert.Details(time: "20:00", price: 20.0, organizer: "Organizer 3", phoneNumber: "123456789", email: "", comment: nil)),
        Concert(id: 4, name: "Concert 4", date: Date(), address: Concert.Address(street: "Street 4", number: "4", city: "City 4"), isConfirmed: true, details: Concert.Details(time: "20:00", price: 20.0, organizer: "Organizer 4", phoneNumber: "123456789", email: "", comment: nil)),
        Concert(id: 5, name: "Concert 5", date: Date(), address: Concert.Address(street: "Street 5", number: "5", city: "City 5"), isConfirmed: true, details: Concert.Details(time: "20:00", price: 20.0, organizer: "Organizer 5", phoneNumber: "123456789", email: "", comment: nil)),
    ]
    
    private(set) var concerts = [Concert]()
    
    struct Concert {
        let id: Int
        let name: String
        let date: Date
        let address: Address
        let isConfirmed: Bool
        let details: Details
        
        struct Address {
            let street: String
            let number: String
            let city: String
        }
        
        struct Details {
            let time: String
            let price: Double
            let organizer: String
            let phoneNumber: String
            let email: String
            var comment: String?
        }
    }
    
    init() {
        concerts = ConcertList.mockData
    }
    
}
