//
//  ConcertDetailView.swift
//  concertapp
//
//  Created by Adriaan Vander Elst on 10/08/2024.
//

import SwiftUI

struct ConcertDetailView: View {
    let concert: ConcertList.Concert
    @EnvironmentObject var viewModel: ConcertDetailViewModel

    var body: some View {
        ZStack {
            Color.orange.opacity(0.1).ignoresSafeArea()
            VStack(alignment: .leading) {
                HStack {
                    Text(concert.name)
                        .font(.largeTitle)
                        .padding()
                    Spacer()
                    Image(systemName: concert.isConfirmed ? "checkmark.square" : "square")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(concert.isConfirmed ? .green : .red)
                        .padding()
                }
                DetailCard(label: "Datum", value: concert.date.formatted(.dateTime.locale(Locale(identifier: "nl_BE"))))
                DetailCard(label: "Adres", value: "\(concert.address.street) \(concert.address.number), \(concert.address.city)")
                DetailCard(label: "Organisatie", value: concert.details.organisation)
                DetailCard(label: "Telefoon", value: concert.details.phone)
                DetailCard(label: "Email", value: concert.details.email)
                DetailCard(label: "Prijs", value: "€ \(concert.details.price)")

                VStack {
                    TextField("Enter your comment", text: $viewModel.newComment, axis: .vertical)
                        .padding()
                        .lineLimit(5, reservesSpace: true)
                        .scrollIndicators(.visible)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 4)
                        .disabled(concert.date <= Date())

                    Button(action: {
                        Task {
                            await viewModel.updateComment(concert: concert)
                        }
                    }) {
                        Text("Submit")
                            .font(.headline)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                    .disabled(concert.date <= Date())
                    .opacity(concert.date <= Date() ? 0.6 : 1.0)
                }
                .padding()
            }
        }.onAppear {
            viewModel.newComment = concert.details.comment
        }
    }
}

struct DetailCard: View {
    let label: String
    let value: String

    var body: some View {
        HStack(spacing: 20) {
            Text("\(label):")
                .font(.headline)
                .foregroundColor(.gray)
                .padding()
            Spacer()
            Text(value)
                .font(.headline)
                .padding()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 4)
        .padding(.horizontal)
    }
}

struct ConcertDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ConcertDetailView(concert: ConcertList.mockData.concerts.first!)
            .environmentObject(ConcertDetailViewModel())
    }
}
