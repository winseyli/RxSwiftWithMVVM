//
//  DataService.swift
//  RxSwiftWithMVVM
//
//  Created by Winsey Li on 19/5/2018.
//  Copyright © 2018 winseyli.nz. All rights reserved.
//

import Alamofire
import RxSwift
import RxCocoa

class DataService {
    
    func fetchData() -> Observable<[Post]> {
        return Observable.create { observer in
            let request = Alamofire.request("https://jsonplaceholder.typicode.com/posts", method: .get, parameters: nil)
            
            request.responseJSON { response in
                guard response.result.isSuccess else {
                    observer.onError(NSError(domain: "Network error", code: 0, userInfo: nil))
                    return
                }
                
                guard let array = response.result.value as? [[String: Any]] else {
                    observer.onError(NSError(domain: "Invalid data", code: 0, userInfo: nil))
                    return
                }
                
                var posts = [Post]()
                array.forEach { entry in
                    let post = Post(entry)
                    posts.append(post)
                }
                
                // Simulate a 2 seconds loading
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    observer.onNext(posts)
                    observer.onCompleted()
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }

}
