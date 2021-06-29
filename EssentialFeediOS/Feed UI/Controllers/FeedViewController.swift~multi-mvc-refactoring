//
//  FeedViewController.swift
//  EssentialFeediOS
//
//  Created by Abdoulaye Diallo on 6/26/21.
//

import Foundation
import EssentialFeed
import UIKit

final class FeedImageCellController {
    
}

final class FeedViewController: UITableViewController , UITableViewDataSourcePrefetching{
    private var refreshController: FeedRefreshViewController?
    private var imageLoader: FeedImageDataLoader?

    
    private var cellControllers = [IndexPath: FeedImageCellController]()
    private var tableModel = [FeedImage]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    convenience init(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader?) {
        self.init()
        self.refreshControl = FeedRefreshViewController(feedLoader: feedLoader)
        self.imageLoader = imageLoader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        refreshControl = refreshController?.view
        refreshController?.onRefresh = {[weak self] feed in
            self?.tableModel =  feed
        }
        tableView.prefetchDataSource  = self
        refreshController.refresh()
    }
    
  
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellController(forRowAt: indexPath).view()
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        removeCellController(forRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            let cellModel = tableModel[indexPath.row]
            tasks[indexPath] = imageLoader?.loadImageData(from: cellModel.url){ _ in }
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach(cancelTask)
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> FeedImageCellController {
        let cellModel = tableModel[indexPath.row]
        let cellController = FeedImageCellController(model: cellModel, imageLoader: imageLoader!)
        cellControllers[indexPath] = cellController
        return cellController
    }
    
    private func cancelTask(forRow indexPath: IndexPath) {
        tasks[indexPath]?.cancel()
        tasks[indexPath] = nil
    }
}

