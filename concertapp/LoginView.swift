//
//  LoginView.swift
//  concertapp
//
//  Created by Adriaan Vander Elst on 16/08/2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    var body: some View {
        ZStack {
            Color.orange.opacity(0.1).ignoresSafeArea()
            VStack(spacing: 200) {
                VStack {
                    Image("logo_ANTRACIET")
                        .resizable()
                        .scaledToFit()
                        .background(.clear)
                    Text("Concert planner").font(.largeTitle)
                }
                ZStack {
                    if loginViewModel.isBusy {
                        ProgressView()
                    } else {
                        Button(action: {
                            // Action for logout
                            loginViewModel.login()
                        }) {
                            HStack {
                                Image(systemName: "lock")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)

                                Text("Log in")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.leading, 5)
                            }
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                            .shadow(radius: 5)
                        }
                        .padding()
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .frame(height: 50)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let lvm = LoginViewModel()
        lvm.isBusy = false
        return LoginView()
            .environmentObject(lvm)
    }
}
