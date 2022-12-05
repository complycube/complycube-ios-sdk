//
//  ContentView.swift
//  ComplyCube sample App
//
//  Created by Kenshin Vag on 1/12/2022.
//

import SwiftUI
import UIKit
import ComplyCubeMobileSDK

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Button("Click on me"){
               var viewController = UIApplication.shared.windows.first?.rootViewController?.getAppViewController()
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
                    .start(fromVc: viewController!)
                
            }.padding()
                .buttonStyle(.borderedProminent)
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

extension UIViewController {
    public func getAppViewController() -> UIViewController {
        var top: UIViewController? = self
        // look for the viewController that's shown right now
        while top!.presentedViewController != nil {
            top = top!.presentedViewController!
        }
        return top!
    }
}
