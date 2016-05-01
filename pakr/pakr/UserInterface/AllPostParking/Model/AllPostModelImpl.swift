//
//  AllPostModelImpl.swift
//  pakr
//
//  Created by Huynh Quang Thao on 5/1/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class AllPostModelImpl: AllPostModel {
    var topics: [Topic]?
    
    func setTopic(topics: [Topic]) {
        self.topics = topics
    }
    
    func totalTopics() -> Int {
        return topics?.count ?? 0
    }
    
    func getTopicByOrder(order: Int) -> Topic? {
        return topics?[order] ?? nil
    }
}