//
//  ConcertDetailView.swift
//  concertapp
//
//  Created by Adriaan Vander Elst on 10/08/2024.
//

import SwiftUI

struct ConcertDetailView: View {
    var concertId: Int
    @ObservedObject var viewModel = ConcertListViewModel()
    var concert: ConcertListViewModel.Concert {
        viewModel.concerts.first(where: { $0.id == concertId })!
    }
    
    var body: some View {
        VStack {
            Text(concert.name)
                .font(.title)
            Text(concert.date, style: .date)
                .font(.subheadline)
        }
    }
}

struct ConcertDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ConcertDetailView(concertId:2)
    }
}
