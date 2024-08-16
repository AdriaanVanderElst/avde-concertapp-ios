//
//  ConcertList.swift
//  concertapp
//
//  Created by Adriaan Vander Elst on 10/08/2024.
//

import Foundation

struct ConcertList: Codable {
    private(set) var concerts: [Concert] = []

    static let mockData = ConcertList(concerts: [
        Concert(id: 1, name: "Jazz in the park", date: Date(), isConfirmed: true, address: Concert.Address(street: "Koning Albertpark", number: "1", city: "Gent"), details: Concert.Details(price: 10.0, comment: "Bring your own drinks", organisation: "Jazz Gent", phone: "09 123 45 67", email: "test@test.be"), placeId: nil, organizerId: nil),
        Concert(id: 2, name: "Rock Werchter", date: Date(), isConfirmed: false, address: Concert.Address(street: "Haachtsesteenweg", number: "23", city: "Werchter"), details: Concert.Details(price: 100.0, comment: "No drinks allowed", organisation: "Rock Werchter", phone: "09 123 45 67", email: "werchter@wer.chter"), placeId: nil, organizerId: nil)])

    struct Concert: Identifiable, Codable {
        let id: Int
        let name: String
        let date: Date
        let isConfirmed: Bool
        let address: Address
        var details: Details

        // Required for encoding
        let placeId: Int?
        let organizerId: Int?

        struct Address: Codable {
            let street: String
            let number: String
            let city: String
        }

        struct Details: Codable {
            let price: Double
            var comment: String
            let organisation: String
            let phone: String
            let email: String
        }
    }

    struct ConcertsResponse: Codable {
        let items: [Concert]
        let count: Int
    }
}

extension ConcertList.Concert {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        date = try container.decode(Date.self, forKey: .date)
        isConfirmed = try container.decode(Bool.self, forKey: .isConfirmed)

        // Address mapping
        let placeContainer = try container.nestedContainer(keyedBy: AddressKeys.self, forKey: .place)
        placeId = try placeContainer.decode(Int.self, forKey: .id)
        address = Address(
            street: try placeContainer.decode(String.self, forKey: .street),
            number: String(try placeContainer.decode(Int.self, forKey: .houseNr)),
            city: try placeContainer.decode(String.self, forKey: .city)
        )

        // Details mapping
        let organizerContainer = try container.nestedContainer(keyedBy: OrganizerKeys.self, forKey: .organizer)
        organizerId = try organizerContainer.decode(Int.self, forKey: .id)
        details = Details(
            price: try container.decode(Double.self, forKey: .price),
            comment: try container.decodeIfPresent(String.self, forKey: .comment) ?? "",
            organisation: try organizerContainer.decode(String.self, forKey: .name),
            phone: try organizerContainer.decode(String.self, forKey: .phoneNr),
            email: try organizerContainer.decode(String.self, forKey: .email)
        )
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodingKeys.self)

//        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(date, forKey: .date)
        try container.encode(isConfirmed, forKey: .isConfirmed)

//        // Encode Address
//        var placeContainer = container.nestedContainer(keyedBy: AddressKeys.self, forKey: .place)
//        try placeContainer.encode(placeId, forKey: .id)
//        try placeContainer.encode(address.street, forKey: .street)
//        try placeContainer.encode(Int(address.number), forKey: .houseNr)
//        try placeContainer.encode(address.city, forKey: .city)

//        // Encode Details
//        var organizerContainer = container.nestedContainer(keyedBy: OrganizerKeys.self, forKey: .organizer)
//        try organizerContainer.encode(organizerId, forKey: .id)
//        try organizerContainer.encode(details.organisation, forKey: .name)
//        try organizerContainer.encode(details.phone, forKey: .phoneNr)
//        try organizerContainer.encode(details.email, forKey: .email)

        try container.encode(details.price, forKey: .price)
        try container.encode(details.comment.isEmpty ? "None" : details.comment, forKey: .comment)

        try container.encode(placeId, forKey: .placeId)
        try container.encode(organizerId, forKey: .organizerId)
    }

    private enum DecodingKeys: String, CodingKey {
        case id, name, date, isConfirmed, price, comment, place, organizer
    }

    private enum EncodingKeys: String, CodingKey {
        case name, date, isConfirmed, price, comment, placeId, organizerId
    }

    private enum AddressKeys: String, CodingKey {
        case id, street, houseNr, city
    }

    private enum OrganizerKeys: String, CodingKey {
        case id, name, phoneNr, email
    }
}
