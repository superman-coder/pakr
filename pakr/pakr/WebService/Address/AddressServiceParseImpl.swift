//
// Created by Huynh Quang Thao on 4/7/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import Parse

let DemoMode = true
public class AddressServiceParseImpl: NSObject, AddressService {
    func getNearByParkingLotByLocation(latitude: Double!, longitude: Double, radius: Double, success: ([Topic] -> Void), fail: (NSError -> Void)) {
        let query = PFQuery(className: Constants.Table.Topic)
        query.includeKey(Topic.PKParking)
        let innerQuery = PFQuery(className: Constants.Table.Parking)
        innerQuery.whereKey(Parking.PKCoordinate, nearGeoPoint: PFGeoPoint(latitude: latitude, longitude: longitude), withinKilometers: radius / 1000)
        
        query.whereKey(Topic.PKParking, matchesQuery: innerQuery)
        
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            print("Near by count: \(objects?.count)")
            print("Error: \(error)")
            
            if let error = error {
                fail(error)
            } else if let objs = objects {
                var topics = [Topic]()
                for pfobj in objs {
                    let topic = Topic(pfObject: pfobj)
                    topics.append(topic)
                }
                success(topics)
            }
        }
    }
    
    func getNearByParkingByAddressName(address: String, radius: Double, success: ([Topic] -> Void), fail: (NSError -> Void)) {
        if (DemoMode) {
            let lowerAddress = address.lowercaseString
            if (lowerAddress.containsString("ho con rua")
                || lowerAddress.containsString("con rua")
                || lowerAddress.containsString("ho rua")
                || lowerAddress.containsString("con rùa")
                || lowerAddress.containsString("hồ con rùa")
                || lowerAddress.containsString("hồ rùa")) {
               let coord = Coordinate(latitude: 10.782661, longitude: 106.695915)
                self.getNearByParkingLotByLocation(coord.latitude,
                                                   longitude: coord.longitude,
                                                   radius: radius,
                                                   success: { topic in
                                                    success(topic)
                    }, fail: { error in
                        fail(error)
                })
                return
            }
        }
        
        GMServices.requestAddressSearchWithAddress(address) { (successGMS, locationGMS) in
            var coord:Coordinate? = nil
            
            if (successGMS) {
                if locationGMS?.count > 0 {
                    let firstPlace = locationGMS![0]
                    print("Search nearby: \(firstPlace.geometry.latitude),\(firstPlace.geometry.longitude)")
                    coord = Coordinate(latitude: firstPlace.geometry.latitude, longitude: firstPlace.geometry.longitude)
                }
            }
            
            if let coord = coord {
                self.getNearByParkingLotByLocation(coord.latitude,
                                                   longitude: coord.longitude,
                                                   radius: radius,
                                                   success: { topic in
                    success(topic)
                    }, fail: { error in
                        fail(error)
                })
            } else {
                fail(NSError(domain: "", code: 0, userInfo: nil))
            }
        }
    }
    
    func postTopic(topic:Topic, complete:(Topic?,NSError?) -> Void) {
        topic.toPFObject().saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                let query = PFQuery(className: Constants.Table.Topic)
                query.includeKey(Topic.PKParking)
                query.orderByDescending("createdAt")
                query.limit = 1
                query.findObjectsInBackgroundWithBlock({ (objects, error) in
                    if error != nil {
                        complete(nil, error)
                    }else{
                       let topic = Topic(pfObject: objects![0])
                        complete(topic, nil)
                    }
                })
            } else {
                complete(nil, error)
            }
        }
    }

    
    func getAllParkingByUser(userId: String, success:([Topic] -> Void), failure:(NSError -> Void)) {
        let query = PFQuery(className: Constants.Table.Topic)
        query.includeKey(Topic.PKParking)
        
        let user = PFObject(withoutDataWithClassName: Constants.Table.User, objectId: userId)
        query.whereKey(Topic.PKPostUser, equalTo: user)
        
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            print("User count: \(objects?.count)")
            print("Error: \(error)")
            
            if let error = error {
                failure(error)
            } else if let objs = objects {
                var topics = [Topic]()
                for pfobj in objs {
                    let topic = Topic(pfObject: pfobj)
                    topics.append(topic)
                }
                success(topics)
            }
        }

    }
