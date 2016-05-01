//
//  AllPostModel.swift
//  pakr
//
//  Created by Huynh Quang Thao on 5/1/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation
protocol AllPostModel {
    func setTopic(_: [Topic])
    func totalTopics() -> Int
    func getTopicByOrder(order: Int) -> Topic?
}