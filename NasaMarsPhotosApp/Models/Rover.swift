//
//  Rover.swift
//  NasaMarsPhotosApp
//
//  Created by Anton Saltykov on 16.09.2022.
//

struct Rover: Decodable {
    let id: Int
    let name: String
    let landing_date: String
    let launch_date: String
    let status: String

    var description: String {
        "Марсоход \(id): \(name) (\(status)). Вылетел \(launch_date). Приземлился \(landing_date)"
    }
}