// MARK: API comment
    func postComment(comment: Comment, complete:(comment: Comment?, error: NSError?) -> Void){
        comment.toPFObject().saveInBackgroundWithBlock { (success: Bool, error: NSError?) in
            if success {
                let query = PFQuery(className: Constants.Table.Comment)
                query.orderByDescending("createdAt")
                query.limit = 1
                query.findObjectsInBackgroundWithBlock({ (comments, error) in
                    if let error = error {
                        complete(comment: nil, error: error)
                    } else if let comments = comments {
                            let comment = Comment(pfObject: comments.first!)
                        complete(comment: comment, error: nil)
                    }
                })
            }else{
                complete(comment: nil, error: error)
            }
        }
        
    }
    func getAllCommentsByTopic(topicId: String, success:([Comment] -> Void), failure:(NSError -> Void)){
        let query = PFQuery(className: Constants.Table.Comment)
        query.includeKey(".")
        query.orderByDescending("createdAt")
        let topic = PFObject(withoutDataWithClassName: Constants.Table.Topic, objectId: topicId)
        query.whereKey(Comment.PKTopic, equalTo: topic)
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if let error = error {
                failure(error)
            } else if let objs = objects {
                var comments = [Comment]()
                for pfobj in objs {
                    let comment = Comment(pfObject: pfobj)
                    comments.append(comment)
                }
                success(comments)
            }
        }
    }
    
    func getUserById(userId: String, complete:(success: User?,  error: NSError?) -> Void){
        let query = PFQuery(className: Constants.Table.User)
        query.whereKey("objectId", equalTo: userId)
        query.findObjectsInBackgroundWithBlock { (users, error) in
            if let error = error {
                complete(success:nil, error: error)
            }else{
                if let users = users {
                            complete(success: users[0] as? User, error: error)
                            return
                }else{
                    complete(success:nil, error: NSError(domain: "", code: -1, userInfo: nil))
                }
            }
        }
    }
    func postBookMark(bookMark: Bookmark, complete:(bookMark: Bookmark?, error: NSError?) -> Void){
        bookMark.toPFObject().saveInBackgroundWithBlock { (success, error) in
            if success{
                let query = PFQuery(className: Constants.Table.Bookmark)
                query.orderByDescending("createdAt")
                query.limit = 1
                query.findObjectsInBackgroundWithBlock({ (bookMarks, error) in
                    if let error = error {
                        complete(bookMark: nil, error: error)
                    } else if let bookMarks = bookMarks {
                        let bookMark = Bookmark(pfObject: bookMarks.first!)
                        self.getTopicById(bookMark, complete: { (bookMark) in
                            complete(bookMark: bookMark, error: error)
                        })
                    }
                })
            }else{
                complete(bookMark: nil, error: error)
            }
        }
    }
    func getAllBookMarksByUser(userId: String, complete:(bookMarks: [Bookmark]?, error: NSError?) -> Void){
        let query = PFQuery(className: Constants.Table.Bookmark)
        query.orderByDescending("createdAt")
        let user = PFObject(withoutDataWithClassName: Constants.Table.User, objectId: userId)
        query.whereKey(Bookmark.PKPostUser, equalTo: user)
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if let error = error {
                complete(bookMarks: nil, error: error)
            } else if let objects = objects {
                var bookmarks = [Bookmark]()
                if objects.count == 0 {
                    complete(bookMarks: nil, error: error)
                }else{
                    for object in objects {
                        let  bookMark = Bookmark(pfObject: object)
                        self.getTopicById(bookMark, complete: { (bookMark) in
                            if let bookMark = bookMark {
                                bookmarks.append(bookMark)
                                if objects.count == bookmarks.count {
                                    complete(bookMarks: bookmarks, error: nil)
                                }
                            }else{
                              complete(bookMarks: nil, error: error)
                            }
                        })
                    }
                }
            }else{
              complete(bookMarks: nil, error: error)
            }
        }
    }
    
    func getTopicById(bookMark: Bookmark, complete:(bookMark: Bookmark!) -> Void){
        let query = PFQuery(className: Constants.Table.Topic)
        query.includeKey(Topic.PKParking)
        query.whereKey("objectId", equalTo: bookMark.topicId)
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if  let objects = objects {
                if objects.count > 0 {
                    let topic = Topic(pfObject: objects[0])
                    bookMark.topic = topic
                    complete(bookMark: bookMark)
                }else{
                    complete(bookMark: nil)
                }
            }else{
                complete(bookMark: nil)
            }
        }
    }

    func checkIsBookMarkTopicByUser(userId: String, topicId: String, complete:(isBookMark: Bool) -> Void){
        let query = PFQuery(className: Constants.Table.Bookmark)
        let user = PFObject(withoutDataWithClassName: Constants.Table.User, objectId: userId)
        query.whereKey(Bookmark.PKPostUser, equalTo: user)
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error != nil {
                complete(isBookMark: false)
            }else{
                if let objects = objects {
                    for obj in objects {
                    let bookMark = Bookmark(pfObject: obj) 
                        if bookMark.topicId == topicId {
                         complete(isBookMark: true)
                            return
                        }
                    }
                    complete(isBookMark: false)
                }else{
                    complete(isBookMark: false)
                }
            }
        }
    }

}
