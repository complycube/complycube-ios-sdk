# ComplyCube iOS Example Apps

This repository contains UIKit and SwiftUI examples for the non-NFC ComplyCube Mobile SDK `2.1.0`. Both examples use the check-driven integration and collect:

- an identity document (passport or a GB/FR national identity card)
- a biometric video selfie
- a proof-of-address document

The SDK supports iOS 13 and later. The included UIKit project currently targets iOS 15.2, and the SwiftUI project targets iOS 16.1.

## Before you start

You need:

1. A Mac with Xcode installed.
2. A real iPhone or iPad. A real device is recommended because the flow uses the camera and microphone.
3. CocoaPods.
4. A Client ID and a fresh SDK token supplied by your backend.

Never put a ComplyCube API key in an iOS app. Your backend must create the client and SDK token. Generate a new SDK token each time a verification flow starts, and make sure the token's `appId` matches the sample app's bundle identifier.

## 1. Install CocoaPods

Open the Terminal app and run:

```bash
gem install cocoapods
```

If your company uses Bundler, install and run CocoaPods through the repository's bundle instead.

Check the installation:

```bash
pod --version
```

## 2. Get a Client ID and SDK token

Ask your backend engineer for:

- `CLIENT_ID`: created with the [Clients API](https://docs.complycube.com/documentation/api-reference/clients)
- `SDK_TOKEN`: generated with the [SDK Tokens API](https://docs.complycube.com/documentation/api-reference/other-resources/tokens)

Tokens are short-lived and must not be reused. If the app reports an expired-token error, request a new token.

For production, replace the placeholders with a request to your backend. Direct replacement is only intended for locally testing these example apps.

## Run the UIKit example

1. In Terminal, move into the UIKit folder:

   ```bash
   cd complycube-ios-sdk/UIKit
   ```

2. Install the SDK:

   ```bash
   pod install
   ```

3. Open `UIKit/SampleApp.xcworkspace` in Xcode. Do not open the `.xcodeproj` file.
4. Open `SampleApp/ViewController.swift` and replace `CLIENT_ID` and `SDK_TOKEN` with fresh values.
5. In Xcode's left sidebar, select the blue **SampleApp** project, select the **SampleApp** target, then open **Signing & Capabilities**.
6. Select your Apple development team. If Xcode reports that the bundle identifier is unavailable, replace it with a unique value and ask your backend engineer to generate the SDK token using that same value as `appId`.
7. Connect and unlock your iPhone or iPad, select it from the device menu at the top of Xcode, and press the Run button (the triangle).
8. Tap **Onboard Client** in the app.

Completion, cancellation, and error details are printed in Xcode's debug console.

## Run the SwiftUI example

1. In Terminal, move into the SwiftUI folder:

   ```bash
   cd complycube-ios-sdk/SwiftUI
   ```

2. Install the SDK:

   ```bash
   pod install
   ```

3. Open `SwiftUI/SampleApp.xcworkspace` in Xcode. Do not open the `.xcodeproj` file.
4. Open `SampleApp/ContentView.swift` and replace `CLIENT_ID` and `SDK_TOKEN` with fresh values.
5. Select the **SampleApp** project and target, open **Signing & Capabilities**, and select your Apple development team.
6. If you change the bundle identifier, request a new SDK token whose `appId` matches it.
7. Connect and unlock your iPhone or iPad, select it in Xcode, and press Run.
8. Tap **Start verification**.

The current flow status appears in the app and full details are printed in Xcode's debug console.

## If the app closes immediately after launch

If Xcode reports a missing `LottieLoopMode.loop` symbol, refresh the CocoaPods project and clear the previously built app:

1. Close the project in Xcode.
2. Run `pod install` again from the example's `UIKit` or `SwiftUI` folder.
3. Reopen the example's `.xcworkspace` file.
4. In Xcode, select **Product > Clean Build Folder**.
5. Delete the existing SampleApp from the iPhone or iPad.
6. Press Run in Xcode to install a fresh copy.

Both example Podfiles enable library evolution for Lottie. This is required because ComplyCube Mobile SDK `2.1.0` is a precompiled framework and expects Lottie's public Swift symbols at runtime.

## Manual test checklist

Run this checklist for both examples:

1. The app installs and opens without crashing.
2. Starting verification opens the ComplyCube flow.
3. The app asks for camera and microphone permission. Select **Allow**.
4. The document screen offers Passport and national identity cards from GB and FR.
5. Document capture or upload can be completed.
6. The video-selfie stage records successfully.
7. The proof-of-address stage accepts a document.
8. Completing the flow produces a success result.
9. Start again, close the flow, and confirm that cancellation is reported.
10. Test with an expired or deliberately invalid SDK token and confirm that an error is reported rather than an app crash.

Use test identities and documents approved by ComplyCube. Do not use real customer data in a development environment unless your organisation has explicitly approved it.

## Integration guidance

These examples deliberately use configurable SDK stages (the check-driven approach). For most production integrations, ComplyCube recommends the [workflow integration](https://docs.complycube.com/documentation/sdks/mobile-integrations/ios-sdk/workflow-integration), which keeps the verification journey centrally configured.

See the [iOS SDK documentation](https://docs.complycube.com/documentation/sdks/mobile-integrations/ios-sdk/workflow-integration), [ComplyCube user guide](https://docs.complycube.com), and [API reference](https://docs.complycube.com/documentation/api-reference) for production integration details.

## About ComplyCube

[ComplyCube](https://www.complycube.com/en) provides identity verification, AML, and KYC services through APIs, SDKs, and hosted integration options.
