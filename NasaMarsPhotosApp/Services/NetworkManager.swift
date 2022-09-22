//
//  NetworkManager.swift
//  NasaMarsPhotosApp
//
//  Created by Anton Saltykov on 21.09.2022.
//

import Foundation

enum Link: String {
    case marsURL = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000"
    case fakeURL = "https://api.nasa.gov/mars-photos/api/v1/fake-url?fake"
}

enum ApiKey: String {
    case demo = "RjMhvElmaN0VSxNW0rCzcUoX7tvDQEhmFtNx7Won"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

// MARK: - NetworkManager
class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void ) {

        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }

    func fetch<T: Decodable>(dataType: T.Type, from url: Link , completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: getFullUrl(for: url)) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }

    private func getFullUrl(for source: Link) -> String {
        source.rawValue + "&api_key=" + ApiKey.demo.rawValue
    }
}
