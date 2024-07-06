//
//  DataManager.swift
//  My Kind of Town
//
//  Created by Yutong Sun on 2/6/24.
//

import Foundation
import MapKit

public class DataManager {
  
    // MARK: - Singleton Stuff
    public static let sharedInstance = DataManager()
    
    static var places : [Place] {
        return sharedInstance.loadAnnotations()
    }
    private let defaults = UserDefaults.standard
    private let favoritesKey = "favoritesPlaces"
    private var cachedFavorites: [String]?
    //This prevents others from using the default '()' initializer
    fileprivate init() {
        self.cachedFavorites = defaults.array(forKey: favoritesKey) as? [String]
    }
    private func updateCachedFavorites() {
        cachedFavorites = defaults.array(forKey: favoritesKey) as? [String]
    }
    // Your code (these are just example functions, implement what you need)
    
    // MARK: - Favorites Using UserDefaults
    

    func isFavorite(_ name: String) -> Bool {
        guard let theFavorites = cachedFavorites else {
            return false
        }
        return theFavorites.contains(name)
    }
    

    func saveFavorite(_ name: String) {
        var theFavorites = cachedFavorites ?? []
        if !theFavorites.contains(name) {
            theFavorites.append(name)
            defaults.set(theFavorites, forKey: favoritesKey)
            updateCachedFavorites()
            print("\(name) has been added to favorites")
        }
    }
    

    func deleteFavorite(_ name: String) {
        guard var theFavorites = cachedFavorites else { return }
        if let index = theFavorites.firstIndex(of: name) {
            theFavorites.remove(at: index)
            defaults.set(theFavorites, forKey: favoritesKey)
            updateCachedFavorites()
            print("\(name) has been deleted from favorites")
        }
    }
    

    func getPlaceByName(name: String) -> Place? {
        return DataManager.places.first { $0.name == name }
    }
    
    func listFavorites() -> [String] {
        return defaults.array(forKey: favoritesKey) as? [String] ?? []
    }
    
    

    
    // MARK: - Coordinates
    func locationFromName(_ name: String) -> MKCoordinateRegion? {
        guard let place = getPlaceByName(name: name) else { return nil }
        let miles: Double = 20 * 100
        let viewRegion = MKCoordinateRegion(center: place.coordinate, latitudinalMeters: miles, longitudinalMeters: miles)
        return viewRegion
    }
    
    
    func loadRegion() -> MKCoordinateRegion? {
        if let plist = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Data", ofType: "plist")!) {
            if let data = plist["region"] as? [NSNumber] {
                let coordinate = CLLocationCoordinate2DMake(data[0].doubleValue, data[1].doubleValue)
                let span = MKCoordinateSpan(latitudeDelta: data[2].doubleValue, longitudeDelta: data[3].doubleValue)
                return MKCoordinateRegion.init(center: coordinate, span: span)
            }
        }
        return MKCoordinateRegion.init()
    }
    
    func loadAnnotations() -> [Place] {
        if let plist = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Data", ofType: "plist")!) {
            if let data = plist["places"] as? [[String : Any]] {
                let places = data.map { item -> Place in
                    let place = Place()
                    place.coordinate = CLLocationCoordinate2DMake(item["lat"]! as! CLLocationDegrees, item["long"] as! CLLocationDegrees)
                    place.name = item["name"] as? String
                    place.longDescription = item["description"] as? String
                    return place
                }
                return places
            }
        }
        return []
            
    }
    
}
