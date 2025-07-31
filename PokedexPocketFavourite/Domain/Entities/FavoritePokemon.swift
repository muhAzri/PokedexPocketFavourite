//
//  FavoritePokemon.swift
//  PokedexPocketFavourite
//
//  Created by Azri on 31/07/25.
//

import Foundation

public struct FavoritePokemon: Identifiable, Equatable {
    public let id: Int
    public let name: String
    public let primaryType: String
    public let imageURL: String
    public let dateAdded: Date

    public var formattedName: String {
        name.capitalized
    }

    public var pokemonNumber: String {
        String(format: "#%03d", id)
    }

    public init(
        id: Int,
        name: String,
        primaryType: String,
        imageURL: String,
        dateAdded: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.primaryType = primaryType
        self.imageURL = imageURL
        self.dateAdded = dateAdded
    }

    public static func == (lhs: FavoritePokemon, rhs: FavoritePokemon) -> Bool {
        return lhs.id == rhs.id
    }
}