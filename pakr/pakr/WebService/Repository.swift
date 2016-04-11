//
// Created by Huynh Quang Thao on 4/10/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation

class Repository {
    static let UserRepos: [User] = [
            User(userId: "1", role: Role.UserAuth, email: "huynhquangthao@gmail.com", dateCreated: NSDate(), name: "Huynh Quang Thao", avatarUrl: "www.echip.com.vn"),
            User(userId: "2", role: Role.UserAuth, email: "nguyenthanhtien@gmail.com", dateCreated: NSDate(), name: "Nguyen Thanh Tien", avatarUrl: "www.echip.com.vn"),
            User(userId: "3", role: Role.UserAuth, email: "nguyentrungquang@gmail.com", dateCreated: NSDate(), name: "Nguyen Trung Quang", avatarUrl: "www.echip.com.vn"),
            User(userId: "4", role: Role.UserAuth, email: "trankimdu@gmail.com", dateCreated: NSDate(), name: "Tran Kim Du", avatarUrl: "www.echip.com.vn"),
            User(userId: "5", role: Role.UserAuth, email: "hophinhan@gmail.com", dateCreated: NSDate(), name: "Ho Phi Nhan", avatarUrl: "www.echip.com.vn"),
            User(userId: "6", role: Role.UserAuth, email: "maithanhhien@gmail.com", dateCreated: NSDate(), name: "Mai Thanh Hien", avatarUrl: "www.echip.com.vn"),
            User(userId: "7", role: Role.UserAuth, email: "nguyenthanhmai@gmail.com", dateCreated: NSDate(), name: "Nguyen Thanh Mai", avatarUrl: "www.echip.com.vn")
    ]

