//
//  PokedexPocketFavourite.swift
//  PokedexPocketFavourite
//
//  Created by Azri on 31/07/25.
//

import Foundation
import SwiftUI
import SwiftData
import RxSwift
import PokedexPocketCore

// MARK: - Framework Version Info
public struct PokedexPocketFavourite {
    public static let version = "1.0.0"
    public static let buildNumber = "1"
    
    public static var frameworkInfo: String {
        return "PokedexPocketFavourite v\(version) (\(buildNumber))"
    }
}

