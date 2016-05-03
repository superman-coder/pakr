//
// Created by Huynh Quang Thao on 4/5/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation

protocol AddressService {
    
    func postTopic(topic:Topic, complete:(Topic?,NSError?) -> Void)
    
    func getNearByParkingLotByLocation(latitude: Double!, longitude: Double, radius: Double, success:([Topic] -> Void), fail: (NSError -> Void))
    
    func getNearByParkingByAddressName(address: String, radius: Double, success:([Topic] -> Void), fail: (NSError -> Void))
    
    func getAllParkingByUser(userId: String, success:([Topic] -> Void), failure:(NSError -> Void))
    
    func postComment(comment: Comment, complete:(comment: Comment?, error: NSError?) -> Void)
    func getAllCommentsByTopic(topicId: String, success:([Comment] -> Void), failure:(NSError -> Void))
    
    func getUserById(userId: String, complete:(success: User?,  error: NSError?) -> Void)
    
    func postBookMark(bookMark: Bookmark, complete:(bookMark: Bookmark?, error: NSError?) -> Void)
    func getAllBookMarksByUser(userId: String, complete:(bookMarks: [Bookmark]?, error: NSError?) -> Void)
    
    func checkIsBookMarkTopicByUser(userId: String, topicId: String, complete:(isBookMark: Bool) -> Void)
}

