//
//  CacheFeedUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Abdoulaye Diallo on 6/19/21.
//

import XCTest

class LocalfeedLoader {
    init(store: FeedStore){
        
    }
}

class FeedStore {
    var deleteCacheFeedCount = 0
}

class CacheFeedUseCaseTests: XCTestCase {
    
    func test_init_doesNotDeleteCacheUponCreation(){
        let store = FeedStore()
        _ = LocalfeedLoader(store: store)
        
        XCTAssertEqual(store.deleteCacheFeedCount, 0)
    }
}
