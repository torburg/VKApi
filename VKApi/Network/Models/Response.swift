//
//  Response.swift
//  VKApi
//
//  Created by Maksim Torburg on 07.08.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation

struct Result: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let id, date: Int
    let text: String
    let attachments: [ItemAttachment]?
    let comments: Comments
    let likes: Likes
    let reposts: Reposts
}

// MARK: - ItemAttachment
struct ItemAttachment: Codable {
    let type: String
    let link: Link?
    let video: Video?
    let photo: Photo?
    let graffiti: Graffiti?
}

// MARK: - Graffiti
struct Graffiti: Codable {
    let id, ownerID: Int
    let photoSmall, photoLarge: String

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case photoSmall = "photo_200"
        case photoLarge = "photo_586"
    }
}

// MARK: - Link
struct Link: Codable {
    let url, title, description, target, imageSrc, imageBig: String

    enum CodingKeys: String, CodingKey {
        case url, title, target
        case description = "description"
        case imageSrc = "image_src"
        case imageBig = "image_big"
    }
}

// MARK: - Photo
struct Photo: Codable {
    let albumID, date, id, ownerID: Int
    let photoLarge, photoSmall, text: String

    enum CodingKeys: String, CodingKey {
        case date, id, text
        case albumID = "album_id"
        case ownerID = "owner_id"
        case photoLarge = "photo_604"
        case photoSmall = "photo_75"
    }
}

// MARK: - Video
struct Video: Codable {
    let id, date: Int
    let photoSmall, photoLarge, title, description: String

    enum CodingKeys: String, CodingKey {
        case date, id, title
        case description = "description"
        case photoSmall = "photo_130"
        case photoLarge = "photo_640"
    }
}

// MARK: - Comments
struct Comments: Codable {
    let count: Int
}

enum AttachmentType: String, Codable {
    case photo = "photo"
}


// MARK: - Likes
struct Likes: Codable {
    let count: Int
}

// MARK: - Reposts
struct Reposts: Codable {
    let count: Int
}
