//
//  FavouritePokemonDataModel.swift
//  PokedexPocketFavourite
//
//  Created by Azri on 31/07/25.
//

import SwiftData
import Foundation

@Model
public final class FavouritePokemonDataModel {
    @Attribute(.unique) public var pokemonId: Int
    public var name: String
    public var primaryType: String
    public var imageURL: String
    public var dateAdded: Date

    public init(pokemonId: Int, name: String, primaryType: String, imageURL: String, dateAdded: Date = Date()) {
        self.pokemonId = pokemonId
        self.name = name
        self.primaryType = primaryType
        self.imageURL = imageURL
        self.dateAdded = dateAdded
    }
}