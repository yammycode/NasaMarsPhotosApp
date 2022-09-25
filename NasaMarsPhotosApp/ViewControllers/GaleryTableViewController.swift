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
        let index = tableView.indexPathForSelectedRow

        guard let detailVC = segue.destination as? DetailViewController,
              let index = index?.row else { return }
        detailVC.photo = photos[index]
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotoCell
        else { return UITableViewCell() }

        cell.configure(with: photos[indexPath.row])

        return cell
    }

}
