//
//  AddFavoritePokemonUseCase.swift
//  PokedexPocketFavourite
//
//  Created by Azri on 31/07/25.
//

import Foundation
import RxSwift
import PokedexPocketCore

public protocol AddFavoritePokemonUseCaseProtocol {
    func execute(pokemon: FavoritePokemonProtocol) -> Observable<Void>
}

public class AddFavoritePokemonUseCase: AddFavoritePokemonUseCaseProtocol {
    private let repository: FavoritePokemonRepositoryProtocol

    public init(repository: FavoritePokemonRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(pokemon: FavoritePokemonProtocol) -> Observable<Void> {
        return repository.addFavorite(pokemon: pokemon)
    }
}
