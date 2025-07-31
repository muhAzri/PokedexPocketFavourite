//
//  FavoritePokemonMapper.swift
//  PokedexPocketFavourite
//
//  Created by Azri on 31/07/25.
//

import Foundation
import PokedexPocketCore

public struct FavoritePokemonMapper {
    public static func toDomain(_ dataModel: FavouritePokemonDataModel) -> FavoritePokemon {
        return FavoritePokemon(
            id: dataModel.pokemonId,
            name: dataModel.name,
            primaryType: dataModel.primaryType,
            imageURL: dataModel.imageURL,
            dateAdded: dataModel.dateAdded
        )
    }

    public static func toDataModel(_ domainEntity: FavoritePokemon) -> FavouritePokemonDataModel {
        return FavouritePokemonDataModel(
            pokemonId: domainEntity.id,
            name: domainEntity.name,
            primaryType: domainEntity.primaryType,
            imageURL: domainEntity.imageURL,
            dateAdded: domainEntity.dateAdded
        )
    }

    public static func toDataModel(from pokemon: FavoritePokemonProtocol) -> FavouritePokemonDataModel {
        return FavouritePokemonDataModel(
            pokemonId: pokemon.id,
            name: pokemon.name,
            primaryType: pokemon.primaryType,
            imageURL: pokemon.imageURL,
            dateAdded: Date()
        )
    }
}
