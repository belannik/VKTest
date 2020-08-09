//
//  FeedVC.swift
//  VKTest
//
//  Created by Anton on 03.08.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import UIKit

final class FeedVC: UIViewController
{
    // MARK: - Property list

    private let tableView = UITableView()
    
    private let decoderService = DecoderService()
    private let networkService: FeedsNetworkService
    private let cellModelBuilder = CellModelBuilder()
    private var posts = [Post]()
    private var nextFrom: String?
	private var loadingMore = true

    // MARK: - Initialization

    init(networkService: FeedsNetworkService) {
        self.networkService = networkService
    
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
		setupNavigationBar()
        setupTableView()
        load()
    }

    // MARK: - Private methods

	private func setupNavigationBar() {
        navigationItem.title = "Лента"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .blue
	}

    private func setupTableView() {
		view = tableView
		tableView.separatorStyle = .singleLine
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseID)
    }

    private func load() {
        networkService.fetchFeeds(nextFrom: nextFrom, callback: parseData)
    }

    private lazy var parseData: (Result<Data, Error>) -> () = { [weak self] dataResult in
        guard let self = self else { return }
        switch dataResult {
        case .success(let data): self.decoderService.decode(from: data, modelType: ResponseFeedModel.self,
                                                             callback: self.parseModel)
		case .failure(let error): self.showAlert(title: error.localizedDescription, action: self.load)
        }
    }

    private lazy var parseModel: (Result<ResponseFeedModel, Error>) -> () = { [weak self] modelResult in
        switch modelResult {
        case .success(let model):
            self?.cellModelBuilder.buildFromResponseModel(responseModel: model, callBack: { [weak self] posts in
				self?.posts.append(contentsOf: posts)
                self?.nextFrom = model.response.nextFrom
                self?.tableView.reloadData()
				self?.loadingMore = false
            })
        case .failure(let error): self?.showAlert(title: error.localizedDescription, action: self?.load)
        }
    }
}

// MARK: - UITableViewDelegate

extension FeedVC: UITableViewDelegate
{
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let currentOffset = scrollView.contentOffset.y
		let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
		let deltaOffset = maximumOffset - currentOffset
		let additionalOffset = -(view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
		if deltaOffset < additionalOffset && !loadingMore && nextFrom != nil {
			loadingMore = true
			load()
		}
	}

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		guard let cell = cell as? PostCell else { return }

		cell.setup()
		cell.selectionStyle = .none
		cell.updateModel(postModel: posts[indexPath.row])
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return posts[indexPath.row].totalHeight
	}
}

// MARK: - UITableViewDataSource

extension FeedVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return tableView.dequeueReusableCell(withIdentifier: PostCell.reuseID, for: indexPath)
	}
}

