//
//  FeedImageDataLoader.swift
//  EssentialFeediOS
//
//  Created by Abdoulaye Diallo on 6/28/21.
//

import Foundation


public protocol FeedImageDataLoaderTask {
    func cancel()
}

public protocol FeedImageDataLoader {
    typealias Result = Swift.Result<Data, Error>
    func loadImageData(from url: URL, completion: @escaping (Result) -> Void) -> FeedImageDataLoaderTask
}
