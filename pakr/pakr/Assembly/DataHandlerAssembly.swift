//
// Created by Huynh Quang Thao on 4/7/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import Typhoon

public class DataHandlerAssembly: TyphoonAssembly {

    public dynamic func userHandler() -> AnyObject {
        return TyphoonDefinition.withClass(UserHandlerMockImpl.self)
    }
}
