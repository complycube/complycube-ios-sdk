# ComplyCube Example App

This repository provides a pre-built UI that uses the ComplyCube SDK. It guides you through the ComplyCube identity verification process, which includes collecting client ID documents, proof of address documents, and biometric selfies.

> :information_source: Please get in touch with your **Account Manager** or **[support](https://support.complycube.com/hc/en-gb/requests/new)** to get access to our Mobile SDK.

## To run the app

### Install CocoaPods

1. Before using the ComplyCube SDK, install the Cocoapods Artifactory plugin by running the following command in your terminal:

   ```bash
   gem install cocoapods-art
   ```

2. To add the library, copy your repository credentials into a `.netrc` file to your home directory and setup the repository:

   ```bash
   pod repo-art add cc-cocoapods-release-local "https://complycuberepo.jfrog.io/artifactory/api/pods/cc-cocoapods-release-local"
   ```

Remember to fetch your credentials from Jfrog using the **Set Me Up** button [here](https://complycuberepo.jfrog.io/ui/repos/tree/General/cc-cocoapods-release-local).

### Using UIKit

1. In your terminal, navigate to `complycube-ios-sdk/UIKit/` and run `pod install`.
2. Open `complycube-ios-sdk/UIKit/SampleApp.xcworkspace` in Xcode.
3. [Generate an SDK token](https://docs.complycube.com/documentation/guides/mobile-sdk-guide/mobile-sdk-integration-guide#id-3.-generate-an-sdk-token), and replace `SDK_TOKEN` in `complycube-ios-sdk/UIKit/SampleApp/ViewController.swift` with the generated token.
4. [Generate a client ID](https://docs.complycube.com/documentation/guides/mobile-sdk-guide/mobile-sdk-integration-guide#id-2.-create-a-client), and replace `CLIENT_ID` in `complycube-ios-sdk/UIKit/SampleApp/ViewController.swift` with the generated ID.

### Using SwiftUI

1. In your terminal, navigate to `complycube-ios-sdk/SwiftUI/` and run `pod install`.
2. Open `complycube-ios-sdk/SwiftUI/SampleApp.xcworkspace` in Xcode.
3. [Generate an SDK token](https://docs.complycube.com/documentation/guides/mobile-sdk-guide/mobile-sdk-integration-guide#id-3.-generate-an-sdk-token), and replace `SDK_TOKEN` in `complycube-ios-sdk/SwiftUI/SampleApp/ContentView.swift` with the generated token.
4. [Generate a client ID](https://docs.complycube.com/documentation/guides/mobile-sdk-guide/mobile-sdk-integration-guide#id-2.-create-a-client), and replace `CLIENT_ID` in `complycube-ios-sdk/UIKit/SampleApp/ViewController.swift` with the generated ID.

## Integrating our SDK

For detailed instructions on integrating our SDK, please refer to our [integration guide](https://docs.complycube.com/documentation/guides/mobile-sdk-guide/mobile-sdk-integration-guide).

For an overview of our core platform and its multiple features, please refer to our [user guide](https://doc.complycube.com) or browse the [API reference](https://docs.complycube.com/api-reference) for fine-grained documentation of all our services.
