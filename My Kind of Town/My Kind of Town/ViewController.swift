//
//  ViewController.swift
//  My Kind of Town
//
//  Created by Yutong Sun on 2/5/24.
//

import UIKit
import MapKit
class ViewController: UIViewController {

    @IBOutlet var placeDescription: UILabel!
    @IBOutlet var placeTitle: UILabel!
    @IBOutlet var favoritePlacesButton: UIButton!
    @IBOutlet var HUD: UIView!
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var mapView: MKMapView!

    var selectedPlace: Place?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupMapView()
        initializeUI()
        loadInitialPlace()
        
    }
    
    private func initializeUI() {
        HUD.layer.cornerRadius = 10
        HUD.clipsToBounds = true
        placeTitle.adjustsFontSizeToFitWidth = true
        updateFavoriteButtonState(isFavorite: false)
    }
    
    private func loadInitialPlace() {
        if let place = DataManager.sharedInstance.getPlaceByName(name: "United Center") {
            selectedPlace = place
            updateHUD(with: place)
        }
    }
    
    private func updateFavoriteButtonState(isFavorite: Bool) {
        favoriteButton.isSelected = isFavorite
        let imageName = isFavorite ? "star.fill" : "star"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    private func setupMapView() {
        mapView.delegate = self
        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll
        
        if let region = DataManager.sharedInstance.loadRegion() {
            mapView.setRegion(region, animated: true)
        }
        
        DataManager.places.forEach { mapView.addAnnotation($0) }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let miles: Double = 20 * 1600
        let centerPoint = CLLocationCoordinate2DMake(41.8681,-87.6219)
        let viewRegion = MKCoordinateRegion(center: centerPoint, latitudinalMeters: miles, longitudinalMeters: miles)
        mapView.setRegion(viewRegion, animated: true)
    }

    
    @IBAction func showFavoritesPlace(_ sender: UIButton) {
        guard let favoritesViewController = storyboard?.instantiateViewController(identifier: "FavoritesViewController") as? FavoritesViewController else { return }
        favoritesViewController.delegate = self
        configurePresentationController(for: favoritesViewController)
        present(favoritesViewController, animated: true)
    }
    
    private func configurePresentationController(for viewController: UIViewController) {
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
    }

    @IBAction func saveFavoritePlace(_ sender: UIButton) {
        guard let name = selectedPlace?.name else { return }
        let isFavorite = DataManager.sharedInstance.isFavorite(name)
        if isFavorite {
            DataManager.sharedInstance.deleteFavorite(name)
        } else {
            DataManager.sharedInstance.saveFavorite(name)
        }
        updateFavoriteButtonState(isFavorite: !isFavorite)
    }
    
    func updateHUD(with place: Place) {
        selectedPlace = place
        placeTitle.text = place.name
        placeDescription.text = place.longDescription
        updateFavoriteButtonState(isFavorite: DataManager.sharedInstance.isFavorite(place.name ?? ""))
    }

}

extension ViewController: PlacesFavoritesDelegate {
    func favoritePlace(name: String) {
        if let thePlace = DataManager.sharedInstance.getPlaceByName(name: name) {
            selectedPlace = thePlace
            updateHUD(with: thePlace)
            if let region = DataManager.sharedInstance.locationFromName(name) {
                mapView.setRegion(region, animated: true)
            }
        }
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let thePlace = view.annotation as? Place {
            updateHUD(with: thePlace)
        }
    }
}
