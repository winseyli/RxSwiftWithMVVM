//
//  Post.swift
//  RxSwiftWithMVVM
//
//  Created by Winsey Li on 20/5/2018.
//  Copyright © 2018 winseyli.nz. All rights reserved.
//

import UIKit

class Post {
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
    static var empty: Post {
        return Post([:])
    }
    
    init(_ json: [String: Any]) {
        userId = json["userId"] as? Int ?? -1
        id = json["id"] as? Int ?? -1
        title = json["title"] as? String ?? ""
        body = json["body"] as? String ?? ""
    }

}
