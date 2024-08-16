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
            Color.theme.background
                .ignoresSafeArea()
            VStack(spacing: 200) {
                VStack {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                    Text("Concert planner").font(.largeTitle)
                }
                loginButton
            }
        }
    }
    
    private var loginButton: some View {
        ZStack {
            if loginViewModel.isBusy {
                ProgressView()
            } else {
                Button(action: {
                    withAnimation {
                        loginViewModel.login()
                    }
                }) {
                    HStack {
                        Image(systemName: "lock")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.theme.white)

                        Text("Log in")
                            .font(.headline)
                            .foregroundColor(Color.theme.white)
                            .padding(.leading, 5)
                    }
                    .padding()
                    .background(Color.theme.accent)
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let lvm = LoginViewModel()
        lvm.isBusy = false
        return LoginView()
            .environmentObject(lvm)
    }
}
