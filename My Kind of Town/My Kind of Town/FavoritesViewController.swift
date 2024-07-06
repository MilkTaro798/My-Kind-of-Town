//
//  FavoritesViewController.swift
//  My Kind of Town
//
//  Created by Yutong Sun on 2/7/24.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    weak var delegate: PlacesFavoritesDelegate?
    let dataManager = DataManager.sharedInstance
    var favoritesPlaces: [String] = []
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var exit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesPlaces = dataManager.listFavorites()
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func exitFavorites(_ sender: UIButton){
        dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < favoritesPlaces.count else { return }
        delegate?.favoritePlace(name: favoritesPlaces[indexPath.row])
        dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        cell.textLabel?.text = favoritesPlaces[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteFavorite(at: indexPath)
        }
    }
    
    private func deleteFavorite(at indexPath: IndexPath) {
        let favorite = favoritesPlaces[indexPath.row]
        dataManager.deleteFavorite(favorite)
        favoritesPlaces.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
