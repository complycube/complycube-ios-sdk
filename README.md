# ComplyCube iOS SDK Sample Application
iOS Sample App using the ComplyCube SDK Sample Application

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
1. Before using the ComplyCube SDK, install the cocoapods Artifactory plugin by running the following command in your terminal:

```bash
gem install cocoapods-art
```

2. In order to add the library, copy your respository credentials into a `.netrc` file to your home directory and setup the repository:

```bash
pod repo-art add cc-cocoapods-local "https://complycuberepo.jfrog.io/artifactory/api/pods/cc-cocoapods-local"
```


3. add plugin repos and install the pod using your `Podfile`.
```ruby
plugin 'cocoapods-art', :sources => [
  'cc-cocoapods-release-local'
]
...

target 'SampleApp' do
    ...
	pod 'ComplyCube'
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
            "email": "jane.doe@example.com",
            "personDetails":{
                "firstName": "Jane",
                "lastName" :"Doe",
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
          	"appId": "com.complycube.SampleApp"
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
            .withSDKToken("SDK_TOKEN")
            .withStages([documentStage, selfieStage]) // The order here is how the client will see the screens
            .start(fromVc: self)
```

## 5. Execute checks against your client
Using the results returned in the onSuccess callback, you can trigger your backend to run the necessary checks on your client. 

*For example, use the result of a selfie and document capture as follows;*
* result.documentId to run a document check
* result.documentId and result.livePhotoId to run an identity check

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

## Handling results
To handle result callbacks your view controller must implement the onError, onCancelled and onSuccess functions of the ComplyCubeMobileSDKDelegate. 

``` swift
extension ViewController: ComplyCubeMobileSDKDelegate {
    func onError(_ error: ComplyCubeError) {
        print("An error has occured")
    }
    
    func onCancelled(_ error: ComplyCubeError) {
        print("The user has cancelled the flow or not accepted terms")
    }
    
    func onSuccess(_ result: ComplyCubeResult) {
        print("The flow has completed here are the ID's returned")
    }
}
```

Typically you onSucess method will make [check requests](https://docs.complycube.com/api-reference/checks/create-a-check) to validates the customers captured data. The ID's of the uploaded data is returned in the ```result``` parameter

For example a default flow (Identity Document, Selfie and Proof of Address) would have a result parameter with ```result.documentId, result.livePhotoId, result.proofOfAddressId```

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

You can optionally include the consent stage to enforce explicit consent collection and present links to ComplyCube's privacy policy and terms of services. The client must accept before they can progress in the flow. The consent screen allows you to set a custom title as follows.

``` swift
    let consentStage = UserConsentStageBuilder()
    .setTitle(title: "Terms of Service")
    .build()
```
### Document Stage

The document stage allows a user to select the type of identity document they would like to submit.
You can customise these screens to help your customers make only valid choices.
* Limit the document types the customer can select e.g. Passports only.
* Set the document issuing countries they can be selected for each document type. 
* Add/remove automated capture using smart assistance.
* Show/hide the instruction screens before capture.
* Set a retry limit, to allow customers to progress the journey regardless of capture quality.

The document stage is mandatory, and can be configured for different document types and countries. These combinations must match the [supported combinations](https://docs.complycube.com/documentation/checks/document-check/document-types-per-country) or an error will be thrown.

**_NOTE:_** If you provide only one document type, the document type selection screen will be skipped. If you provide only a single country for a given document type the country selection screen will be skipped.

By enabling/disabling guidance you can remove the information screen shown before camera capture. This should only be ommitted if you have clearly informed your customer of the capture steps required.

:warning: Please note the retryLimit you set here will take precedence over the retry limit that has been set globally in the [developer console](https://portal.complycube.com/automations/documentChecks).

``` swift
    let docStage = DocumentStageBuilder()
            .setAllowedDocumentTypes(types: [ 	.passport,
	    					.drivingLicence(countries: ["GB","US"]), 
	    					.nationalIdentityCard()])
            .build()
```

##### Selfie Photo & Video Stage customisation
You can request a selfie photo capture or selfie video capture from your customer. 

``` swift
let selfieStage = BiometricStageBuilder()
                    .setType(type: .photo) // Setup Photo selfie
                    .build()
// or
let selfieVideo = BiometricStageBuilder()
                    .setType(type: .video) // Setup Video selfie
                    .build()
```

:warning: If you attempt to add both the SDK will throw a ComplyCubeError error stating Mulitple biometric stages found.

##### Proof of Address customisation
When requesting a proof of address you can set the allowed document type but also set if the user is allowed to upload from their device.

```swift
let poaStage = AddressStageBuilder()
                .useLiveCaptureOnly(enable: false)
```
### Customising appearence

The SDK also allows colour customisations to match your existing application. You can customise the SDK colours by setting colour values when building your flow. 

```swift
let colorScheme = ComplyCubeColourScheme()
colorScheme.primaryButtonBgColor = .green
```

| Appearence property | Description |
| --- | ----------- |
| ```primaryButtonBgColor``` | Primary action button background colour |
| ```primaryButtonPressedBgColor``` | Primary action button pressed background colour |
| ```primaryButtonTextColor``` | Primary action button text colour |
| ```primaryButtonBorderColor``` | Primary action button border colour |
| ```secondaryButtonBgColor``` | Secondary button background colour |
| ```secondaryButtonPressedBgColor``` | Primary action button pressed background colour |
| ```secondaryButtonTextColor``` | Secondary action button text colour |
| ```secondaryButtonBorderColor``` | Secondary action button border colour |
| ```documentTypeBgColor``` | Document type selection button colour |
| ```documentTypeBorderColor``` | Document type selection button border colour|
| ```documentTypeTextColor``` | Document type title text colour|
| ```headerTitle``` | Title heading text colour |
| ```subheaderTitle``` | Subheading text colour e.g. |

### Error handling

If the SDK experiences any issues that cannot be recovered from within the flow. A ComplyCubeError is returned with one of the following error codes.

| Error Code | Description |
| --- | ----------- |
| ```.noToken``` | Attempted to launch the SDK without setting the Token |
| ```.expiredToken``` | The token used to mount the SDK has expired please repeat the token request process and restart the flow. |
| ```.notAuthorised``` | The SDK has attempted a request to an endpoint you are not authorised to use, please check with your account manager.|
| ```.biometricStagesCount``` | Multiple biometric stages found in config |
| ```.proofOfAddressStagesCount``` | Multiple proof of address stages found in config |
| ```.userConsentsCount``` | Multiple user consent stages found in config |
| ```.jailbroken``` | User device has been flagged as jailbroken |
| ```.uploadsRequireGuidance``` | If useLiveCaptureOnly is false guidance must be enabled |
| ```.noDocumentTypes``` | A stage using documents has been configured without setting the allowed types |
| ```.unknown``` | Something unexpected has happened, let us know how this happened. |

### Localisation

The SDK provides the following language support

* English - en :uk:
* French - fr :fr:
* German - de :de:
* Italian - it :it:
* Spanish - es :es:

### Going Live

ComplyCube uses webhooks to notify your application when an event happens in your account. Before you go live ensure you have setup the necessary webhooks to process your check results. [Check out the Webhooks guide here for more information.](https://docs.complycube.com/documentation/guides/webhooks)

Check out our handy [integration checklist here](https://docs.complycube.com/documentation/guides/integration-checklist) before you go-live.

### Additional Info

You can find our full [API reference here](https://docs.complycube.com/api-reference) and our guides and example flows can be found [here](https://docs.complycube.com/documentation/).
