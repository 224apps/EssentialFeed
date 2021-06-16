//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Abdoulaye Diallo on 6/14/21.
//

import Foundation

public enum LoadFeedResult{
    case success([FeedItem])
    case failure(Error)
}


protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult)->Void)
}
