//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Abdoulaye Diallo on 6/16/21.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}
public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult)->Void)
}
