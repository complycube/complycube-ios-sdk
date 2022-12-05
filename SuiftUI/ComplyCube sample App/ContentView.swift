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
                print("Hello")
                let documentStage = DocumentStageBuilder()
                            .setAllowedDocumentTypes(types: [ .passport,
                                                              .nationalIdentityCard()])
                            .useLiveCaptureOnly(enable: false)
                            .build()
                var viewController = UIApplication.shared.windows.first?.rootViewController?.getAppViewController()
                let sdk = ComplyCubeMobileSDK.FlowBuilder()
                            .withSDKToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjoiWm1Rd01tTXhNekl3WldWbU9XSTFOamszWVdOaU1XTXdZV0ZsTVdVek1UVm1ORFF3TldJeE5EVXhPV0U1TkRBM1pEWXdZVGcxT1dRd016RmlZakUwTVRkak56WTBabVUxTVRaa05tRXpaVFF3TUdFM09EWTBZalEyWmpJMk4yWm1aR0k0TW1aa04yWXlOVEk0WW1SbE1XTmhOMkppWmpZeE1tSXdZemhtWTJGaVlqQTNPR1JpTXpGaFpEQmlOREF6TVRNNU16WmxNREF3T0RVM1pXUTVaamxtWkRNM056ZGxaRFkyTUdKalpqSTVaR1kzTlRNd09UY3pOVGRrWm1OaVlqaGxaRFUyWWpSaFl6YzVaalk1TW1VM1ltSTRZelZsTlRBMk5qRXpaalZsTjJWaU1qTTNaVEl3WldRelpXUTVNalpsTldGaFpXWmhZamt5T1RJek5RPT0iLCJ1cmxzIjp7ImFwaSI6Imh0dHBzOi8vYXBpLmNvbXBseWN1YmUuY29tIiwic3luYyI6IndzczovL3hkcy5jb21wbHljdWJlLmNvbSIsImNyb3NzRGV2aWNlIjoiaHR0cHM6Ly94ZC5jb21wbHljdWJlLmNvbSJ9LCJvcHRpb25zIjp7ImhpZGVDb21wbHlDdWJlTG9nbyI6ZmFsc2UsImVuYWJsZUN1c3RvbUxvZ28iOnRydWUsImVuYWJsZVRleHRCcmFuZCI6dHJ1ZSwiZW5hYmxlQ3VzdG9tQ2FsbGJhY2tzIjp0cnVlfSwiaWF0IjoxNjY3NDgzODUzLCJleHAiOjE2Njc0ODc0NTN9.8qnAcJ_t3-_6-JKIzj3q56TE8lJuQOReNBTAYfAvkss")
                            .withClientId("6363c8cc808c610008278c30")
                            .withStages([documentStage])
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
