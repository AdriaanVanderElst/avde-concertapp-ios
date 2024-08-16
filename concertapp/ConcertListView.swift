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
                Image("logo_WIT")
                    .resizable()
                    .scaledToFit()
                VStack(spacing: 0) {
                    Divider().background(Color.orange.opacity(0.2))
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.concerts, id: \.name) { newconcert in
                                NavigationLink(destination: ConcertDetailView(concert: newconcert)) {
                                    ConcertView(concert: newconcert)
                                }
                            }
                        }
                        .padding()
                    }
                    .overlay(alignment: .top) {
                        if viewModel.error != nil {
                            ErrorView(error: $viewModel.error)
                        }
                    }
                    .refreshable { await viewModel.fetchConcerts() }
                    .navigationTitle("Concerten")
                    .toolbar {
                        ToolbarItem {
                            Button(action: {
                                loginViewModel.logout()
                            }) {
                                HStack {
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .resizable()
                                        .frame(width: 20, height: 20)

                                    Text("Log uit")
                                        .font(.headline)
                                        .padding(.leading, 2)
                                }
                            }
                        }
                    }
                }
                .background(Color.orange.opacity(0.1))
            }
        }

        .onAppear {
            if viewModel.concerts.isEmpty {
                Task {
                    await viewModel.fetchConcerts()
                }
            }
        }
    }
}

struct ConcertView: View {
    let concert: ConcertListViewModel.Concert

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(concert.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer()
                Text(concert.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(concert.address.city)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Image(systemName: concert.isConfirmed ? "checkmark.square" : "square")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(concert.isConfirmed ? .green : .red)
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(8)
        .shadow(radius: 5)
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
            .background(Color.red)
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
