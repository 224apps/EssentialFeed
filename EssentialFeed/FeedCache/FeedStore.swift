//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Abdoulaye Diallo on 6/20/21.
//

import Foundation

public protocol FeedStore {
    typealias DeletionCompletion = (Error?)-> Void
    typealias InsertionCompletion = (Error?)-> Void
    func deleteCacheFeed(completion: @escaping DeletionCompletion)
    func insert( _ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion)
}


