//
//  Camera.swift
//  NasaMarsPhotosApp
//
//  Created by Anton Saltykov on 16.09.2022.
//

struct Camera: Decodable {
    let id: Int
    let name: String
    let full_name: String

    var description: String {
        "Камера \(id): \(full_name) (\(name))"
    }
}
