//
//  ComplyCube.swift
//  ComplyCubeC
//
//  Created by Kenshin Vag on 5/12/2022.
//

import Foundation
import ComplyCubeMobileSDK

@objc
class ComplyCubeSDK: NSObject{
    var sdk: ComplyCubeMobileSDK
    @objc override init(){
        self.sdk = ComplyCubeMobileSDK()
    }
}
