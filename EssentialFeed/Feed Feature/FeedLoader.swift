//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Abdoulaye Diallo on 6/14/21.
//

import Foundation

public typealias LoadFeedResult = Result <[FeedImage], Error>


public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult)->Void)
}
