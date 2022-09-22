//
//  GaleryTableViewController.swift
//  NasaMarsPhotosApp
//
//  Created by Anton Saltykov on 21.09.2022.
//

import UIKit

final class GaleryTableViewController: UITableViewController {

    var photos: [Photo]!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController,
        let photo = sender as? Photo else { return }
        detailVC.photo = photo
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotoCell
            else { return UITableViewCell() }

        cell.configure(with: photos[indexPath.row])

        return cell
    }

    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let photo = photos[indexPath.row]
        performSegue(withIdentifier: "showPhoto", sender: photo)
    }
}
