//
//  PhotoCell.swift
//  NasaMarsPhotosApp
//
//  Created by Anton Saltykov on 21.09.2022.
//

import UIKit

final class PhotoCell: UITableViewCell {
    @IBOutlet var photoImage: UIImageView!
    @IBOutlet var roverLabel: UILabel!
    @IBOutlet var cameraLabel: UILabel!
    @IBOutlet var imageLoadingIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        imageLoadingIndicator.hidesWhenStopped = true
        imageLoadingIndicator.startAnimating()
    }

    func configure(with photo: Photo) {
        roverLabel.text = "Марсоход: \(photo.rover.name) (\(photo.rover.status))"
        cameraLabel.text = "Камера: " + photo.camera.name

        NetworkManager.shared.fetchImage(from: photo.imgSrc) { [weak self] result in
            switch result {
            case .success(let imageDate):
                self?.photoImage.image = UIImage(data: imageDate)
                self?.imageLoadingIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }

}
