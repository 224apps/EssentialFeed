//
//  XCTestCase+MemoryLeaksTracking.swift
//  EssentialFeedTests
//
//  Created by Abdoulaye Diallo on 6/17/21.
//

import XCTest

extension XCTestCase {
    
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
