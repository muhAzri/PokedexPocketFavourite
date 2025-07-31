//
//  RemoveFavoritePokemonUseCase.swift
//  PokedexPocketFavourite
//
//  Created by Azri on 31/07/25.
//

import Foundation
import RxSwift

public protocol RemoveFavoritePokemonUseCaseProtocol {
    func execute(pokemonId: Int) -> Observable<Void>
}

public class RemoveFavoritePokemonUseCase: RemoveFavoritePokemonUseCaseProtocol {
    private let repository: FavoritePokemonRepositoryProtocol

    public init(repository: FavoritePokemonRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(pokemonId: Int) -> Observable<Void> {
        return repository.removeFavorite(pokemonId: pokemonId)
    }
}