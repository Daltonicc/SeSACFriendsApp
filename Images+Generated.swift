// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Auth {
    internal static let manImage = ImageAsset(name: "ManImage")
    internal static let womanImage = ImageAsset(name: "WomanImage")
  }
  internal enum Home {
    internal static let basicSeSACImage = ImageAsset(name: "BasicSeSACImage")
    internal static let basicStatusFriendsImage = ImageAsset(name: "BasicStatusFriendsImage")
    internal static let goldSeSACImage = ImageAsset(name: "GoldSeSACImage")
    internal static let gpsImage = ImageAsset(name: "GpsImage")
    internal static let markerImage = ImageAsset(name: "MarkerImage")
    internal static let matchedFriendsImage = ImageAsset(name: "MatchedFriendsImage")
    internal static let mintSeSACImage = ImageAsset(name: "MintSeSACImage")
    internal static let purpleSeSACImage = ImageAsset(name: "PurpleSeSACImage")
    internal static let searchingFriendsImage = ImageAsset(name: "SearchingFriendsImage")
    internal static let strongSeSACImage = ImageAsset(name: "StrongSeSACImage")
  }
  internal enum MainTab {
    internal static let friends = ImageAsset(name: "Friends")
    internal static let home = ImageAsset(name: "Home")
    internal static let profile = ImageAsset(name: "Profile")
    internal static let shop = ImageAsset(name: "Shop")
  }
  internal enum Onboarding {
    internal static let onboardingImage1 = ImageAsset(name: "OnboardingImage1")
    internal static let onboardingImage2 = ImageAsset(name: "OnboardingImage2")
    internal static let onboardingImage3 = ImageAsset(name: "OnboardingImage3")
  }
  internal enum ProfileCategory {
    internal static let alert = ImageAsset(name: "Alert")
    internal static let faq = ImageAsset(name: "FAQ")
    internal static let info = ImageAsset(name: "Info")
    internal static let permit = ImageAsset(name: "Permit")
    internal static let qa = ImageAsset(name: "Q&A")
    internal static let ssacProfile = ImageAsset(name: "SSACProfile")
  }
  internal enum ProfileDetail {
    internal static let seSACBackground = ImageAsset(name: "SeSACBackground")
    internal static let seSACImage = ImageAsset(name: "SeSACImage")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
