//
//  Photo.swift
//  NasaMarsPhotosApp
//
//  Created by Anton Saltykov on 16.09.2022.
//

struct Photo {
    let camera: Camera?
    let rover: Rover?
    let imgSrc: String
    let earthDate: String

    init(photoData: JsonItem) {
        camera = Camera(cameraData: photoData["camera"] as? JsonItem ?? [:])
        rover = Rover(roverData: photoData["rover"] as? JsonItem ?? [:])
        imgSrc = photoData["img_src"] as? String ?? ""
        earthDate = photoData["earth_date"] as? String ?? ""
    }
}

extension Photo {
    static func getPhotos(from value: Any) -> [Photo] {
        guard let photoData = value as? [JsonItem] else { return  []}
        return photoData.compactMap { Photo(photoData: $0) }
    }
}
