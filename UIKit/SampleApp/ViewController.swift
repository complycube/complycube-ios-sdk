//
//  ViewController.swift
//  SampleApp
//

import UIKit
import ComplyCubeMobileSDK


class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onboardClient(_ sender: Any) {
        let documentStage = DocumentStageBuilder()
            .setAllowedDocumentTypes(types: [ .passport,
                                              .nationalIdentityCard(["GB", "FR"])]) // Customize the document nationality
            .useLiveCaptureOnly(enable: false) // disable live capture only
            .build()
        
        let selfieStage = BiometricStageBuilder()
            .setType(type: BiometricType.video) // Setup Video selfie
            .setEnableMLAssistant(enable: true) // Setup the ML assistant for the selfie stage
            .build()
        
        // Build colour scheme
        let colorScheme = ComplyCubeColourScheme()
        colorScheme.primaryButtonBgColor = .green
        colorScheme.headerTitle = .red
        let sdk = ComplyCubeMobileSDK.FlowBuilder()
            .withSDKToken("userTokenGoesHere")
            .withClientId("userIDGoesHere")
            .withStages([documentStage, selfieStage])
            .withColorScheme(colorScheme)
            .start(fromVc: self)
    }
}
