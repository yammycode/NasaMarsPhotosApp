//
//  DetailViewController.swift
//  NasaMarsPhotosApp
//
//  Created by Anton Saltykov on 22.09.2022.
//

import UIKit

final class DetailViewController: UIViewController {

    @IBOutlet var photoImage: UIImageView!
    @IBOutlet var roverLabel: UILabel!
    @IBOutlet var cameraLabel: UILabel!
    @IBOutlet var imageLoadingIndicator: UIActivityIndicatorView!

    var photo: Photo!

    override func viewDidLoad() {
        super.viewDidLoad()

        imageLoadingIndicator.hidesWhenStopped = true
        imageLoadingIndicator.startAnimating()

        roverLabel.text = photo.rover.description
        cameraLabel.text = photo.camera.description

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

    @IBAction func backButtonPressed() {
        performSegue(withIdentifier: "backToHome", sender: nil)
    }

}
