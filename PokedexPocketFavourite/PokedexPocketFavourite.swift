//
//  PokedexPocketFavourite.swift
//  PokedexPocketFavourite
//
//  Created by Azri on 31/07/25.
//

// Re-export all public APIs
@_exported import Foundation
@_exported import SwiftUI  
@_exported import SwiftData
@_exported import RxSwift
@_exported import PokedexPocketCore

// MARK: - Framework Version Info
public struct PokedexPocketFavourite {
    public static let version = "1.0.0"
    public static let buildNumber = "1"
    
    public static var frameworkInfo: String {
        return "PokedexPocketFavourite v\(version) (\(buildNumber))"
    }
}


