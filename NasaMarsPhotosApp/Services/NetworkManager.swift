//
//  NetworkManager.swift
//  NasaMarsPhotosApp
//
//  Created by Anton Saltykov on 21.09.2022.
//

import Foundation
import Alamofire

typealias JsonItem = [String: Any]

enum Link: String {
    case marsURL = "/mars-photos/api/v1/rovers/curiosity/photos"
    case fakeURL = "/mars-photos/api/v1/fake-url"
}

enum ApiKey {
    static let demo = "RjMhvElmaN0VSxNW0rCzcUoX7tvDQEhmFtNx7Won"
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

    func fetchImage(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .responseData { response in
                switch response.result {
                case .success(let imageData):
                    completion(.success(imageData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func fetch(from apiUrl: Link , completion: @escaping(Result<[Photo], AFError>) -> Void) {
        guard let url = getFullUrl(for: apiUrl) else { return }
        
        AF.request(url, method: .get)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    guard let value = value as? JsonItem else { return }
                    let photos = Photo.getPhotos(from: value["photos"] ?? [])
                    completion(.success(photos))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

// MARK: - get url extension
extension NetworkManager {
    private func getFullUrl(for source: Link) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.nasa.gov"
        components.path = source.rawValue
        components.queryItems = [
            URLQueryItem(name: "api_key", value: ApiKey.demo),
            URLQueryItem(name: "sol", value: "1000"),
        ]

        return components.url
    }
}
