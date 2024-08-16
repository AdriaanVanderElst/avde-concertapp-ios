//
//  ConcertDetailView.swift
//  concertapp
//
//  Created by Adriaan Vander Elst on 10/08/2024.
//

import SwiftUI

struct ConcertDetailView: View {
    let concert: Concert
    @EnvironmentObject var viewModel: ConcertDetailViewModel
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            content
        }.onAppear {
            viewModel.newComment = concert.details.comment
        }
    }

    private var content: some View {
        VStack(alignment: .leading) {
            header
            concertDetails
            commentSection
        }
    }

    private var header: some View {
        HStack {
            Text(concert.name)
                .font(.largeTitle)
                .padding()
            Spacer()
            confirmedIcon
        }
    }

    private var confirmedIcon: some View {
        Image(systemName: concert.isConfirmed ? "checkmark.square" : "square")
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(concert.isConfirmed ? Color.theme.green : Color.theme.red)
            .shadow(color: Color.black.opacity(0.2), radius: 4)
            .padding()
    }

    private var concertDetails: some View {
        VStack {
            DetailCard(label: "Datum", value: concert.date.formatted(.dateTime.locale(Locale(identifier: "nl_BE"))))
            DetailCard(label: "Adres", value: "\(concert.address.street) \(concert.address.number), \(concert.address.city)")
            DetailCard(label: "Organisatie", value: concert.details.organisation)
            DetailCard(label: "Telefoon", value: concert.details.phone)
            DetailCard(label: "Email", value: concert.details.email)
            DetailCard(label: "Prijs", value: "€ \(concert.details.price)")
        }
    }

    private var commentSection: some View {
        VStack {
            commentTextField
            submitButton
        }
        .padding()
    }

    private var commentTextField: some View {
        TextField("Enter your comment", text: $viewModel.newComment, axis: .vertical)
            .padding()
            .lineLimit(5, reservesSpace: true)
            .scrollIndicators(.visible)
            .background(Color.theme.white)
            .foregroundColor(Color.theme.primary)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 4)
            .disabled(concert.date <= Date())
    }

    private var submitButton: some View {
        Button(action: {
            isAnimating = true
            Task {
                await viewModel.updateComment(concert: concert)
                withAnimation(.easeInOut(duration: 0.5)) {
                    isAnimating = false
                }
            }
        }) {
            Text("Submit")
                .font(.headline)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(Color.theme.accent)
                .foregroundColor(Color.theme.white)
                .cornerRadius(8)
                .scaleEffect(isAnimating ? 1.1 : 1.0)
        }
        .padding()
        .disabled(concert.date <= Date())
        .opacity(concert.date <= Date() ? 0.6 : 1.0)
    }
}

struct ConcertDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let namespace = Namespace().wrappedValue
        ConcertDetailView(concert: ConcertList.mockData.concerts.first!)
            .environmentObject(ConcertDetailViewModel())
    }
}
