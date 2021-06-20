//
//  FeedStoreSpy.swift
//  EssentialFeedTests
//
//  Created by Abdoulaye Diallo on 6/20/21.
//

import Foundation
import EssentialFeed

class FeedStoreSpy: FeedStore {
    typealias DeletionCompletion = (Error?)-> Void
    typealias InsertionCompletion = (Error?)-> Void
    
    enum ReceivedMessage:Equatable {
        case deleteCacheFeed
        case insert([LocalFeedImage], Date)
    }
    
    private(set) var receivedMessages = [ReceivedMessage]()
    
    private var deletionCompletions = [DeletionCompletion]()
    private var insertionCompletions = [InsertionCompletion]()
    
    func deleteCacheFeed(completion: @escaping DeletionCompletion) {
        deletionCompletions.append(completion)
        receivedMessages.append(.deleteCacheFeed)
    }
    
    func completeDeletion(with error: NSError, at index: Int = 0){
        deletionCompletions[index](error)
    }
    
    func completeDeletionSuccessfully(at index: Int = 0){
        deletionCompletions[index](nil)
    }
    
    func insert( _ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion){
        receivedMessages.append(.insert(feed, timestamp))
        insertionCompletions.append(completion)
    }
    
    func completeInsertion(with error: NSError, at index: Int = 0){
        insertionCompletions[index](error)
    }
    
    func completeInsertionSuccessfully(at index: Int = 0){
        insertionCompletions[index](nil)
    }
}
