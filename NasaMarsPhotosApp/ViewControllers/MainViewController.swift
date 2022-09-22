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
    @IBOutlet var buttonsStack: UIStackView!
    
    private var destinationUrl: Link?

    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let galleryVC = segue.destination as? GaleryTableViewController,
              let gallery = sender as? Gallery else { return }
        galleryVC.photos = gallery.photos
    }

    private func goToPlanet() {
        buttonsStack.isHidden = true
        activityIndicator.startAnimating()
        fetchPhotos()
    }


    @IBAction func goToPressed(_ sender: UIButton) {
        if sender.tag == 1 {
            destinationUrl = .marsURL
        } else {
            destinationUrl = .fakeURL
        }
        goToPlanet()
    }

    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {

    }

}

// MARK: - Get photo from API extension
extension MainViewController {
    private func fetchPhotos() {
        guard let destinationUrl = destinationUrl else { return }
        NetworkManager.shared.fetch(dataType: Gallery.self, from: destinationUrl) { [weak self] result in
            switch result {
            case .success(let gallery):
                self?.buttonsStack.isHidden = false
                self?.activityIndicator.stopAnimating()
                self?.performSegue(withIdentifier: "goToPhotos", sender: gallery)
            case .failure(let error):
                print(error)
                self?.showAlert(stutus: .failed)
            }
        }
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
            case .failed: return "Отставить запуск!"
            }
        }

        var message: String {
            switch self {
            case .success: return  "You can see the results in the Debug aria"
            case .failed: return "Похоже, погода не летная... Может, в другой раз."
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

            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                self.buttonsStack.isHidden = false
                self.activityIndicator.stopAnimating()
            }

            alert.addAction(okAction)
            self.present(alert, animated: true)
        }

    }
}
