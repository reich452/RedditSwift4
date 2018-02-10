//
//  Post.swift
//  ReddiTTPractice
//
//  Created by Nick Reichard on 1/23/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import Foundation

struct JsonDictionary: Decodable {
    let data: DataDictionary
}

struct DataDictionary: Decodable {
    let children: [PostDataDictionary]
}

struct PostDataDictionary: Decodable {
    let post: Post
    
    private enum CodingKeys: String, CodingKey {
        case post = "data"
    }
}

class Post: Decodable {
    let numberOfComments: Int
    let title: String
    let imageEndPoint: String?
    let upVotes: Int
    let id: String
    var isLiked: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case numberOfComments = "num_comments"
        case title
        case imageEndPoint = "thumbnail"
        case upVotes = "ups"
        case id
    }
    
    init(numberOfComments: Int, title: String, imageEndPoint: String?, upVotes: Int, id: String, isLiked: Bool = false) {
        self.numberOfComments = numberOfComments
        self.title = title
        self.imageEndPoint = imageEndPoint
        self.upVotes = upVotes
        self.id = id
        self.isLiked = isLiked
    }


}

extension Post: Equatable {
    
    static func ==(lsh: Post, rhs: Post) -> Bool {
        if lsh.numberOfComments == rhs.numberOfComments { return true }
        if lsh.title == rhs.title { return true }
        if lsh.imageEndPoint == rhs.imageEndPoint { return true }
        if lsh.upVotes == rhs.upVotes { return true }
        if lsh.id == rhs.id { return true }
        
        return false
    }
}














