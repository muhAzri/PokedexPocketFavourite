// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PokedexPocketFavourite",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(
            name: "PokedexPocketFavourite",
            targets: ["PokedexPocketFavourite"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.9.0"),
        .package(url: "https://github.com/muhAzri/PokedexPocketCore", branch: "main")
    ],
    targets: [
        .target(
            name: "PokedexPocketFavourite",
            dependencies: [
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "PokedexPocketCore", package: "PokedexPocketCore")
            ],
            path: "PokedexPocketFavourite"
        ),
        .testTarget(
            name: "PokedexPocketFavouriteTests",
            dependencies: [
                "PokedexPocketFavourite",
                .product(name: "RxBlocking", package: "RxSwift"),
                .product(name: "RxTest", package: "RxSwift")
            ],
            path: "PokedexPocketFavouriteTests"
        ),
    ]
)