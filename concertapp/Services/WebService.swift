//
//  APICallView.swift
//  concertapp
//
//  Created by Adriaan Vander Elst on 15/08/2024.
//

import Auth0
import SwiftUI

enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
    case timeout
    case unknown

    var localizedDescription: String {
        switch self {
        case .badUrl:
            return "There was an error creating the URL."
        case .invalidRequest:
            return "The request was invalid."
        case .badResponse:
            return "Did not get a valid response."
        case .badStatus:
            return "Did not get a 2xx status code from the response."
        case .failedToDecodeResponse:
            return "Failed to decode response into the expected type."
        case .timeout:
            return "The server didn't respond."
        case .unknown:
            return "An unknown error occurred."
        }
    }
}

class WebService: Codable {
    func credentials() async throws -> Credentials {
        let credentialsManager = CredentialsManager(authentication: Auth0.authentication())

        return try await withCheckedThrowingContinuation { continuation in
            credentialsManager.credentials { result in
                switch result {
                case let .success(credentials):
                    continuation.resume(returning: credentials)
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func downloadData<T: Codable>(fromURL: String) async throws -> T {
        guard let url = URL(string: fromURL) else { throw NetworkError.badUrl }
        var request = URLRequest(url: url)
        let credentials = try await credentials()

        request.setValue("Bearer \(credentials.accessToken)", forHTTPHeaderField: "Authorization")

        do {
            let (data, result) = try await URLSession.shared.data(for: request)
            guard let response = result as? HTTPURLResponse else { throw NetworkError.badResponse }
            guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.badStatus }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom({ decoder in
                let container = try decoder.singleValueContainer()
                let dateStr = try container.decode(String.self)
                let formatter = ISO8601DateFormatter()
                formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                return formatter.date(from: dateStr)!
            })

            guard let decoded = try? decoder.decode(T.self, from: data) else { throw NetworkError.failedToDecodeResponse }
            return decoded
        } catch {
            if let urlError = error as? URLError, urlError.code == .timedOut {
                throw NetworkError.timeout
            } else {
                throw NetworkError.unknown
            }
        }
    }

    func writeData<T: Codable>(toURL: String, data: T) async throws {
        guard let url = URL(string: toURL) else { throw NetworkError.badUrl }
        var request = URLRequest(url: url)
        let credentials = try await credentials()

        request.httpMethod = "PUT"
        request.setValue("Bearer \(credentials.accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .custom({ date, encoder in
            var container = encoder.singleValueContainer()
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            let dateString = formatter.string(from: date)
            try container.encode(dateString)
        })

        request.httpBody = try encoder.encode(data)

        let (_, result) = try await URLSession.shared.data(for: request)
        guard let response = result as? HTTPURLResponse else { throw NetworkError.badResponse }
        guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.badStatus }
    }
}
