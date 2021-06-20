//
//  LocalFeedLoader.swift
//  EssentialFeed
//
//  Created by Abdoulaye Diallo on 6/20/21.
//

import Foundation


public protocol FeedStore {
    typealias DeletionCompletion = (Error?)-> Void
    typealias InsertionCompletion = (Error?)-> Void
    func deleteCacheFeed(completion: @escaping DeletionCompletion)
    func insert( _ items: [FeedItem], timestamp: Date, completion: @escaping InsertionCompletion)
}

public final class LocalFeedLoader {
    private let store: FeedStore
    private let currentDate: () -> Date
    
    public init(store: FeedStore, currentDate: @escaping () -> Date = Date.init){
        self.store = store
        self.currentDate = currentDate
    }
    
    public func save(_ items: [FeedItem], completion: @escaping (Error?)-> Void){
        store.deleteCacheFeed { [weak self] error in
            guard  let self = self  else { return }
            if let cacheDeletionError = error {
                completion(cacheDeletionError)
            }else{
                self.cache(items, with: completion)
            }
        }
    }
    
    private func cache(_ items: [FeedItem], with completion: @escaping (Error?)-> Void){
        store.insert(items, timestamp: self.currentDate()) { [weak self](error) in
            guard self != nil else { return }
            completion(error)
        }
    }
}