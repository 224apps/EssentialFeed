//
//  FeedViewController.swift
//  EssentialFeediOS
//
//  Created by Abdoulaye Diallo on 6/26/21.
//

import Foundation
import EssentialFeed
import UIKit

final class FeedImageCellController{
    
    private var task: FeedImageDataLoaderTask?
    private let model: FeedImage
    private let imageLoader: FeedImageDataLoader
    
    
    init(model: FeedImage, imageLoader: FeedImageDataLoader){
        self.model = model
        self.imageLoader = imageLoader
    }
    
    func view() -> UITableViewCell {
    
        let cell = FeedImageCell()
        cell.locationContainer.isHidden = (model.location == nil)
        cell.locationLabel.text = model.location
        cell.descriptionLabel.text = model.description
        cell.feedImageView.image = nil
        cell.feedImageRetryButton.isHidden = true
        cell.feedImageContainer.startShimmering()
        
        let loadImage = { [weak self, weak cell] in
            guard let self = self else { return }
            
            self.task  = self.imageLoader.loadImageData(from: self.model.url) { [weak cell] result in
                let data = try? result.get()
                let image = data.map(UIImage.init) ?? nil
                cell?.feedImageView.image = image
                cell?.feedImageRetryButton.isHidden = (image != nil)
                cell?.feedImageContainer.stopShimmering()
            }
        }
        
        cell.onRetry = loadImage
        loadImage()
        return cell
    }
    
    func preload() {
        task = imageLoader.loadImageData(from: model.url) { _ in }
    }

    deinit {
        task?.cancel()
    }
}


final class FeedViewController: UITableViewController , UITableViewDataSourcePrefetching{
    private var refreshController: FeedRefreshViewController?
    private var imageLoader: FeedImageDataLoader?
    private var cellControllers = [IndexPath: FeedImageCellController]()
    
    private var tableModel = [FeedImage](){
        didSet{
            tableView.reloadData()
        }
    }
    
    convenience init(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader?) {
        self.init()
        self.refreshController = FeedRefreshViewController(feedLoader: feedLoader)
        self.imageLoader = imageLoader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = refreshController?.view
        
        refreshController?.onRefresh = { [weak self] feed in
            self?.tableModel = feed
        }
        tableView.prefetchDataSource  = self
        refreshController?.refresh()
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
            cellController(forRowAt: indexPath).preload()
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach(removeCellController)
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> FeedImageCellController {
            let cellModel = tableModel[indexPath.row]
            let cellController = FeedImageCellController(model: cellModel, imageLoader: imageLoader!)
            cellControllers[indexPath] = cellController
            return cellController
        }
    
    private func removeCellController(forRowAt indexPath: IndexPath) {
            cellControllers[indexPath] = nil
        }
}

