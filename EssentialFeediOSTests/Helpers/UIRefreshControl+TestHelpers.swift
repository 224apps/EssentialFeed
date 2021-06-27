//
//  UIRefreshControl+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Abdoulaye Diallo on 6/27/21.
//

import UIKit


private extension UIRefreshControl {
    func simulatePullToRefresh(){
        simulate(event: .valueChanged)
    }
}
