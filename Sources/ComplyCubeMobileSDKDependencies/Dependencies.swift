// This target exists only to carry the ComplyCube SDK's runtime dependencies into
// the SPM dependency graph. The binary XCFramework references these modules; because
// a `.binaryTarget` cannot declare dependencies, this source target declares them
// instead and is vended alongside the binary in the `ComplyCubeMobileSDK` product.
//
// The imports below force each dependency module to be linked into any app that links
// the product, so the binary's external symbol references resolve. There is no public
// API here — consumers only `import ComplyCubeMobileSDK`.

import AppAuth
import FingerprintPro
import GooglePlaces
import JWTDecode
import Lottie
import Segment
import Sentry

enum ComplyCubeMobileSDKDependencies {}
