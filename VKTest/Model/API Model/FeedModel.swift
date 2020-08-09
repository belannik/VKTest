//
//  FeedModel.swift
//  VKTest
//
//  Created by Anton on 04.08.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import Foundation

struct ResponseFeedModel: Decodable
{
    let response: FeedModel
}

struct FeedModel: Decodable
{
    let profiles: [Profiles]
    let groups: [Groups]
    let items: [Item]
    let nextFrom: String?
}

struct Profiles: Decodable, ProfileAndGroupsCombine
{
    var id: Int
    let firstName: String
    let lastName: String
    var photo50: String
    
    var displayedName: String { return firstName + " " + lastName }
}

struct Groups: Decodable, ProfileAndGroupsCombine
{
    var id: Int
    var photo50: String
    let name: String

    var displayedName: String { return name }
}

struct Item: Decodable
{
    let sourceId: Int
    let attachments: [Attachments]?
    let date: Double
    let comments: OnlyCount?
    let likes: OnlyCount?
    let reposts: OnlyCount?
    let views: OnlyCount?
    let text: String?
}

struct Attachments: Decodable
{
    let type: String?
    let photo: Photo?
    let video: Video?
}

struct Photo: Decodable {
    let sizes: [PhotoSize]
    var biggestImage: PhotoSize? { return sizes.sorted(by: {$0.width > $1.width}).first }
}

struct PhotoSize: Decodable
{
    let url: String
    let width: Int
    let height: Int
}

struct Video: Decodable
{
    let comments: Int?
    let date: Double?
    let image: [Image]?
    let duration: Int?
    
    var biggestImage: Image? { return image?.sorted(by: { $0.width > $1.width }).first }
}

struct Image: Decodable
{
    let height: Int
    let url: String
    let width: Int
}

struct OnlyCount: Decodable
{
    let count: Int?
}
