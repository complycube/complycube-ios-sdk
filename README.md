# ComplyCube iOS SDK Sample Application
iOS Sample App using the ComplyCube SDK Sample Application

## Table of contents

* [Overview](#overview)
* [Installation](#installation)
* [Getting started](#getting-started)
* [Handling callbacks](#handling-callbacks)
* [Customising Flow](#customising-flow)
* [Handling Errors](#handling-errors)

## Overview
The ComplyCube iOS SDK provides a set of easy to integrate screens to complete a custom identity verification flow. The SDK provides you with the abiliity to;

* Customise your onboarding flow with highly configurable stages, for a seamless user experience
* Smart screen components to optimise image quality and clarity
* UX optimised screens to guide your clients through the capture process
* Immediate and secure upload directly into your ComplyCube account

## Installation
### Pre-requisites
* Swift 5
* iOS 11+
* Xcode 13+

### CocoaPods
Before using the ComplyCube SDK, install the cocoapods Artifactory plugin by running the following command in your terminal:

```bash
gem install cocoapods-art
```

In order to add the library, copy the `.netrc` file to your home directory.
and add this to your `Podfile`.
```ruby
plugin 'cocoapods-art', :sources => [
  'complycube-mobilesdk-cocoapods-local',
  'trunk'
]

...

target 'SampleApp' do
    ...
	pod 'ComplyCubeMobileSDK'
    ...
end

```

### Application Permissions
As the SDK uses the device camera and mic for capture you will need to add the following keys to your applications plist `Info.plist` file.

* `NSCameraUsageDescription`

```json
<key>NSCameraUsageDescription</key>
<string>Used to capture facials biometrics and documents</string>
```

* `NSMicrophoneUsageDescription`

```json
<key>NSMicrophoneUsageDescription</key>
<string>Used to capture viode biometrics</string>
```

## Getting Started
### 1. Create a client
Create a client through your back end server using the [create client api.](https://docs.complycube.com/api-reference/clients/create-a-client)

``` bash
curl -X POST https://api.complycube.com/v1/clients \
     -H 'Authorization: <YOUR_API_KEY>' \
     -H 'Content-Type: application/json' \
     -d '{
          	"type": "person",
            "email": "sam.smith@example.com",
            "personDetails":{
                "firstName": "sam",
                "lastName" :"smith",
                "dob": "1990-01-01"
		    }
        }'
```
### 2. Get a token
Get a token using your server, to intialize the SDK so all the data capture is associated to that specific client.

``` bash
curl -X POST https://api.complycube.com/v1/tokens \
     -H 'Authorization: <YOUR_API_KEY>' \
     -H 'Content-Type: application/json' \
     -d '{
          	"clientId":"CLIENT_ID",
          	"referrer": "https://www.example.com/*"
        }'
```
### 3. Prepare the SDK's stages
Before you start the SDK you need to setup stages you want to include using stage builders.

```swift
let documentStage = DocumentStageBuilder()
            .setAllowedDocumentTypes(types: [ .passport,
                                              .nationalIdentityCard()])
            .useLiveCaptureOnly(enable: false)
            .build()
```

### 4. Start the SDK
Start the SDK using the flow builder, passing in the stages you want to include, the token and the userID

```swift
let sdk = ComplyCubeMobileSDK.FlowBuilder()
            .withSDKToken("userTokenGoesHere")
            .withClientId("userIDGoesHere")
            .withStages([documentStage, selfieStage])
            .start(fromVc: self)
```
## Handling Callbacks
To handle callacks your view controller must implement the onError, onCancelled and onSuccess functions of the ComplyCubeMobileSDKDelegate. 

``` swift
extension ViewController: ComplyCubeMobileSDKDelegate {
    func onError(_ error: ComplyCubeError) {
        print("An error has occured")
    }
    
    func onCancelled(_ error: ComplyCubeError) {
        print("The user has cancelled the flow or not accepted terms")
    }
    
    func onSuccess() {
        print("The flow has completed here are the ID's returned")
    }
}
```

## Customising Flow

### Welcome Stage

This is the first screen of the flow, it shows a welcome message and a summary of the stages you have configured for the client. If you would like to use a non default Title and Message you can set them as follows.

``` swift
    let welcomeStage = WelcomeStageBuilder()
    .setTitle(title: "My Company Verification")
    .setMessage(message: "We will now verify your identity so you can start trading.")
    .build()
```

If you choose to include this stage, it will always appear first regardless of where it appears in your screens array.

### User Consent Stage

You can include this screen to collect the users consent for the verificaiton process, with links to ComplyCube's privacy policy and terms of services.

``` swift
    let consentStage = UserConsentStageBuilder()
    .setTitle(title: "Terms of Service")
    .build()
```
### Document Stage

The document stage is mandatory, and can be configured for different document types and countries. These combinations must match the [supported combinations](https://docs.complycube.com/documentation/checks/document-check/document-types-per-country) or an error will be thrown.

Each document type has a countries property to limit the list of countries that are accepted. 

``` swift
    let docStage = DocumentStageBuilder()
            .setAllowedDocumentTypes(types: [ 	.passport,
	    					.drivingLicence(countries: ["GB","US"]), 
	    					.nationalIdentityCard()])
            .build()
```


### Happy coding !