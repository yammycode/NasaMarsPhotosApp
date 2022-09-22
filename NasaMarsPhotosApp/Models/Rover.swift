//
//  Rover.swift
//  NasaMarsPhotosApp
//
//  Created by Anton Saltykov on 16.09.2022.
//

struct Rover: Decodable {
    let id: Int
    let name: String
    let landingDate: String
    let launchDate: String
    let status: String

    var description: String {
        "Марсоход \(id): \(name).\nВылетел \(launchDate).\nПриземлился \(landingDate)"
    }
}
