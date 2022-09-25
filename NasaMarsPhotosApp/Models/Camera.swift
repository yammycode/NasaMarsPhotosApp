//
//  Camera.swift
//  NasaMarsPhotosApp
//
//  Created by Anton Saltykov on 16.09.2022.
//

struct Camera {
    let id: Int
    let name: String
    let fullName: String

    var description: String {
        "Камера \(id): \(fullName) (\(name))"
    }

    init(cameraData: JsonItem) {
        id = cameraData["id"] as? Int ?? 0
        name = cameraData["name"] as? String ?? ""
        fullName = cameraData["full_name"] as? String ?? ""
    }
}
