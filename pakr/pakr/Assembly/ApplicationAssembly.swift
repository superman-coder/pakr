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
    public var dataHandlerAssembly: DataHandlerAssembly!

    /*
     * This is the definition for our AppDelegate. Typhoon will inject the specified properties
     * at application startup.
     */
    public dynamic func appDelegate() -> AnyObject {
        return TyphoonDefinition.withClass(AppDelegate.self) {
            (definition) in
        }
    }
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Controller Assembly
    //-------------------------------------------------------------------------------------------
    
    public dynamic func parkingListController() -> AnyObject {
        
        return TyphoonDefinition.withClass(ParkingListController.self) {
            (definition) in
            definition.injectProperty("addressService", with: self.webServiceAssembly.addressService())
        }
    }
    
    public dynamic func parkingDetailController() -> AnyObject {
        return TyphoonDefinition.withClass(DetailParkingController.self)
    }
    
    
    
    public dynamic func postParkingController() -> AnyObject {
        return TyphoonDefinition.withClass(PostParkingController.self)
    }
    
    
    public dynamic func mapViewController() -> AnyObject {
        return TyphoonDefinition.withClass(MapViewController.self)
    }
}
