//
//  PostListTableViewController.swift
//  ReddiTTPractice
//
//  Created by Nick Reichard on 1/23/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController, UISearchBarDelegate, PostTableViewCellDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var isLiked: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.prefetchDataSource = self
        tableView.estimatedRowHeight = 150
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
    }
    
    // MARK: - Delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        guard let searchText = searchBar.text else { return }
        PostController.shared.fetchPost(with: searchText, completionBlock: { (post) in
            guard let post = post else { return }
            DispatchQueue.main.async {
                PostController.shared.posts = post
                self.tableView.reloadData()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false 
            }
            
        }) { (error) in
            print(error ?? "error fetching")
        }
    }
    
    func likeButtonTapped(_ sender: PostTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let post = PostController.shared.posts[indexPath.row]
      
        PostController.shared.udateLike(post: post)
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        sender.updateViews()
    
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostController.shared.postsCount
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        
        let post = PostController.shared.posts[indexPath.row]
        
        cell.post = post
        cell.delegate = self
        
        return cell
    }
}

extension PostListTableViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            
            let post = PostController.shared.posts[indexPath.row]
            guard let postEndpoint = post.imageEndPoint,
                let imageUrl = URL(string: postEndpoint) else { return }
            URLSession.shared.dataTask(with: imageUrl)
            print("prefetching  \(post.title)")
        }
    }
}







