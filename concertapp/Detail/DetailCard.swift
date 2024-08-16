//
//  DetailCard.swift
//  concertapp
//
//  Created by Adriaan Vander Elst on 16/08/2024.
//

import SwiftUI

struct DetailCard: View {
    let label: String
    let value: String

    var body: some View {
        HStack(spacing: 20) {
            labelField
            Spacer()
            valueField
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.theme.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 4)
        .padding(.horizontal)
    }

    private var labelField: some View {
        Text("\(label):")
            .font(.headline)
            .foregroundColor(Color.theme.secondary)
            .padding()
    }

    private var valueField: some View {
        Text(value)
            .font(.headline)
            .foregroundColor(Color.theme.primary)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
            .padding()
    }
}
