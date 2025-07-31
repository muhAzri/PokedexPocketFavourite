//
//  ClearAllFavoritesUseCase.swift
//  PokedexPocketFavourite
//
//  Created by Azri on 31/07/25.
//

import Foundation
import RxSwift

public protocol ClearAllFavoritesUseCaseProtocol {
    func execute() -> Observable<Void>
}

public class ClearAllFavoritesUseCase: ClearAllFavoritesUseCaseProtocol {
    private let repository: FavoritePokemonRepositoryProtocol

    public init(repository: FavoritePokemonRepositoryProtocol) {
        self.repository = repository
    }

    public func execute() -> Observable<Void> {
        return repository.clearAllFavorites()
    }
}