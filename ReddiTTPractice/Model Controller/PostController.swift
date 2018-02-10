//
//  PostController.swift
//  ReddiTTPractice
//
//  Created by Nick Reichard on 1/23/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import UIKit

class PostController {
    
    static let shared = PostController()
    
    private let baseURL = URL(string: "https://www.reddit.com/r/")!
    
    var posts: [Post] = []
    var post: Post?
   
    
    var postsCount: Int {
        return posts.count
    }
    
    
    
    // MARK: - Update
    func udateLike(post: Post) {
    
        post.isLiked = !post.isLiked
    }
    
    func updateLike2(post: Post) {
        self.post?.isLiked = !post.isLiked
    }
    
    // MARK: - Fetch
    
    typealias PostCompletionHandler = (Post?, PostError) -> Void
    
    func fetchPost(with searchTerm: String, completionBlock: @escaping ([Post]?) -> Void, completion: @escaping (PostError?) -> Void) {
        
        let url = baseURL.appendingPathComponent(searchTerm).appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            do {
                if let error = error { throw error }
                guard let data = data else { throw NSError() }
                
                let jsonDictionary = try JSONDecoder().decode(JsonDictionary.self, from: data)
                let posts = jsonDictionary.data.children.flatMap{$0.post}
                
                completionBlock(posts)
                
            } catch let error {
                print("Error fetching image \(error.localizedDescription) \(error) \(#function)")
                completion(.cannotParseJson); return
            }
        }.resume()
    }
    
    func fetchImage(post: Post, completion: @escaping (UIImage?) -> Void) {
        
        guard let imageEndpoint = post.imageEndPoint,
            let url = URL(string: imageEndpoint) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            do {
                if let error = error { throw error }
                guard let data = data else { throw NSError() }
                let image = UIImage(data: data)
                
                completion(image)
            
            } catch let error {
                print(error)
                completion(nil); return
            }
        }.resume()
    }
}
