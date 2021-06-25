//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Abdoulaye Diallo on 6/20/21.
//

import Foundation


public typealias CachedFeed = (feed: [LocalFeedImage], timestamp: Date)

public protocol FeedStore {
    typealias DeletionError = Error?
    typealias DeletionCompletion = (DeletionError)-> Void
    
    typealias InsertionError = Error?
    typealias InsertionCompletion = (InsertionError)-> Void
    
    typealias RetrievalResult = Result<CachedFeed?, Error>
    typealias RetrievalCompletion = (RetrievalResult)-> Void
    
    func deleteCacheFeed(completion: @escaping DeletionCompletion)
    func insert( _ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion)
    func retrieve(completion: @escaping RetrievalCompletion)
}


