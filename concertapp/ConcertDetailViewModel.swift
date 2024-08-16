//
//  ConcertDetailViewModel.swift
//  concertapp
//
//  Created by Adriaan Vander Elst on 15/08/2024.
//

import SwiftUI

class ConcertDetailViewModel: ObservableObject {
    @Published var newComment: String = ""

    func updateComment(concert: ConcertList.Concert) async {
        do {
            var updatedConcert = concert
            updatedConcert.details.comment = newComment
            try await WebService().writeData(toURL: "https://concertapi-service-app.onrender.com/api/concerts/\(concert.id)", data: updatedConcert)
            print("Updated comment: \(newComment)")
        } catch {
            print("Error updating comment: \(error)")
        }
    }
}
