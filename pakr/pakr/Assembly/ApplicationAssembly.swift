//
//  ApplicationAssembly.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/5/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit
import Typhoon

public class ApplicationAssembly: TyphoonAssembly {

    /*
     * These are modules - assemblies collaborate to provie components to this one.  At runtime we
     * can instantiate Typhoon with any assembly tha satisfies the module interface.
     */
    public var webServiceAssembly: WebServiceAssembly!

    /*
     * This is the definition for our AppDelegate. Typhoon will inject the specified properties
     * at application startup.
     */
    public dynamic func appDelegate() -> AnyObject {
        return TyphoonDefinition.withClass(AppDelegate.self) {
            (definition) in
        }
    }
    
    public dynamic func parkingListController() -> AnyObject {
        
        return TyphoonDefinition.withClass(ListParkingController.self) {
            (definition) in
            definition.injectProperty(#selector(ListParkingController.addressService), with: self.webServiceAssembly.addressService())
        }
    }
}
