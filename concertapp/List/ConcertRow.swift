//
//  ConcertRow.swift
//  concertapp
//
//  Created by Adriaan Vander Elst on 16/08/2024.
//

import SwiftUI

struct ConcertRow: View {
    let concert: Concert

    var body: some View {
        HStack {
            nameAndDate
            Spacer()
            addressAndConfirmation
        }
        .padding()
        .background(Color.theme.white)
        .cornerRadius(8)
        .shadow(radius: 5)
    }

    private var nameAndDate: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(concert.name)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.primary)
            Spacer()
            Text(concert.date, style: .date)
                .font(.subheadline)
                .foregroundColor(Color.theme.secondary)
        }
    }

    private var addressAndConfirmation: some View {
        VStack(alignment: .trailing) {
            Text(concert.address.city)
                .font(.subheadline)
                .foregroundColor(Color.theme.secondary)
            Spacer()
            Image(systemName: concert.isConfirmed ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(concert.isConfirmed ? Color.theme.green : Color.theme.red)
        }
    }
}
