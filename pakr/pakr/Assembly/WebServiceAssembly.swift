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

    public dynamic func authService() -> AnyObject {
        return TyphoonDefinition.withClass(AuthServiceMockImpl.self)
    }
}
