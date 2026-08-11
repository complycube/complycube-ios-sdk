//
//  ContentView.swift
//  ComplyCube sample App
//

import SwiftUI
import ComplyCubeMobileSDK

struct ContentView: View {
    @StateObject private var verificationFlow = VerificationFlowController()

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.text.rectangle")
                .imageScale(.large)

            Button("Start verification") {
                verificationFlow.start()
            }
            .buttonStyle(.borderedProminent)

            Text(verificationFlow.statusMessage)
                .font(.footnote)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
    }
}

private final class VerificationFlowController: ObservableObject, ComplyCubeMobileSDKDelegate {
    @Published private(set) var statusMessage = "Ready to start"

    func start() {
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

        statusMessage = "Verification is running"

        ComplyCubeMobileSDK.FlowBuilder()
            .withSDKToken("SDK_TOKEN")
            .withClientId("CLIENT_ID")
            .withStages([documentStage, selfieStage, proofOfAddressStage])
            .withCallbackHandler(self)
            .start()
    }

    func onSuccess(_ result: ComplyCubeIDResult) {
        updateStatus("Verification completed: \(result.itemList)")
    }

    func onError(_ errors: [ComplyCubeError]) {
        updateStatus("Verification failed: \(errors)")
    }

    func onCancelled(_ error: ComplyCubeError) {
        updateStatus("Verification cancelled: \(error)")
    }

    private func updateStatus(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.statusMessage = message
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
