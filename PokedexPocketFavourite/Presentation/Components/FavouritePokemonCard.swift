//
//  FavouritePokemonCard.swift
//  PokedexPocketFavourite
//
//  Created by Azri on 31/07/25.
//

import SwiftUI
import PokedexPocketCore

public struct FavouritePokemonCard: View {
    public let pokemon: FavoritePokemon
    public let onTap: () -> Void
    public let onRemove: () -> Void
    
    @State private var isRemoving = false
    @State private var heartBreakOffset: CGFloat = 0
    @State private var heartBreakRotation: Double = 0
    @State private var showHeartBreak = false
    @State private var cardOpacity: Double = 1.0
    @State private var cardOffset: CGFloat = 0

    public init(pokemon: FavoritePokemon, onTap: @escaping () -> Void, onRemove: @escaping () -> Void) {
        self.pokemon = pokemon
        self.onTap = onTap
        self.onRemove = onRemove
    }

    public var body: some View {
        VStack(spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            colors: [
                                typeColor(for: pokemon.primaryType).opacity(0.1),
                                typeColor(for: pokemon.primaryType).opacity(0.05)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(typeColor(for: pokemon.primaryType).opacity(0.3), lineWidth: 1)
                    )

                VStack(spacing: 12) {
                    HStack {
                        Spacer()
                        Button(
                            action: {
                                performRemovalAnimation()
                            },
                            label: {
                                ZStack {
                                    Image(systemName: "heart.fill")
                                        .font(.caption)
                                        .foregroundColor(.red)
                                        .scaleEffect(isRemoving ? 0.8 : 1.0)
                                        .opacity(showHeartBreak ? 0 : 1)

                                    if showHeartBreak {
                                        HStack(spacing: 1) {
                                            Image(systemName: "heart.slash")
                                                .font(.caption2)
                                                .foregroundColor(.red)
                                                .offset(x: -heartBreakOffset, y: heartBreakOffset)
                                                .rotationEffect(.degrees(-heartBreakRotation))

                                            Image(systemName: "heart.slash")
                                                .font(.caption2)
                                                .foregroundColor(.red)
                                                .offset(x: heartBreakOffset, y: -heartBreakOffset)
                                                .rotationEffect(.degrees(heartBreakRotation))
                                        }
                                    }
                                }
                            }
                        )
                    }
                    .padding(.top, 8)
                    .padding(.trailing, 8)

                    Spacer()

                    AsyncImage(
                        url: URL(string: pokemon.imageURL),
                        transaction: Transaction(animation: .easeInOut(duration: 0.3))
                    ) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .transition(.opacity)
                        case .failure:
                            Circle()
                                .fill(typeColor(for: pokemon.primaryType).opacity(0.2))
                                .overlay(
                                    Image(systemName: "photo")
                                        .foregroundColor(.secondary)
                                )
                        case .empty:
                            Circle()
                                .fill(typeColor(for: pokemon.primaryType).opacity(0.2))
                                .overlay(
                                    ProgressView()
                                        .scaleEffect(0.7)
                                )
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 80, height: 80)
                    .id(pokemon.imageURL)

                    VStack(spacing: 6) {
                        Text(pokemon.pokemonNumber)
                            .font(.caption2)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)

                        Text(pokemon.formattedName)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)

                        TypeBadge(type: pokemon.primaryType, color: typeColor(for: pokemon.primaryType))
                    }

                    Spacer()
                }
                .padding(.bottom, 16)
            }
            .aspectRatio(0.8, contentMode: .fit)
        }
        .onTapGesture {
            onTap()
        }
        .scaleEffect(isRemoving ? 0.95 : 1.0)
        .opacity(cardOpacity)
        .offset(x: cardOffset)
        .rotationEffect(.degrees(isRemoving ? 5 : 0))
    }

    private func performRemovalAnimation() {
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()

        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            isRemoving = true
        }

        withAnimation(.easeOut(duration: 0.3)) {
            showHeartBreak = true
            heartBreakOffset = 10
            heartBreakRotation = 30
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.easeInOut(duration: 0.4)) {
                cardOffset = -300
                cardOpacity = 0.0
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            onRemove()
        }
    }

    private func typeColor(for type: String) -> Color {
        let typeColors: [String: Color] = [
            "grass": Color(red: 0.48, green: 0.78, blue: 0.36),
            "fire": Color(red: 0.93, green: 0.41, blue: 0.26),
            "water": Color(red: 0.39, green: 0.56, blue: 0.89),
            "electric": Color(red: 0.98, green: 0.81, blue: 0.16),
            "psychic": Color(red: 0.98, green: 0.41, blue: 0.68),
            "ice": Color(red: 0.58, green: 0.89, blue: 0.89),
            "dragon": Color(red: 0.45, green: 0.31, blue: 0.97),
            "dark": Color(red: 0.43, green: 0.33, blue: 0.25),
            "fairy": Color(red: 0.84, green: 0.51, blue: 0.84),
            "poison": Color(red: 0.64, green: 0.35, blue: 0.68),
            "ground": Color(red: 0.89, green: 0.75, blue: 0.42),
            "flying": Color(red: 0.66, green: 0.73, blue: 0.89),
            "bug": Color(red: 0.64, green: 0.73, blue: 0.18),
            "rock": Color(red: 0.71, green: 0.63, blue: 0.42),
            "ghost": Color(red: 0.43, green: 0.35, blue: 0.60),
            "steel": Color(red: 0.69, green: 0.69, blue: 0.81),
            "fighting": Color(red: 0.75, green: 0.19, blue: 0.16),
            "normal": Color(red: 0.66, green: 0.66, blue: 0.47)
        ]
        return typeColors[type.lowercased()] ?? Color.gray
    }
}