//
//  MainViewController.swift
//  NasaMarsPhotosApp
//
//  Created by Anton Saltykov on 17.09.2022.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    // MARK: - Private properties
    private let apiUrl = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000"
    private let apiKey = "RjMhvElmaN0VSxNW0rCzcUoX7tvDQEhmFtNx7Won"

    private var baseUrl: String {
        "\(apiUrl)&api_key=\(apiKey)"
    }

    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchPhotos()
    }
}

// MARK: - Get photo from API extension
extension MainViewController {
    private func fetchPhotos() {
        guard let url = URL(string: baseUrl) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                self.showAlert(stutus: .failed)
                return
            }

            let jsonDecoder = JSONDecoder()

            do {
                let galery = try jsonDecoder.decode(Gallery.self, from: data)
                
                print(galery.photos)

                for (index, photo) in galery.photos.enumerated() {
                    print("Фото #\(index) от \(photo.earth_date). \(photo.rover.description). \(photo.camera.description)")
                }

                self.showAlert(stutus: .success)

            } catch {
                print(error.localizedDescription)
                self.showAlert(stutus: .failed)
            }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
        }.resume()
    }
}

// MARK: - Alert extension
extension MainViewController {

    enum StutusAlert: String {
        case success
        case failed

        var title: String {
            switch self {
            case .success: return "Success"
            case .failed: return "Failed"
            }
        }

        var message: String {
            switch self {
            case .success: return  "You can see the results in the Debug aria"
            case .failed: return "You can see error in the Debug aria"
            }
        }
    }

    private func showAlert(stutus: StutusAlert) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: stutus.title,
                message: stutus.message,
                preferredStyle: .alert
            )

            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }

    }
}
