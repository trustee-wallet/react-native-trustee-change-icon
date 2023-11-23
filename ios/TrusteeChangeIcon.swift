//
//  Created by thanh vinh on 24/04/2023.
//

import Foundation
import UIKit
import React

@objc(TrusteeChangeIcon)
class TrusteeChangeIcon: NSObject {
    
    @objc static func requiresMainQueueSetup() -> Bool { return false }
    
    @objc public func getIcon(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
        DispatchQueue.main.async {
            let currentIcon = UIApplication.shared.alternateIconName
            if let currentIcon = currentIcon {
                resolve(currentIcon)
            } else {
                resolve("default")
            }
        }
    }

    @objc public func changeIconWithAlert(_ iconName: String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        DispatchQueue.main.async {
            var error: Error?
          
            if UIApplication.shared.supportsAlternateIcons == false {
                error = NSError(domain: "Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "NOT_SUPPORTED"])
                reject("Error", "NOT_SUPPORTED", error)
                return
            }
          
            if let currentIcon = UIApplication.shared.alternateIconName, currentIcon == iconName {
                error = NSError(domain: "Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "ICON_ALREADY_USED"])
                reject("Error", "ICON_ALREADY_USED", error)
                return
            }
            
            UIApplication.shared.setAlternateIconName(iconName)
        }
    }
  
    @objc public func changeIcon(_ iconName: String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        DispatchQueue.main.async {
            var error: Error?
          
            if UIApplication.shared.supportsAlternateIcons == false {
                error = NSError(domain: "Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "NOT_SUPPORTED"])
                reject("Error", "NOT_SUPPORTED", error)
                return
            }
          
            if let currentIcon = UIApplication.shared.alternateIconName, currentIcon == iconName {
                error = NSError(domain: "Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "ICON_ALREADY_USED"])
                reject("Error", "ICON_ALREADY_USED", error)
                return
            }
            
            if UIApplication.shared.responds(to: #selector(getter: UIApplication.supportsAlternateIcons)) && UIApplication.shared.supportsAlternateIcons {
                typealias setAlternateIconName = @convention(c) (NSObject, Selector, NSString, @escaping (NSError) -> ()) -> ()
                let selectorString = "_setAlternateIconName:completionHandler:"
                let selector = NSSelectorFromString(selectorString)
                let imp = UIApplication.shared.method(for: selector)
                let method = unsafeBitCast(imp, to: setAlternateIconName.self)
                method(UIApplication.shared, selector, iconName as NSString, { _ in })
            }
        }
    }
    
  
    @objc
    static func moduleName() -> String {
        return "TrusteeChangeIcon"
    }
    
    @objc
    func constantsToExport() -> [AnyHashable: Any]! {
        return [:]
    }
}
