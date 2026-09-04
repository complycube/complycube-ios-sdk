// swift-tools-version: 5.9
// This file is GENERATED and published to the public distribution repo
// (complycube/complycube-ios-sdk) by the release pipeline. Do not edit it there
// by hand — edit scripts/spm-package/Package.swift.tmpl in the SDK source repo.
//
// 2.1.1 and cf862b0d82bafa96af95d50a3c362d51d20b7177f3c286bd7660591693fa470d are substituted at release time:
//   2.1.1  → the release tag (e.g. 2.0.16)
//   cf862b0d82bafa96af95d50a3c362d51d20b7177f3c286bd7660591693fa470d → swift package compute-checksum ComplyCubeMobileSDK-SPM.zip
//
// The ComplyCube SDK ships as a closed-source binary XCFramework. A .binaryTarget
// cannot declare dependencies, so the SDK's runtime dependencies are carried by a
// separate source target ("ComplyCubeMobileSDKDependencies") that is vended in the
// same library product. Consumers only ever `import ComplyCubeMobileSDK`.

import PackageDescription

let package = Package(
    name: "ComplyCubeMobileSDK",
    defaultLocalization: "en",
    // SPM distribution requires iOS 14 — several dependencies below (e.g. GooglePlaces 8.x,
    // JWTDecode 3.x) drop iOS 13. The CocoaPods distribution remains iOS 13.
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "ComplyCubeMobileSDK",
            targets: [
                "ComplyCubeMobileSDK",
                "ComplyCubeMobileSDKDependencies"
            ]
        )
    ],
    dependencies: [
        // IMPORTANT: these version ranges must stay compatible with the versions the
        // binary XCFramework is COMPILED against — the pins in Podfile-spm in the SDK
        // source repo, which drive the SPM build. Each lower bound is the EXACT compiled-
        // against pin so resolution can never drop below it (GooglePlaces and FingerprintPro
        // in particular ship as closed-source binaries with no cross-minor ABI guarantee);
        // the upper bounds cap the major version so resolution cannot drift onto an
        // ABI-incompatible release.
        .package(url: "https://github.com/getsentry/sentry-cocoa", "8.49.0" ..< "9.0.0"),
        .package(url: "https://github.com/googlemaps/ios-places-sdk", "8.5.0" ..< "9.0.0"),
        .package(url: "https://github.com/airbnb/lottie-ios", "4.6.1" ..< "5.0.0"),
        .package(url: "https://github.com/auth0/JWTDecode.swift", "3.3.0" ..< "4.0.0"),
        .package(url: "https://github.com/fingerprintjs/fingerprintjs-pro-ios", "2.12.0" ..< "3.0.0"),
        .package(url: "https://github.com/segmentio/analytics-ios", "4.1.8" ..< "5.0.0"),
        .package(url: "https://github.com/openid/AppAuth-iOS", "2.0.0" ..< "3.0.0")
    ],
    targets: [
        .binaryTarget(
            name: "ComplyCubeMobileSDK",
            url: "https://github.com/complycube/complycube-ios-sdk/releases/download/2.1.1/ComplyCubeMobileSDK-SPM.zip",
            checksum: "cf862b0d82bafa96af95d50a3c362d51d20b7177f3c286bd7660591693fa470d"
        ),
        // Force-links the SDK's runtime dependencies into any app that links the product.
        // The binary target references these modules; this target guarantees SPM resolves
        // and links them so the binary's external symbols are satisfied.
        .target(
            name: "ComplyCubeMobileSDKDependencies",
            dependencies: [
                .product(name: "Sentry", package: "sentry-cocoa"),
                .product(name: "GooglePlaces", package: "ios-places-sdk"),
                .product(name: "Lottie", package: "lottie-ios"),
                .product(name: "JWTDecode", package: "JWTDecode.swift"),
                .product(name: "FingerprintPro", package: "fingerprintjs-pro-ios"),
                .product(name: "Segment", package: "analytics-ios"),
                .product(name: "AppAuth", package: "AppAuth-iOS")
            ],
            path: "Sources/ComplyCubeMobileSDKDependencies"
        )
    ]
)
