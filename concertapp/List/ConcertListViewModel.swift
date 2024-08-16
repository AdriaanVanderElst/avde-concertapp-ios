//
//  ConcertListViewModel.swift
//  concertapp
//
//  Created by Adriaan Vander Elst on 10/08/2024.
//

import Auth0
import SwiftUI

class ConcertListViewModel: ObservableObject {
    @Published var concerts: [Concert] = []

    @Published var error: NetworkError?

    func fetchConcerts() async {
        do {
            let data: ConcertsResponse = try await WebService().downloadData(fromURL: "https://concertapi-service-app.onrender.com/api/concerts")
            DispatchQueue.main.async {
                self.concerts = data.items
                self.error = nil
            }

        } catch let networkError as NetworkError {
            DispatchQueue.main.async {
                self.error = networkError
            }

        } catch {
            DispatchQueue.main.async {
                self.error = .unknown
            }
        }
    }
}