    class AddressRepos {
        static let bv_TuDu = Coordinate(latitude: 10, longitude: 10)
        static let cvpm_QuangTrung = Coordinate(latitude: 10.854558, longitude: 106.626177)
        static let cho_ben_thanh = Coordinate(latitude: 10.772556, longitude: 106.697991)
        static let truong_lhp = Coordinate(latitude: 21.285806, longitude: 106.198071)
        static let truong_khtn = Coordinate(latitude: 10, longitude: 10)
        static let now_zone = Coordinate(latitude: 10, longitude: 10)
        static let nha_sach_minh_khai = Coordinate(latitude: 10, longitude: 10)
        static let lazada_techhub = Coordinate(latitude: 10, longitude: 10)
        static let fsoft = Coordinate(latitude: 10, longitude: 10)
    }

//    static let ParkingRepos: [Parking] = [
//            Parking(parkingName: "benh vien Tu Du", dateCreated: NSDate(), addressName: "173/2 Nguyen Thi Minh Khai", latitude: Repository.AddressRepos.bv_TuDu.latitude, longitude: Repository.AddressRepos.bv_TuDu.longitude, parkingType: ParkingType.General),
//            Parking(parkingName: "benh vien Tu Du", dateCreated: NSDate(), addressName: "173/2 Nguyen Thi Minh Khai", latitude: Repository.AddressRepos.bv_TuDu.latitude, longitude: Repository.AddressRepos.bv_TuDu.longitude, parkingType: ParkingType.General),
//            Parking(parkingName: "benh vien Tu Du", dateCreated: NSDate(), addressName: "173/2 Nguyen Thi Minh Khai", latitude: Repository.AddressRepos.bv_TuDu.latitude, longitude: Repository.AddressRepos.bv_TuDu.longitude, parkingType: ParkingType.General),
//            Parking(parkingName: "benh vien Tu Du", dateCreated: NSDate(), addressName: "173/2 Nguyen Thi Minh Khai", latitude: Repository.AddressRepos.bv_TuDu.latitude, longitude: Repository.AddressRepos.bv_TuDu.longitude, parkingType: ParkingType.General),
//            Parking(parkingName: "benh vien Tu Du", dateCreated: NSDate(), addressName: "173/2 Nguyen Thi Minh Khai", latitude: Repository.AddressRepos.bv_TuDu.latitude, longitude: Repository.AddressRepos.bv_TuDu.longitude, parkingType: ParkingType.General),
//            Parking(parkingName: "benh vien Tu Du", dateCreated: NSDate(), addressName: "173/2 Nguyen Thi Minh Khai", latitude: Repository.AddressRepos.bv_TuDu.latitude, longitude: Repository.AddressRepos.bv_TuDu.longitude, parkingType: ParkingType.General),
//            Parking(parkingName: "benh vien Tu Du", dateCreated: NSDate(), addressName: "173/2 Nguyen Thi Minh Khai", latitude: Repository.AddressRepos.bv_TuDu.latitude, longitude: Repository.AddressRepos.bv_TuDu.longitude, parkingType: ParkingType.General),
//            Parking(parkingName: "benh vien Tu Du", dateCreated: NSDate(), addressName: "173/2 Nguyen Thi Minh Khai", latitude: Repository.AddressRepos.bv_TuDu.latitude, longitude: Repository.AddressRepos.bv_TuDu.longitude, parkingType: ParkingType.General),
//            Parking(parkingName: "benh vien Tu Du", dateCreated: NSDate(), addressName: "173/2 Nguyen Thi Minh Khai", latitude: Repository.AddressRepos.bv_TuDu.latitude, longitude: Repository.AddressRepos.bv_TuDu.longitude, parkingType: ParkingType.General),
//            Parking(parkingName: "benh vien Tu Du", dateCreated: NSDate(), addressName: "173/2 Nguyen Thi Minh Khai", latitude: Repository.AddressRepos.bv_TuDu.latitude, longitude: Repository.AddressRepos.bv_TuDu.longitude, parkingType: ParkingType.General),
//            Parking(parkingName: "benh vien Tu Du", dateCreated: NSDate(), addressName: "173/2 Nguyen Thi Minh Khai", latitude: Repository.AddressRepos.bv_TuDu.latitude, longitude: Repository.AddressRepos.bv_TuDu.longitude, parkingType: ParkingType.General),
//            Parking(parkingName: "benh vien Tu Du", dateCreated: NSDate(), addressName: "173/2 Nguyen Thi Minh Khai", latitude: Repository.AddressRepos.bv_TuDu.latitude, longitude: Repository.AddressRepos.bv_TuDu.longitude, parkingType: ParkingType.General),
//            Parking(parkingName: "benh vien Tu Du", dateCreated: NSDate(), addressName: "173/2 Nguyen Thi Minh Khai", latitude: Repository.AddressRepos.bv_TuDu.latitude, longitude: Repository.AddressRepos.bv_TuDu.longitude, parkingType: ParkingType.General),
//            Parking(parkingName: "benh vien Tu Du", dateCreated: NSDate(), addressName: "173/2 Nguyen Thi Minh Khai", latitude: Repository.AddressRepos.bv_TuDu.latitude, longitude: Repository.AddressRepos.bv_TuDu.longitude, parkingType: ParkingType.General),
//            Parking(parkingName: "benh vien Tu Du", dateCreated: NSDate(), addressName: "173/2 Nguyen Thi Minh Khai", latitude: Repository.AddressRepos.bv_TuDu.latitude, longitude: Repository.AddressRepos.bv_TuDu.longitude, parkingType: ParkingType.General),
//    ]
//
    static let TopicRepos: [Topic] = [
//            Topic(topicId: "1", userId: "1", date: NSDate(), parking: Repository.ParkingRepos[0], rating: 4),
//            Topic(topicId: "1", userId: "1", date: NSDate(), parking: Repository.ParkingRepos[1], rating: 4),
//            Topic(topicId: "1", userId: "1", date: NSDate(), parking: Repository.ParkingRepos[2], rating: 4),
//            Topic(topicId: "1", userId: "1", date: NSDate(), parking: Repository.ParkingRepos[3], rating: 4),
//            Topic(topicId: "1", userId: "1", date: NSDate(), parking: Repository.ParkingRepos[4], rating: 4),
//            Topic(topicId: "1", userId: "1", date: NSDate(), parking: Repository.ParkingRepos[5], rating: 4),
//            Topic(topicId: "1", userId: "1", date: NSDate(), parking: Repository.ParkingRepos[6], rating: 4),
//            Topic(topicId: "1", userId: "1", date: NSDate(), parking: Repository.ParkingRepos[7], rating: 4),
//            Topic(topicId: "1", userId: "1", date: NSDate(), parking: Repository.ParkingRepos[8], rating: 4),
//            Topic(topicId: "1", userId: "1", date: NSDate(), parking: Repository.ParkingRepos[9], rating: 4),
//            Topic(topicId: "1", userId: "1", date: NSDate(), parking: Repository.ParkingRepos[10], rating: 4),
//            Topic(topicId: "1", userId: "1", date: NSDate(), parking: Repository.ParkingRepos[11], rating: 4),
//            Topic(topicId: "1", userId: "1", date: NSDate(), parking: Repository.ParkingRepos[12], rating: 4)
    ]
}
