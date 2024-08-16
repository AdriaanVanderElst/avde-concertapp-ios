//
//  ConcertListView.swift
//  concertapp
//
//  Created by Adriaan Vander Elst on 31/07/2024.
//

import SwiftUI

struct ConcertListView: View {
    @ObservedObject var viewModel: ConcertListViewModel
    @EnvironmentObject var loginViewModel: LoginViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                VStack(spacing: 0) {
                    Divider().background(Color.theme.background)
                    concertList
                        .overlay(alignment: .top) {
                            if viewModel.error != nil {
                                ErrorView(error: $viewModel.error)
                            }
                        }
                        .refreshable { await viewModel.fetchConcerts() }
                        .navigationTitle("Concerten")
                        .toolbar {
                            ToolbarItem {
                                Text(loginViewModel.userProfile.name)
                                    .font(.headline)
                                    .foregroundColor(Color.theme.primary)
                            }
                            ToolbarItem { logoutButton }
                        }
                        .background(Color.theme.background.opacity(0.4))
                }
            }

            .onAppear {
                loadConcerts()
            }
        }
    }

    private var concertList: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.concerts, id: \.name) { concert in
                    NavigationLink(destination: ConcertDetailView(concert: concert)) {
                        ConcertRow(concert: concert)
                    }
                }
            }
            .padding()
        }
    }

    private var logoutButton: some View {
        Button(action: {
            loginViewModel.logout()
        }) {
            HStack {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .padding()
            .cornerRadius(8)
            .shadow(radius: 5)
        }
    }

    private func loadConcerts() {
        if viewModel.concerts.isEmpty {
            Task {
                await viewModel.fetchConcerts()
            }
        }
    }
}

struct ErrorView: View {
    @Binding var error: NetworkError?

    var body: some View {
        if let error = error {
            VStack {
                Text(error.localizedDescription)
                    .bold()
                HStack {
                    Button("Dismiss") {
                        self.error = nil
                    }
                }
            }
            .padding()
            .background(.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

struct ConcertListView_Previews: PreviewProvider {
    static var previews: some View {
        let lvm = LoginViewModel()
        lvm.isAuthenticated = true
        let cvm = ConcertListViewModel()
        cvm.concerts = ConcertList.mockData.concerts
        return ConcertListView(viewModel: cvm)
            .environmentObject(lvm)
            .environmentObject(ConcertDetailViewModel())
    }
}
