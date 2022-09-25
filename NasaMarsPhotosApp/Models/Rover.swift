//
//  Rover.swift
//  NasaMarsPhotosApp
//
//  Created by Anton Saltykov on 16.09.2022.
//

struct Rover {
    let id: Int
    let name: String
    let landingDate: String
    let launchDate: String
    let status: String

    var description: String {
        "Марсоход \(id): \(name).\nВылетел \(launchDate).\nПриземлился \(landingDate)"
    }

    init(roverData: JsonItem) {
        id = roverData["id"] as? Int ?? 0
        name = roverData["name"] as? String ?? ""
        landingDate = roverData["landing_date"] as? String ?? ""
        launchDate = roverData["launch_date"] as? String ?? ""
        status = roverData["status"] as? String ?? ""
    }
}
