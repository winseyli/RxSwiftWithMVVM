//
//  PostTableViewCell.swift
//  RxSwiftWithMVVM
//
//  Created by Winsey Li on 20/5/2018.
//  Copyright © 2018 winseyli.nz. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    var post = Post.empty {
        didSet {
            titleLabel.text = post.title
        }
    }
    
}
