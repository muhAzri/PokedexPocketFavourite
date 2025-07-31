//
//  FavoritePokemonRepository.swift
//  PokedexPocketFavourite  
//
//  Created by Azri on 31/07/25.
//

import Foundation
import SwiftData
import RxSwift
import PokedexPocketCore

public class FavoritePokemonRepository: FavoritePokemonRepositoryProtocol {
    private let modelContext: ModelContext

    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    public func addFavorite(pokemon: FavoritePokemonProtocol) -> Observable<Void> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(FavoritePokemonError.addFailed)
                return Disposables.create()
            }

            do {
                let dataModel = FavoritePokemonMapper.toDataModel(from: pokemon)
                self.modelContext.insert(dataModel)
                try self.modelContext.save()
                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(FavoritePokemonError.addFailed)
            }

            return Disposables.create()
        }
    }

    public func removeFavorite(pokemonId: Int) -> Observable<Void> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(FavoritePokemonError.removeFailed)
                return Disposables.create()
            }

            do {
                let descriptor = FetchDescriptor<FavouritePokemonDataModel>(
                    predicate: #Predicate { $0.pokemonId == pokemonId }
                )

                let results = try self.modelContext.fetch(descriptor)

                guard let pokemonToDelete = results.first else {
                    observer.onError(FavoritePokemonError.pokemonNotFound)
                    return Disposables.create()
                }

                self.modelContext.delete(pokemonToDelete)
                try self.modelContext.save()
                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(FavoritePokemonError.removeFailed)
            }

            return Disposables.create()
        }
    }

    public func getFavorites() -> Observable<[FavoritePokemon]> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(FavoritePokemonError.fetchFailed)
                return Disposables.create()
            }

            do {
                let descriptor = FetchDescriptor<FavouritePokemonDataModel>(
                    sortBy: [SortDescriptor(\.dateAdded, order: .reverse)]
                )

                let results = try self.modelContext.fetch(descriptor)
                let favorites = results.map { FavoritePokemonMapper.toDomain($0) }
                observer.onNext(favorites)
                observer.onCompleted()
            } catch {
                observer.onError(FavoritePokemonError.fetchFailed)
            }

            return Disposables.create()
        }
    }

    public func isFavorite(pokemonId: Int) -> Observable<Bool> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(FavoritePokemonError.fetchFailed)
                return Disposables.create()
            }

            do {
                let descriptor = FetchDescriptor<FavouritePokemonDataModel>(
                    predicate: #Predicate { $0.pokemonId == pokemonId }
                )

                let results = try self.modelContext.fetch(descriptor)
                observer.onNext(!results.isEmpty)
                observer.onCompleted()
            } catch {
                observer.onError(FavoritePokemonError.fetchFailed)
            }

            return Disposables.create()
        }
    }

    public func clearAllFavorites() -> Observable<Void> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(FavoritePokemonError.clearAllFailed)
                return Disposables.create()
            }

            do {
                let descriptor = FetchDescriptor<FavouritePokemonDataModel>()
                let results = try self.modelContext.fetch(descriptor)

                for pokemon in results {
                    self.modelContext.delete(pokemon)
                }

                try self.modelContext.save()
                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(FavoritePokemonError.clearAllFailed)
            }

            return Disposables.create()
        }
    }
}
