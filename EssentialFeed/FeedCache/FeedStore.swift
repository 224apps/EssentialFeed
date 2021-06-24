//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Abdoulaye Diallo on 6/20/21.
//

import Foundation

public enum CachedFeed{
    case empty
    case found(feed:[LocalFeedImage], timestamp: Date)
    case  failure(Error)
}

public protocol FeedStore {
    typealias DeletionCompletion = (Error?)-> Void
    typealias InsertionCompletion = (Error?)-> Void
    
    typealias RetrievalResult = Result<CachedFeed, Error>
    typealias RetrievalCompletion = (RetrievalResult)-> Void
    
    func deleteCacheFeed(completion: @escaping DeletionCompletion)
    func insert( _ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion)
    func retrieve(completion: @escaping RetrievalCompletion)
}


