//
//  concertappApp.swift
//  concertapp
//
//  Created by Adriaan Vander Elst on 31/07/2024.
//

import SwiftUI

@main
struct concertApp: App {
    @StateObject var loginViewModel = LoginViewModel()

    var body: some Scene {
        WindowGroup {
            AppSwitcher()
                .environmentObject(loginViewModel)
        }
    }
}

struct AppSwitcher: View {
    @StateObject var listViewModel = ConcertListViewModel()
    @StateObject var detailViewModel = ConcertDetailViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel

    var body: some View {
        if loginViewModel.isAuthenticated {
            ConcertListView(viewModel: listViewModel)
                .environmentObject(detailViewModel)
        } else {
            LoginView()
        }
    }
}
