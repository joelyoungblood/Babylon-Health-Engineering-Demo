//
//  DetailViewController.swift
//  BHED
//
//  Created by Joel Youngblood on 5/24/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import UIKit
import SnapKit
import RxRealm
import RxSwift
import RxCocoa
import NSObject_Rx

fileprivate enum DetailViewSections: Int, EnumIterable {
    case title
    case info
    case body
}

final class DetailViewController: UIViewController {
    
    private var viewModel: DetailViewModel!
    private let post: Post
    private let refreshControl = UIRefreshControl()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView()
        tableView.addSubview(self.refreshControl)
        tableView.register(DetailTitleTableViewCell.self)
        tableView.register(DetailInfoTableViewCell.self)
        tableView.register(DetailBodyTableViewCell.self)
        return tableView
    }()
    
    init(withPost: Post) {
        self.post = withPost
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .babylonPurple
        viewModel = DetailViewModel(withPost: post)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bindUI()
    }
    
    func bindUI() {
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                self?.viewModel.syncAllData()
            }).disposed(by: rx.disposeBag)
        
        viewModel.onError
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                if let err = error {
                    self?.showSnackbar(forError: err)
                }
            }).disposed(by: rx.disposeBag)
        
        viewModel.isLoading
            .subscribe(onNext: { [weak self] isLoading in
                isLoading ? self?.refreshControl.beginRefreshing() : self?.refreshControl.endRefreshing()
            }).disposed(by: rx.disposeBag)
        
        viewModel.completion
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.tableView.reloadData()
            }).disposed(by: rx.disposeBag)
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DetailViewSections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = DetailViewSections(rawValue: indexPath.row)!
        switch section {
        case .title:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as DetailTitleTableViewCell
            cell.configure(withTitle: post.title)
            return cell
        case .info:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as DetailInfoTableViewCell
            cell.configure(withUser: viewModel.author, withCommentCount: viewModel.comments?.count)
            return cell
        case .body:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as DetailBodyTableViewCell
            cell.configure(forBodyString: post.body)
            return cell
        }
    }
}
