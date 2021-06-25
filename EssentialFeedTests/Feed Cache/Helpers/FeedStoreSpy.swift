//
//  FeedStoreSpy.swift
//  EssentialFeedTests
//
//  Created by Abdoulaye Diallo on 6/20/21.
//

import Foundation
import EssentialFeed

class FeedStoreSpy: FeedStore {

    enum ReceivedMessage:Equatable {
        case deleteCacheFeed
        case insert([LocalFeedImage], Date)
        case retrieve
    }
    
    private(set) var receivedMessages = [ReceivedMessage]()
    
    private var deletionCompletions = [DeletionCompletion]()
    private var insertionCompletions = [InsertionCompletion]()
    private var retrievalCompletions = [RetrievalCompletion]()
    
    func deleteCacheFeed(completion: @escaping DeletionCompletion) {
        deletionCompletions.append(completion)
        receivedMessages.append(.deleteCacheFeed)
    }
    
    func completeDeletion(with error: NSError, at index: Int = 0){
        deletionCompletions[index](.failure(error))
    }
    
    func completeDeletionSuccessfully(at index: Int = 0){
        deletionCompletions[index](.success(()))
    }
    
    func insert( _ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion){
        receivedMessages.append(.insert(feed, timestamp))
        insertionCompletions.append(completion)
    }
    
    func completeInsertion(with error: NSError, at index: Int = 0){
        insertionCompletions[index](.failure(error))
    }
    
    func completeInsertionSuccessfully(at index: Int = 0){
        insertionCompletions[index](.success(()))
    }
    
    func retrieve(completion: @escaping RetrievalCompletion){
        retrievalCompletions.append(completion)
        receivedMessages.append(.retrieve)
    }
    
    func completeRetrieval(with error: NSError, at index: Int = 0){
        retrievalCompletions[index](.failure(error))
    }
    func completeRetrieval(with feed: [LocalFeedImage], timestamp: Date, at index: Int = 0){
        retrievalCompletions[index](.success(CachedFeed(feed:feed, timestamp:timestamp)))
    }
    func completeRetrievalWithEmptyCache(at index: Int = 0){
        retrievalCompletions[index](.success(.none))
    }
}
