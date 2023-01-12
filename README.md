# ComplyCube iOS SDK

The ComplyCube iOS SDK makes it quick and easy to build a frictionless customer onboarding and biometric re-authentication experience in your iOS app. We provide powerful, smart, and customizable UI screens that can be used out-of-the-box to capture the data you need for identity verification.

> :information_source: Please get in touch with your **Account Manger** or **[support](https://support.complycube.com/hc/en-gb/requests/new)** to get access to our Mobile SDK.

> :warning: If you were using our previous generation SDK (deprecated), please migrate to this one. Get in touch with support if you have any questions.

## Table of contents

- [Features](#features)
- [Requirements](#requirements)
- [Getting started](#getting-started)
  * [1. Installing the SDK](#1-installing-the-sdk)
  * [2. Creating a client](#2-creating-a-client)
    + [Example request](#example-request)
    + [Example response](#example-response)
  * [3. Creating an SDK token](#3-creating-an-sdk-token)
    + [Example request](#example-request-1)
    + [Example response](#example-response-1)
  * [4. Initialize a flow with default settings](#4-initialize-a-flow-with-default-settings)
  * [5. Perform checks](#5-perform-checks)
    + [Example request](#example-request-2)
  * [6. Setup webhooks and retrieve results](#6-setup-webhooks-and-retrieve-results)
- [Customization](#customization)
  * [Customizing stages](#customizing-stages)
      - [Welcome stage](#welcome-stage)
      - [Consent stage](#consent-stage)
      - [Document stage](#document-stage)
      - [Selfie photo and video stage](#selfie-photo-and-video-stage)
      - [Proof of address stage](#proof-of-address-stage)
  * [Customizing appearance](#customizing-appearance)
  * [Result handling](#result-handling)
  * [Error handling](#error-handling)
    + [Runtime errors](#runtime-errors)
    + [Invalid configuration exceptions](#invalid-configuration-exceptions)
  * [Localization](#localization)
  * [Going live](#going-live)
  * [Additional info](#additional-info)

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

* Swift 5
* iOS 11+
* Xcode 13+

## Getting started

Get started with our [user guide](https://doc.complycube.com) for an overview of our core platform and its multiple features, or browse the [API reference](https://docs.complycube.com/api-reference) for fine-grained documentation of all our services.

<p align="center">
<img 
	src="https://assets.complycube.com/images/github-mobile-sdk-flow.png" 
	alt="ComplyCube Mobile SDK integration flow."
/>
Mobile SDK integration flow
</p>


### Installation

#### CocoaPods

1. Before using the ComplyCube SDK, install the Cocoapods Artifactory plugin by running the following command in your terminal:

```bash
gem install cocoapods-art
```

2. To add the library, copy your repository credentials into a `.netrc` file to your home directory and setup the repository:

```bash
pod repo-art add cc-cocoapods-local "https://complycuberepo.jfrog.io/artifactory/api/pods/cc-cocoapods-local"
```

3. Add plugin repos and install the pod using your `Podfile`.

```ruby
plugin 'cocoapods-art', :sources => [
  'cc-cocoapods-release-local'
]
...

target 'YourApp' do
    ...
	pod 'ComplyCube'
    ...
end

```

#### Application permissions

Our SDK uses the device camera and microphone for capture. You must add the following keys to your application `Info.plist` file.

* `NSCameraUsageDescription`

```json
<key>NSCameraUsageDescription</key>
<string>Used to capture facials biometrics and documents</string>
```

* `NSMicrophoneUsageDescription`

```json
<key>NSMicrophoneUsageDescription</key>
<string>Used to capture video biometrics</string>
```

Start by adding your access credentials for the ComplyCube SDK repository to the `gradle.properties` file of your **mobile app**:

```gradle
artifactory_user= "USERNAME"
artifactory_password= "ENCRYPTED PASS"
artifactory_contextUrl= https://complycuberepo.jfrog.io/artifactory
```

Then update your application `build.gradle` file with the ComplyCube SDK repository maven settings and SDK dependency:

```gradle
plugins {
    ...
    id "com.jfrog.artifactory"
}

repositories {
    mavenCentral()
    google()
    artifactory {
        contextUrl = "${artifactory_contextUrl}"  
        resolve {
            repository {
                repoKey = 'complycube-sdk-gradle-release-local'
                username = "${artifactory_user}"
                password = "${artifactory_password}"
                maven = true

            }
        }
    }
}

dependencies {
    implementation "com.complycube:sdk:+"
    ...
}
```

### 2. Creating a client

Before launching the SDK, your app must first [create a client](https://docs.complycube.com/api-reference/clients/create-a-client) using the ComplyCube API.

A client represents the individual on whom you need to perform identity verification checks on. A client is required to generate an SDK token. 

This must be done on your **mobile app backend** server.

#### Example request

```bash
curl -X POST https://api.complycube.com/v1/clients \
     -H 'Authorization: <YOUR_API_KEY>' \
     -H 'Content-Type: application/json' \
     -d '{  "type": "person",
            "email": "john.doe@example.com",
            "personDetails":{
                "firstName": "Jane",
                "lastName" :"Doe"
            }
         }'
```

#### Example response
The response will contain an id (the Client ID). It is required for the next step.

```json
{
    "id": "5eb04fcd0f3e360008035eb1",
    "type": "person",
    "email": "john.doe@example.com",
    "personDetails": {
        "firstName": "John",
        "lastName": "Doe",
    },
    "createdAt": "2023-01-01T17:24:29.146Z",
    "updatedAt": "2023-01-01T17:24:29.146Z"
}
```

### 3. Creating an SDK token

**SDK Tokens** enable clients to securely send personal data from your **mobile app** to ComplyCube.
[To learn more about our SDK Token endpoint](https://docs.complycube.com/api-reference/other-resources/tokens).

> You must generate a new token each time you initialize the ComplyCube Web SDK.

#### Example request

```bash
curl -X POST https://api.complycube.com/v1/tokens \
     -H 'Authorization: <YOUR_API_KEY>' \
     -H 'Content-Type: application/json' \
     -d '{
          	"clientId":"CLIENT_ID",
          	"appId": "com.complycube.SampleApp"
         }'
```

#### Example response

```json
{
    "token": "<CLIENT_TOKEN>"
}
```

### 4. Prepare the SDK stages

Set up the stages you want to include using stage builders.

```swift
let documentStage = DocumentStageBuilder()
            .setAllowedDocumentTypes(types: [ .passport,
                                              .nationalIdentityCard()])
            .useLiveCaptureOnly(enable: false)
            .build()
```

### 5. Initialize an SDK flow

Now you can initialize flow.

```swift
let sdk = ComplyCubeMobileSDK.FlowBuilder()
            .withSDKToken("SDK_TOKEN")
            .withStages([documentStage, selfieStage]) // The order here is how the client will see the screens
            .start(fromVc: self)
```

### 5. Perform checks

Using the results returned in the `onSuccess` callback, you can trigger your **mobile backend** to run the necessary checks on your client. 

*For example, use the result of a selfie and document capture as follows;*
* `result.documentId` to run a [Document Check](https://docs.complycube.com/api-reference/check-types/document-check)
* `result.documentId` and `result.livePhotoId` to run an [Identity Check](https://docs.complycube.com/api-reference/check-types/identity-check)

#### Example request

```curl
curl -X POST https://api.complycube.com/v1/checks \
     -H 'Authorization: <YOUR_API_KEY>' \
     -H 'Content-Type: application/json' \
     -d '{
            "clientId":"CLIENT_ID",
            "type": "document_check",
            "documentId":"DOCUMENT_ID"
         }'
```

### 6. Setup webhooks and retrieve results

> Our checks are asynchronous, and all results and event notifications are done via webhooks.

Follow our [webhook guide](https://docs.complycube.com/documentation/guides/webhooks) for a step-by-step walkthrough.

Your **mobile backend** can retrieve all check results using our API.

## Customization

### Stages

Each stage in the flow can be customized to create the ideal journey for your clients.

##### Welcome stage

This is the first screen of the flow. It displays a welcome message and a summary of the stages you have configured for the client. If you would like to use a custom title and message, you can set them as follows:


``` swift
    let welcomeStage = WelcomeStageBuilder()
     .setTitle(title: "My Company Verification")
     .setMessage(message: "We will now verify your identity so you can start trading.")
     .build()
```

> The welcome stage will always default to show as the first screen. 

##### Consent stage

You can optionally add this stage to enforce explicit consent collection before the client can progress in the flow. The consent screen allows you to set a custom title.

``` swift
    let consentStage = UserConsentStageBuilder()
     .setTitle(title: "Terms of Service")
     .build()
```

##### Document stage

This stage allows clients to select the type of identity document they would like to submit. You can customize these screens to:

* Limit the scope of document types the client can select, e.g., Passport only.
* Set the document issuing countries they are allowed for each document type.
* Add or remove automated capture using smart assistance.
* Show or hide the instruction screens before capture.
* Set a retry limit to allow clients to progress the journey regardless of capture quality.

> If you provide only one document type, the document type selection screen will be skipped. The country selection screen will be skipped if you provide only a single country for a given document type.

You can remove the information screens shown before camera captures by enabling or disabling guidance. You should only consider omitting this if you have clearly informed your customer of the capture steps required.

> :warning: Please note the `retryLimit` you set here will take precedence over the retry limit that has been set globally in the [developer console](https://portal.complycube.com/automations).

``` swift
    let docStage = DocumentStageBuilder()
     .setAllowedDocumentTypes(types: [ .passport,
                                       .drivingLicence(countries: ["GB","US"]), 
                                       .nationalIdentityCard()])
     .build()
```

If you want to set the countries across all document types (apart from passports), you can set the top-level country lists at the flow level.

```swift

```

##### Selfie photo and video stage

You can request a selfie photo ([live photo](https://docs.complycube.com/api-reference/live-photos)) capture or video ([live video](https://docs.complycube.com/api-reference/live-videos)) capture from your customer. 

``` swift
let selfieStage = BiometricStageBuilder()
                    .setType(type: .photo)
                    .build()
```
or

``` swift
let videoStage = BiometricStageBuilder()
                    .setType(type: .video)
                    .build()
```

> :warning: If you attempt to add both, the SDK will throw a `ComplyCubeError` error stating multiple conflicting stages.

##### Proof of address stage

When requesting a proof of address document, you can set the allowed document type and whether the client can upload the document. When `useLiveCaptureOnly` is set to false, the client will be forced to perform a live capture.

```swift
let poaStage = AddressStageBuilder()
                .useLiveCaptureOnly(enable: false)
```

### Appearance

The SDK allows you to set colors to match your existing application or brand. You can customize the colors by setting the relevant values when building your flow. 

```swift
let colorScheme = ComplyCubeColourScheme()
colorScheme.primaryButtonBgColor = .green
```

| Appearence property | Description |
| --- | ----------- |
| ```primaryButtonBgColor``` | Primary action button background color |
| ```primaryButtonPressedBgColor``` | Primary action button pressed background color |
| ```primaryButtonTextColor``` | Primary action button text color |
| ```primaryButtonBorderColor``` | Primary action button border color |
| ```secondaryButtonBgColor``` | Secondary button background color |
| ```secondaryButtonPressedBgColor``` | Primary action button pressed background color |
| ```secondaryButtonTextColor``` | Secondary action button text color |
| ```secondaryButtonBorderColor``` | Secondary action button border color |
| ```documentTypeBgColor``` | Document type selection button color |
| ```documentTypeBorderColor``` | Document type selection button border color |
| ```documentTypeTextColor``` | Document type title text color |
| ```headerTitle``` | Title heading text color |
| ```subheaderTitle``` | Subheading text color |

### Localization

The SDK provides the following language support:

* English - `en` :uk:
* French - `fr` :fr:
* German - `de` :de:
* Italian - `it` :it:
* Spanish - `es` :es:

## Result handling

To handle result callbacks, your view controller must implement the `onError`, `onCancelled`, and `onSuccess` functions of the `ComplyCubeMobileSDKDelegate`. 

``` swift
extension ViewController: ComplyCubeMobileSDKDelegate {
    func onError(_ error: ComplyCubeError) {
        print("An error has occurred")
    }
    
    func onCancelled(_ error: ComplyCubeError) {
        print("The user has cancelled the flow or not accepted the terms")
    }
    
    func onSuccess(_ result: ComplyCubeResult) {
        print("The flow has completed - here are the ID's returned")
    }
}
```

Upon an `onSuccess` callback, you can create [check requests](https://docs.complycube.com/api-reference/checks/create-a-check) using the captured data. The IDs of the uploaded resources are returned in the `result ` parameter.

For example, our default flow, which includes an Identity Document, Selfie (Live Photo), and Proof of Address, would have a `result` parameter with `result.documentId`, `result.livePhotoId`, and `result.proofOfAddressId`.

## Error handling

If the SDK experiences any issues, a `ComplyCubeError` is returned with one of the following error codes:

| Error | Description |
| --- | ----------- |
| ```ComplyCubeResult.Error.NotAuthorised``` | The SDK has attempted a request to an endpoint you are not authorized to use.|
| ```ComplyCubeResult.Error.TokenExpired``` | The token used to initialize the SDK has expired. Create a new SDK token and restart the flow. |
| ```ComplyCubeResult.Error.Unknown``` | An unexpected error has occured. If this keeps occurring, let us know about it. |

## Going live

Check out our handy [integration checklist here](https://docs.complycube.com/documentation/guides/integration-checklist) before you go live.

## Additional info

You can find our full [API reference here](https://docs.complycube.com/api-reference), and our guides and example flows can be found [here](https://docs.complycube.com/documentation/).
