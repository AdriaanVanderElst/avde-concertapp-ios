//
//  LoginViewModel.swift
//  concertapp
//
//  Created by Adriaan Vander Elst on 16/08/2024.
//

import Auth0
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var userProfile = Profile.empty
    @Published var isAuthenticated = false
    @Published var isBusy = false

    func login() {
        isBusy = true
        let credentialsManager = CredentialsManager(authentication: Auth0.authentication())

        Auth0.webAuth().audience("https://adriaan-hogent-concert-api.be").start { result in
            switch result {
            case let .success(credentials):
                print("Credentials: \(credentials)")
                print("access: \(credentials.accessToken)")
                self.isAuthenticated = true
                self.isBusy = false
                self.userProfile = Profile.from(credentials.idToken)
                _ = credentialsManager.store(credentials: credentials)

            case let .failure(error):
                self.isBusy = false
                print("Error logging in: \(error)")
            }
        }
    }

    func logout() {
        isBusy = true
        Auth0.webAuth().clearSession { result in
            switch result {
            case .success:
                print("Logged out")
                self.isAuthenticated = false
                self.isBusy = false
                self.userProfile = Profile.empty
            case let .failure(error):
                self.isBusy = false
                print("Error logging out: \(error)")
            }
        }
    }
}
