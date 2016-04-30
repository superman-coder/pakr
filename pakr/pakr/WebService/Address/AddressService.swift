//
// Created by Huynh Quang Thao on 4/5/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation

protocol AddressService {
    func getNearByParkingLotByLocation(latitude: Double!, longitude: Double, radius: Double, success:([Topic] -> Void), fail: (NSError -> Void))
    
    func getNearByParkingByAddressName(address: String, radius: Double, success:([Topic] -> Void), fail: (NSError -> Void))
    
    func getAllParkingByUser(userId: String, success:([Topic] -> Void), failure:(NSError -> Void))
    
    func postComment(comment: Comment, complete:(success: Bool, error: NSError?) -> Void)
    func getAllCommentsByTopic(topicId: String, success:([Comment] -> Void), failure:(NSError -> Void))
}

