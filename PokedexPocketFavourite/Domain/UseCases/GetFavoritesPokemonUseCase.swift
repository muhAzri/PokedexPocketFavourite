//
//  GetFavoritesPokemonUseCase.swift
//  PokedexPocketFavourite
//
//  Created by Azri on 31/07/25.
//

import Foundation
import RxSwift

public protocol GetFavoritesPokemonUseCaseProtocol {
    func execute() -> Observable<[FavoritePokemon]>
}

public class GetFavoritesPokemonUseCase: GetFavoritesPokemonUseCaseProtocol {
    private let repository: FavoritePokemonRepositoryProtocol

    public init(repository: FavoritePokemonRepositoryProtocol) {
        self.repository = repository
    }

    public func execute() -> Observable<[FavoritePokemon]> {
        return repository.getFavorites()
    }
}