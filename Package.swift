// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Vacastics",
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor/fluent-mysql.git", from: "3.0.0"),
//        .package(url: "https://github.com/vapor/mysql.git", from: "3.0.0"),
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentMySQL", "FluentSQLite", "Vapor"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

