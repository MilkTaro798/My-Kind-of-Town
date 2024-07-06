//
//  PlacesFavoritesDelegate.swift
//  My Kind of Town
//
//  Created by Yutong Sun on 2/6/24.
//

import Foundation

protocol PlacesFavoritesDelegate: AnyObject {
    func favoritePlace(name: String) -> Void
}
