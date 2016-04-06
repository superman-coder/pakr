//
// Created by Huynh Quang Thao on 4/5/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import Typhoon

public class WebServiceAssembly: TyphoonAssembly {

    public dynamic func addressService() -> AnyObject {
        return TyphoonDefinition.withClass(AddressServiceMockImpl.self)
    }

    /*
    * A config definition, referencing properties that will be loaded from a plist.
    */
    public dynamic func config() -> AnyObject {
        return TyphoonDefinition.withConfigName("Configuration.plist")
    }
}
