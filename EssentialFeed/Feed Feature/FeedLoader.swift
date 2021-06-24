//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Abdoulaye Diallo on 6/14/21.
//

import Foundation

public protocol FeedLoader {
    typealias Result = Swift.Result <[FeedImage], Error>
    func load(completion: @escaping (Result)->Void)
}
