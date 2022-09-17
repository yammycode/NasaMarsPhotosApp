//
//  Photo.swift
//  NasaMarsPhotosApp
//
//  Created by Anton Saltykov on 16.09.2022.
//

struct Photo: Decodable {
    let camera: Camera
    let rover: Rover
    let img_src: String
    let earth_date: String
}