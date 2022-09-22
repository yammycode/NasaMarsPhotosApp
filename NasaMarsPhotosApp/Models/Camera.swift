//
//  Camera.swift
//  NasaMarsPhotosApp
//
//  Created by Anton Saltykov on 16.09.2022.
//

struct Camera: Decodable {
    let id: Int
    let name: String
    let fullName: String

    var description: String {
        "Камера \(id): \(fullName) (\(name))"
    }
}
