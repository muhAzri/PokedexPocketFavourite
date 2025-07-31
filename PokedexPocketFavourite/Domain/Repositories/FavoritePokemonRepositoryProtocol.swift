//
//  FavoritePokemonRepositoryProtocol.swift
//  PokedexPocketFavourite
//
//  Created by Azri on 31/07/25.
//

import Foundation
import RxSwift
import PokedexPocketCore

public protocol FavoritePokemonRepositoryProtocol {
    func addFavorite(pokemon: FavoritePokemonProtocol) -> Observable<Void>
    func removeFavorite(pokemonId: Int) -> Observable<Void>
    func getFavorites() -> Observable<[FavoritePokemon]>
    func isFavorite(pokemonId: Int) -> Observable<Bool>
    func clearAllFavorites() -> Observable<Void>
}

public enum FavoritePokemonError: Error, LocalizedError {
    case addFailed
    case removeFailed
    case fetchFailed
    case clearAllFailed
    case pokemonNotFound

    public var errorDescription: String? {
        switch self {
        case .addFailed:
            return "Failed to add Pokemon to favorites"
        case .removeFailed:
            return "Failed to remove Pokemon from favorites"
        case .fetchFailed:
            return "Failed to fetch favorite Pokemon"
        case .clearAllFailed:
            return "Failed to clear all favorites"
        case .pokemonNotFound:
            return "Pokemon not found in favorites"
        }
    }
}
