//
//  FeedImageViewModel.swift
//  EssentialFeediOS
//
//  Created by Abdoulaye Diallo on 6/28/21.
//

import Foundation
import EssentialFeed

struct FeedImageViewModel<Image> {
    let description: String?
    let location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool

    var hasLocation: Bool {
        return location != nil
    }
}
