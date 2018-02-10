//
//  PostTableViewCell.swift
//  ReddiTTPractice
//
//  Created by Nick Reichard on 1/23/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import UIKit

protocol PostTableViewCellDelegate: class {
    func likeButtonTapped(_ sender: PostTableViewCell)
}

class PostTableViewCell: UITableViewCell {
    
    //    override func prepareForReuse() {
    //        updateViews()
    //    }
    //
    // MARK: - Delegate
    weak var delegate: PostTableViewCellDelegate?
    
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    // MARK: - Actions
    
    @IBAction func heartButtonTapped(_ sender: UIButton) {
        delegate?.likeButtonTapped(self)
    }
    
    func updateViews() {
        guard let post = post else { return }
        titleLabel.text = post.title
        voteCountLabel.text = "\(post.upVotes)"
        numberOfCommentsLabel.text = "\(post.numberOfComments)"
        
        // if it's liked
        if post.isLiked {
            self.heartButton.setImage(#imageLiteral(resourceName: "iconHeartLiked"), for: .normal)
        } else {
            self.heartButton.setImage(#imageLiteral(resourceName: "iconHeart"), for: .normal)
        }
    
        PostController.shared.fetchImage(post: post) { (newImage) in
            DispatchQueue.main.async {
                self.postImageView.image = newImage
            }
        }
    }
    
    @IBOutlet weak var numberOfCommentsLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var backgroundLayerView: UIView!
}

