//
//  ConcertListView.swift
//  concertapp
//
//  Created by Adriaan Vander Elst on 31/07/2024.
//

import SwiftUI

struct ConcertListView: View {
    @ObservedObject var viewModel: ConcertListViewModel

    var body: some View {
        
            NavigationStack {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.concerts, id: \.name) { concert in
                            ConcertView(concert: concert)
                        }
                    }
                    .padding()
                }
                .navigationTitle("Overzicht")
            }
        
    }

    private var header: some View {
        HStack() {
            Text("Overzicht")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            Text ("Accountnaam")
        }
        .padding()
        .background(Color(.cyan))
    }
}

struct ConcertView: View {
    let concert: ConcertListViewModel.Concert

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(concert.name)
                    .font(.headline)
                Spacer()
                Text(concert.date, style: .date)
                    .font(.subheadline)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(concert.address.city)
                    .font(.subheadline)
                Spacer()
                Image(systemName: concert.isConfirmed ? "checkmark.square" : "square")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
    }
}

struct ConcertListView_Previews: PreviewProvider {
    static var previews: some View {
        ConcertListView(viewModel: ConcertListViewModel())
    }
}
