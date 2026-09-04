// swift-tools-version: 5.9
// This file is GENERATED and published to the public distribution repo
// (complycube/complycube-ios-sdk) by the release pipeline. Do not edit it there
// by hand — edit scripts/spm-package/Package.swift.tmpl in the SDK source repo.
//
// 2.1.2 and c7b46289281a491ad540150e070016495bd83c65e0a363517518b999621e5e53 are substituted at release time:
//   2.1.2  → the release tag (e.g. 2.0.16)
//   c7b46289281a491ad540150e070016495bd83c65e0a363517518b999621e5e53 → swift package compute-checksum ComplyCubeMobileSDK-SPM.zip
//
// The ComplyCube SDK ships as a closed-source binary XCFramework, built as a STATIC
// archive so this package's dependency graph supplies every dependency exactly once.
// (As a dynamic framework the binary hard-linked @rpath/AppAuth.framework and friends,
// which SwiftPM builds as object files, not frameworks — so every consumer app crashed
// on launch with "Library not loaded".)
//
// A .binaryTarget can declare neither dependencies nor resources, so both are carried by
// a separate source target ("ComplyCubeMobileSDKDependencies") vended in the same library
// product. Consumers only ever `import ComplyCubeMobileSDK`.

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
        // IMPORTANT: every version here is EXACT, and must equal the pin in Podfile-spm
        // in the SDK source repo — the version the binary XCFramework was compiled
        // against. scripts/check-spm-dependency-alignment.py enforces the equality.
        //
        // IMPORTANT: these version ranges must stay compatible with the versions the
        // binary XCFramework is COMPILED against — the pins in Podfile-spm in the SDK
        // source repo, which drive the SPM build. Each lower bound is the EXACT compiled-
        // against pin so resolution can never drop below it (GooglePlaces and FingerprintPro
        // in particular ship as closed-source binaries with no cross-minor ABI guarantee);
        // the upper bounds cap the major version so resolution cannot drift onto an
        // ABI-incompatible release.
        .package(url: "https://github.com/getsentry/sentry-cocoa", "8.57.0" ..< "9.0.0"),
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
            url: "https://github.com/complycube/complycube-ios-sdk/releases/download/2.1.2/ComplyCubeMobileSDK-SPM.zip",
            checksum: "c7b46289281a491ad540150e070016495bd83c65e0a363517518b999621e5e53"
        ),
        // Carries what the binary target cannot declare for itself.
        //
        // 1. Dependencies. The static archive leaves every dependency symbol undefined;
        //    these declarations are what resolve them at the consumer's link step.
        // 2. Resources. A static framework has no bundle at runtime — Xcode does not copy
        //    its resources into the app, and `Bundle(for:)` returns `Bundle.main` — so the
        //    SDK's compiled assets and string tables travel as a .bundle copied in here.
        //    `Bundle.baseBundle()` inside the SDK locates it. This is the same shape
        //    GooglePlaces uses for its own static xcframework.
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
            path: "Sources/ComplyCubeMobileSDKDependencies",
            resources: [
                // .copy, not .process: the bundle is already compiled (Assets.car and
                // *.lproj tables) and must be preserved verbatim.
                .copy("Resources/ComplyCubeMobileSDK.bundle")
            ]
        )
    ]
)
