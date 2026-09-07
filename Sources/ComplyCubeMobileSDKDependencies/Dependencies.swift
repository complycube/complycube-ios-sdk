// This target exists only to carry the ComplyCube SDK's runtime dependencies into
// the SPM dependency graph. The SDK ships as a static binary XCFramework, so every
// dependency symbol in it is left undefined for the consumer's link step; because a
// `.binaryTarget` can declare no dependencies of its own, this target declares them
// instead and is vended alongside the binary in the `ComplyCubeMobileSDK` product.
//
// There is no public API to call here — consumers only `import ComplyCubeMobileSDK`.

import AppAuth
import FingerprintPro
import GooglePlaces
import JWTDecode
import Lottie
import Segment
import Sentry

public enum ComplyCubeMobileSDKDependencies {

    /// Never read. It exists so this file emits a real class reference to every
    /// dependency that ships as a **static** library.
    ///
    /// An `import` alone is not enough. A static library's members are loaded lazily,
    /// only to satisfy symbols already undefined when the linker reaches that library —
    /// and the SDK's own archive is reached afterwards, so the symbols it needs can be
    /// discovered too late. This target compiles to a plain object file, which is always
    /// loaded in full, so a reference made here is undefined from the very start of the
    /// link and the member gets pulled in regardless of order. It is the same trick
    /// GooglePlaces' own SwiftPM package uses via its `GMSEmpty.m` shim target.
    ///
    /// This exists because a consumer app failed to link with
    /// `Undefined symbols: _OBJC_CLASS_$_SentrySDK, referenced from AddressCaptureVC.o`
    /// even though `-framework Sentry` was on the link line and Sentry's static
    /// xcframework does define that class. Link order is the only explanation left, but
    /// note it has NOT yet been confirmed end to end that this is the fix — the
    /// verifying build could not be completed. If the smoke test still fails on an
    /// undefined Sentry symbol, look here first.
    ///
    /// Only statically-vended dependencies need an entry. Today that is Sentry, whose
    /// SwiftPM `Sentry` product is the Sentry-Static xcframework. The rest are dynamic
    /// frameworks (FingerprintPro), plain object files (AppAuth, Segment, Lottie,
    /// JWTDecode), or already force-linked by their own package's shim target
    /// (GooglePlaces). Add a line here if one of them ever changes shape — the symptom
    /// is an undefined-symbol error naming that dependency.
    public static let staticallyLinkedDependencies: [AnyClass] = [
        SentrySDK.self
    ]
}
