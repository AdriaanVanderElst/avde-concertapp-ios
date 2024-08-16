//
//  HeaderView.swift
//  concertapp
//
//  Created by Adriaan Vander Elst on 16/08/2024.
//

import SwiftUI

struct HeaderView: View {
    let screenTitle: String
    @EnvironmentObject var loginViewModel: LoginViewModel

    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(.blue)
                .frame(height: 130)
                .shadow(radius: 3)
                .edgesIgnoringSafeArea(.all)
            HStack {
                Text(screenTitle)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Spacer()
                Button("Log out") {
                    loginViewModel.logout()
                }
            }
            .foregroundColor(.white)
            .padding()
        }
        .frame(maxWidth: .infinity)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(screenTitle: "Test")
            .environmentObject(LoginViewModel())
    }
}
