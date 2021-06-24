//
//  LocalFeedLoader.swift
//  EssentialFeed
//
//  Created by Abdoulaye Diallo on 6/20/21.
//

import Foundation

public final class LocalFeedLoader {
    private let store: FeedStore
    private let currentDate: () -> Date

    public init(store: FeedStore, currentDate: @escaping () -> Date = Date.init){
        self.store = store
        self.currentDate = currentDate
    }
}

//MARK: - Save
extension LocalFeedLoader{
    
    public typealias SaveResult = Error?
    public func save(_ feed: [FeedImage], completion: @escaping (SaveResult)-> Void){
        store.deleteCacheFeed { [weak self] error in
            guard  let self = self  else { return }
            if let cacheDeletionError = error {
                completion(cacheDeletionError)
            }else{
                self.cache(feed, with: completion)
            }
        }
    }
    
    private func cache(_ feed: [FeedImage], with completion: @escaping (SaveResult)-> Void){
        store.insert(feed.toLocal(), timestamp: self.currentDate()) { [weak self](error) in
            guard self != nil else { return }
            completion(error)
        }
    }
}

//MARK: - Load
extension LocalFeedLoader: FeedLoader {
    public typealias LoadResult = FeedLoader.Result
    public func load(completion: @escaping (LoadResult)-> Void){
        store.retrieve { [weak self] result in
            guard let self = self  else  { return }
            switch result {
                case let .failure(error):
                    completion(.failure(error))
                case let .success(.found(feed, timestamp)) where FeedCachePolicy.validate(timestamp, against: self.currentDate()):
                    completion(.success(feed.toModels()))
                case .success:
                    completion(.success([]))
            }
        }
    }
}

//MARK: - Validate
extension LocalFeedLoader{
    public func validateCache(){
        store.retrieve{ [weak self] result  in
            guard let self = self else { return }
            switch result {
                case .failure:
                    self.store.deleteCacheFeed{_ in }
                case let .success(.found(_, timestamp)) where !FeedCachePolicy.validate(timestamp, against: self.currentDate()):
                    self.store.deleteCacheFeed{_ in }
                default: break
            }
        }
    }
}

private extension Array where Element == FeedImage {
    func toLocal() -> [LocalFeedImage] {
        return map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url)}
    }
}

private extension Array where Element == LocalFeedImage {
    func toModels() -> [FeedImage] {
        return map { FeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url)}
    }
}
