# ComplyCube iOS SDK

The ComplyCube iOS SDK makes it quick and easy to build a frictionless customer onboarding and biometric re-authentication experience in your iOS app. We provide powerful, smart, and customizable UI screens that can be used out-of-the-box to capture the data you need for identity verification. This SDK supports both UIKit and SwiftUI, giving developers flexibility in choosing the UI framework that best fits their needs.

> :information_source: Please get in touch with your **Account Manager** or **[support](https://support.complycube.com/hc/en-gb/requests/new)** to get access to our Mobile SDK.

> :warning: If you were using our previous generation SDK (deprecated), please migrate to this one. Get in touch with support if you have any questions.

## Table of contents

- [Features](#features)
- [Requirements](#requirements)
- [Getting started](#getting-started)
  - [1. Installing the SDK](#1-installing-the-sdk)
    - [CocoaPods](#cocoapods)
    - [Application permissions](#application-permissions)
- [Going live](#going-live)
- [Additional info](#additional-info)

## Features

<img
 src="https://assets.complycube.com/images/complycube-ios-sdk-github.jpg"
 alt="ComplyCube iOS SDK illustrations."
/>

**Native & intuitive UI**: We provide mobile-native screens that guide your customers in capturing their selfies, video recordings, government-issued IDs (such as passports, driving licenses, and residence permits), and proof of address documents (bank statements and utility bills)

**Liveness**: Our market-leading liveness detection provides accurate and extremely fast presence detection on your customers' selfies (3D Passive and Active) and documents to prevent fraud and protect your business. It detects and deters several spoofing vectors, including **printed photo attacks**, **printed mask attacks**, **video replay attacks**, and **3D mask attacks**.

**Auto-capture**: Our UI screens attempt to auto-capture your customer's documents and selfies and run quality checks to ensure that only legible captures are processed by our authentication service.

**Branding & customization**: You can customize the experience by adding your brand colors and text. Furthermore, screens can be added and removed.

**ComplyCube API**: Our [REST API](https://docs.complycube.com/api-reference) can be used to build entirely custom flows on top of this native mobile UI layer. We offer backend SDK libraries ([Node.js](https://www.npmjs.com/package/@complycube/api), [PHP](https://github.com/complycube/complycube-php), [Python](https://pypi.org/project/complycube/), and [.NET](https://www.nuget.org/packages/Complycube/)) to facilitate custom integrations.

**Localized**: We offer multiple localization options to fit your customer needs.

**Secure**: Our GPDR, CCPA, and ISO-certified platform ensure secure and data privacy-compliant end-to-end capture.

## Requirements

- Swift 5
- iOS 11 and above
- Xcode 13 and above

## Getting started

Get started with our [user guide](https://doc.complycube.com) for an overview of our core platform and its multiple features, or browse the [API reference](https://docs.complycube.com/api-reference) for fine-grained documentation of all our services.

<p align="center">
<img
 src="https://assets.complycube.com/images/github-mobile-sdk-flow.png"
 alt="ComplyCube Mobile SDK integration flow."
/>
Mobile SDK integration flow
</p>

### Installing the SDK

#### CocoaPods

1. Before using the ComplyCube SDK, install the Cocoapods Artifactory plugin by running the following command in your terminal:

   ```bash
   gem install cocoapods-art
   ```

2. To add the library, copy your repository credentials into a `.netrc` file to your home directory and setup the repository:

   ```bash
   pod repo-art add cc-cocoapods-release-local "https://complycuberepo.jfrog.io/artifactory/api/pods/cc-cocoapods-release-local"
   ```
   Remember to fetch your credentials from Jfrog using the Set Me Up button [here](https://complycuberepo.jfrog.io/ui/repos/tree/General/cc-cocoapods-release-local) 
   
   
3. Add plugin repos and install the pod using your `Podfile`.

   ```ruby
    plugin 'cocoapods-art', :sources => [
      'cc-cocoapods-release-local'
    ]

    ...

    platform :ios, '13.0' # Or above

    target 'YourApp' do

      use_frameworks!
      use_modular_headers!

      ...
      pod 'ComplyCubeMobileSDK'
      ...
    end
   ```

#### Application permissions

Our SDK uses the device camera and microphone for capture. You must add the following keys to your application `Info.plist` file.

- `NSCameraUsageDescription`

```xml
<key>NSCameraUsageDescription</key>
<string>Used to capture facials biometrics and documents</string>
```

- `NSMicrophoneUsageDescription`

```xml
<key>NSMicrophoneUsageDescription</key>
<string>Used to capture video biometrics</string>
```

#### Integrating the SDK

Follow our step-by-step guide on integrating the SDK [here](https://docs.complycube.com/documentation/guides/mobile-sdk-guide/mobile-sdk-integration-guide)

#### Running the Project

To run the ComplyCube iOS SDK project, follow these steps:

1. After download the project and following the installation of the SDK you open the project in Xcode selecting either the UIKit or SwiftUI project.

2. Build and run the project using the standard Xcode build and run buttons.

3. Ensure that you have the required dependencies installed using CocoaPods as mentioned in the Installation section. Additionally, make sure to replace the placeholder API key in the example projects with your actual ComplyCube API key.