//
//  UITableView+Dequeueing.swift
//  EssentialFeediOS
//
//  Created by Abdoulaye Diallo on 7/1/21.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}


