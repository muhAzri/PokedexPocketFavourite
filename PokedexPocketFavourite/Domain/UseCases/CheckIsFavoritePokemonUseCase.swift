//
//  CheckIsFavoritePokemonUseCase.swift
//  PokedexPocketFavourite
//
//  Created by Azri on 31/07/25.
//

import Foundation
import RxSwift

public protocol CheckIsFavoritePokemonUseCaseProtocol {
    func execute(pokemonId: Int) -> Observable<Bool>
}

public class CheckIsFavoritePokemonUseCase: CheckIsFavoritePokemonUseCaseProtocol {
    private let repository: FavoritePokemonRepositoryProtocol

    public init(repository: FavoritePokemonRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(pokemonId: Int) -> Observable<Bool> {
        return repository.isFavorite(pokemonId: pokemonId)
    }
}