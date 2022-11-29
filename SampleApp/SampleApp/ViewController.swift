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
                                              .nationalIdentityCard()])
            .useLiveCaptureOnly(enable: false)
            .build()
        
        let selfieStage = BiometricStageBuilder()
            .setType(type: BiometricType.video)
            .build()
        let sdk = ComplyCubeMobileSDK.FlowBuilder()
            .withSDKToken("userTokenGoesHere")
            .withClientId("userIDGoesHere")
            .withStages([documentStage, selfieStage])
            .start(fromVc: self)
    }
}
