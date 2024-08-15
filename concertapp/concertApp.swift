//
//  concertappApp.swift
//  concertapp
//
//  Created by Adriaan Vander Elst on 31/07/2024.
//

import SwiftUI

@main
struct concertApp: App {
    var body: some Scene {
        WindowGroup {
            ConcertListView(viewModel: ConcertListViewModel())
        }
    }
}
