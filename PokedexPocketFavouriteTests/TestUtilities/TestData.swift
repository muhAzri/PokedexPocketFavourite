//
//  TestData.swift
//  PokedexPocketFavouriteTests
//
//  Created by Azri on 31/07/25.
//

import Foundation
import PokedexPocketCore
@testable import PokedexPocketFavourite

struct TestData {
    // MARK: - Constants
    private static let officialArtworkURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/" +
        "pokemon/other/official-artwork"

    // MARK: - Favorite Pokemon Test Data
    static let favoritePikachu = FavoritePokemon(
        id: 25,
        name: "pikachu",
        primaryType: "electric",
        imageURL: "\(officialArtworkURL)/25.png",
        dateAdded: Date(timeIntervalSince1970: 1627689600) // Fixed date for testing
    )

    static let favoriteCharizard = FavoritePokemon(
        id: 6,
        name: "charizard",
        primaryType: "fire",
        imageURL: "\(officialArtworkURL)/6.png",
        dateAdded: Date(timeIntervalSince1970: 1627776000) // Fixed date for testing
    )
}

// MARK: - Test Error Types
enum TestError: Error, LocalizedError {
    case decodingFailed
    case networkFailed
    case repositoryError
    case useCaseError

    var errorDescription: String? {
        switch self {
        case .decodingFailed:
            return "Decoding failed"
        case .networkFailed:
            return "Network failed"
        case .repositoryError:
            return "Repository error"
        case .useCaseError:
            return "Use case error"
        }
    }
}