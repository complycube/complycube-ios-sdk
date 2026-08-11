//
//  ViewController.swift
//  SampleApp
//

import UIKit
import ComplyCubeMobileSDK

class ViewController: UIViewController {

    @IBAction func onboardClient(_ sender: Any) {
        let documentStage = DocumentStageBuilder()
            .setAllowedDocumentTypes(types: [
                .passport,
                .nationalIdentityCard(["GB", "FR"])
            ])
            .setShowGuidance(enable: true)
            .useLiveCaptureOnly(enable: false)
            .build()

        let selfieStage = BiometricStageBuilder()
            .setType(type: .video)
            .setEnableMLAssistant(enable: true)
            .build()

        let proofOfAddressStage = ProofOfAddressStageBuilder()
            .setShowGuidance(enable: true)
            .useLiveCaptureOnly(enable: false)
            .build()

        ComplyCubeMobileSDK.FlowBuilder()
            .withSDKToken("SDK_TOKEN")
            .withClientId("CLIENT_ID")
            .withStages([documentStage, selfieStage, proofOfAddressStage])
            .withCallbackHandler(self)
            .start(from: self)
    }
}

extension ViewController: ComplyCubeMobileSDKDelegate {
    func onSuccess(_ result: ComplyCubeIDResult) {
        print("Verification completed: \(result.itemList)")
    }

    func onError(_ errors: [ComplyCubeError]) {
        print("Verification failed: \(errors)")
    }

    func onCancelled(_ error: ComplyCubeError) {
        print("Verification cancelled: \(error)")
    }
}
