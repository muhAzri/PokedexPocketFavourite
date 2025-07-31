//
//  FavouritePokemonView.swift
//  PokedexPocketFavourite
//
//  Created by Azri on 31/07/25.
//

import SwiftUI
import PokedexPocketCore

public struct FavouritePokemonView<CoordinatorType>: View {
    @StateObject private var viewModel: FavoritePokemonViewModel
    let coordinator: CoordinatorType
    let onSwitchTab: () -> Void
    let onNavigateToPokemonDetail: (Int, String) -> Void
    
    @State private var showClearAllAlert = false

    public init(
        viewModel: FavoritePokemonViewModel,
        coordinator: CoordinatorType,
        onSwitchTab: @escaping () -> Void,
        onNavigateToPokemonDetail: @escaping (Int, String) -> Void
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.coordinator = coordinator
        self.onSwitchTab = onSwitchTab
        self.onNavigateToPokemonDetail = onNavigateToPokemonDetail
    }

    public var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    LoadingView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.favorites.isEmpty {
                    EmptyFavouritesView(onSwitchTab: onSwitchTab)
                } else {
                    ScrollView {
                        LazyVGrid(columns: gridColumns, spacing: 16, pinnedViews: []) {
                            ForEach(viewModel.favorites, id: \.id) { pokemon in
                                FavouritePokemonCard(
                                    pokemon: pokemon,
                                    onTap: {
                                        onNavigateToPokemonDetail(pokemon.id, pokemon.name)
                                    },
                                    onRemove: {
                                        viewModel.removeFavorite(pokemonId: pokemon.id)
                                    }
                                )
                                .scaleEffect(viewModel.isClearingAll ? 0.0 : 1.0)
                                .opacity(viewModel.isClearingAll ? 0.0 : 1.0)
                                .animation(.spring(response: 0.6, dampingFraction: 0.8), value: viewModel.isClearingAll)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .refreshable {
                        viewModel.loadFavorites()
                    }
                }
            }
            .navigationTitle("Favourites")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                if !viewModel.favorites.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Clear All") {
                            showClearAllAlert = true
                        }
                        .foregroundColor(.red)
                        .disabled(viewModel.isClearingAll)
                    }
                }
            }
            .alert("Clear All Favourites", isPresented: $showClearAllAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Clear All", role: .destructive) {
                    viewModel.clearAllFavorites()
                }
            } message: {
                Text(
                    "Are you sure you want to remove all \(viewModel.favorites.count) favourite Pokémon? " +
                        "This action cannot be undone."
                )
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("Dismiss") {
                    viewModel.dismissError()
                }
                Button("Retry") {
                    viewModel.retry()
                }
            } message: {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                }
            }
        }
        .onAppear {
            viewModel.loadFavorites()
        }
    }

    private let gridColumns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
}

public struct EmptyFavouritesView: View {
    let onSwitchTab: () -> Void

    public init(onSwitchTab: @escaping () -> Void) {
        self.onSwitchTab = onSwitchTab
    }

    public var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Image(systemName: "heart.slash")
                .font(.system(size: 60))
                .foregroundColor(.gray.opacity(0.5))

            VStack(spacing: 8) {
                Text("No Favourites Yet")
                    .font(.title3)
                    .fontWeight(.semibold)

                Text(
                    "Start exploring Pokémon and add your favorites by tapping the heart icon on " +
                        "any Pokémon detail page."
                )
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 24)
            }

            Button(
                action: {
                    onSwitchTab()
                },
                label: {
                    Text("Explore Pokémon")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            )

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}