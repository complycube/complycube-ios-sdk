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
            if #available(iOS 15.0, *) {
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
                    
                    let poaStage = AddressStageBuilder()
                        .useLiveCaptureOnly(enable: false)
                    // Build colour scheme
                    let colorScheme = ComplyCubeColourScheme()
                    colorScheme.primaryButtonBgColor = .green
                    colorScheme.headerTitle = .red
                    do {
                        try ComplyCubeMobileSDK.FlowBuilder()
                            .withSDKToken("SDK_TOKEN")
                            .withStages([documentStage, selfieStage])
                            .withColorScheme(colorScheme)
                            .start(fromVc: viewController!)
                    } catch {
                        print(error)
                    }
                    
                }.padding()
                    .buttonStyle(.borderedProminent)
            } else {
                // Fallback on earlier versions
            }
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

extension UIViewController: ComplyCubeMobileSDKDelegate {
    public func onError(_ errors: [ComplyCubeError]) {
        print("An error has occured")
    }
    
    public func onSuccess(_ result: ComplyCubeResult) {
        print("The flow has completed here are the ID's returned")
    }
    
    public func onCancelled(_ error: ComplyCubeError) {
        print("The user has cancelled the flow or not accepted terms")
    }
}
