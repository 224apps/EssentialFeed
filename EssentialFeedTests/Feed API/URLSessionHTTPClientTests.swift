//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Abdoulaye Diallo on 6/16/21.
//

import XCTest

class URLSessionHTTPClient {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(from url: URL){
        session.dataTask(with: url) { (_, _, _) in }.resume()
    }
}

class URLSessionHTTPClientTests: XCTestCase {
    
    func test_getFromURL_resumesDataTaskWithURL(){
        let url = URL(string: "http://any-url.com")!
        let session = URLSessionSpy()
        let task  = URLSessionDataTaskSpy()
        session.stub(url:url, task: task)
        
        let sut = URLSessionHTTPClient(session: session)
        
        sut.get(from: url)
        
        XCTAssertEqual(task.resumeCallCount, 1)
    }
    
//    func test_getFromURL_failsOnRequestError(){
//        let url = URL(string: "http://any-url.com")!
//        let error = NSError(domain: "test", code: 0)
//        let session = URLSessionSpy()
//        session.stub(url:url, error: error)
//        
//        let sut = URLSessionHTTPClient(session: session)
//        
//        sut.get(from: url)
//    }
    //MARK: - Helpers
    
    private class URLSessionSpy: URLSession {
        var stubs = [URL: URLSessionDataTask]()
        
        func stub(url:URL, error: NSError? = nil,task: URLSessionDataTask){
            stubs[url] = task
        }
        override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            return  stubs[url] ?? FakeURLSessionDataTask()
        }
    }
    
    private class FakeURLSessionDataTask: URLSessionDataTask {
        override func resume() {}
    }
    
    private class URLSessionDataTaskSpy: URLSessionDataTask {
        var resumeCallCount: Int  = 0
        
        override func resume() {
            resumeCallCount += 1
        }
    }
}
