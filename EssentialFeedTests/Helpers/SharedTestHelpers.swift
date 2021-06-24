//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Abdoulaye Diallo on 6/21/21.
//

import Foundation
import EssentialFeed


func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}
