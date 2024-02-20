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

> :information_source: Remember to fetch your credentials from Jfrog using the **Set Me Up** button [here](https://complycuberepo.jfrog.io/ui/repos/tree/General/cc-cocoapods-release-local).

### Using UIKit

1. In your terminal, navigate to `complycube-ios-sdk/UIKit/` and run `pod install`.
2. Open `complycube-ios-sdk/UIKit/SampleApp.xcworkspace` in Xcode.
3. [Create a Client ID](https://docs.complycube.com/documentation/guides/mobile-sdk-guide/mobile-sdk-integration-guide#id-2.-create-a-client).
4. [Generate an SDK token](https://docs.complycube.com/documentation/guides/mobile-sdk-guide/mobile-sdk-integration-guide#id-3.-generate-an-sdk-token).
5. In the `complycube-ios-sdk/UIKit/SampleApp/ViewController.swift` file, replace `CLIENT_ID` and `SDK_TOKEN` with the generated values from the previous steps.

### Using SwiftUI

1. In your terminal, navigate to `complycube-ios-sdk/SwiftUI/` and run `pod install`.
2. Open `complycube-ios-sdk/SwiftUI/SampleApp.xcworkspace` in Xcode.
3. [Create a Client ID](https://docs.complycube.com/documentation/guides/mobile-sdk-guide/mobile-sdk-integration-guide#id-2.-create-a-client).
4. [Generate an SDK token](https://docs.complycube.com/documentation/guides/mobile-sdk-guide/mobile-sdk-integration-guide#id-3.-generate-an-sdk-token).
5. In the `complycube-ios-sdk/SwiftUI/SampleApp/ContentView.swift` file, replace `CLIENT_ID` and `SDK_TOKEN` with the generated values from the previous steps.

## Integrating our SDK

For detailed instructions on integrating our SDK, please refer to our [integration guide](https://docs.complycube.com/documentation/guides/mobile-sdk-guide/mobile-sdk-integration-guide).

For an overview of our core platform and its multiple features, please refer to our [user guide](https://docs.complycube.com) or browse the [API reference](https://docs.complycube.com/api-reference) for fine-grained documentation of all our services.


## About ComplyCube

[ComplyCube](https://www.complycube.com/en), an award-winning SaaS & API platform, offers innovative Identity Verification (IDV), Anti-Money Laundering (AML), and Know Your Customer (KYC) compliance solutions. Its extensive customer base spans several industries, such as financial services, transport, healthcare, e-commerce, cryptocurrency, FinTech, and telecoms, making ComplyCube a leading figure in the IDV space.
<br>
<br>
This ISO-certified platform is notable for its quick omnichannel integration and a wide range of services. It provides Low/No-Code solutions, robust API, Mobile SDKs, Client Libraries, and smooth CRM integrations.
