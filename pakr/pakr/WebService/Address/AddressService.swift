//
// Created by Huynh Quang Thao on 4/5/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation

protocol AddressService {
    func getNearByParkingLotByLocation(latitude: Double!, longitude: Double, radius: Double, success:([Topic] -> Void), fail: (NSError -> Void))
    
    func getNearByParkingByAddressName(address: String, radius: Double, success:([Topic] -> Void), fail: (NSError -> Void))
    
    func getAllParkingByUser(userId: String, success:([Topic] -> Void), failure:(NSError -> Void))
    
    func postComment(comment: Comment, complete:(comment: Comment?, error: NSError?) -> Void)
    func getAllCommentsByTopic(topicId: String, success:([Comment] -> Void), failure:(NSError -> Void))
    
    func getUserById(userId: String, complete:(success: User?,  error: NSError?) -> Void)
    
    func postBookMark(topic: Topic, userId: String, complete:(bookMark: Bookmark?, error: NSError?) -> Void)
    func getAllBookMarksByUser(userId: String, complete:(bookMarks: [Bookmark]?, error: NSError?))
}

