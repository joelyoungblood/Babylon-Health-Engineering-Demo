//
//  PostsViewController.swift
//  BHED
//
//  Created by Joel Youngblood on 5/23/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import NSObject_Rx
import RxRealmDataSources

final class PostsViewController: UIViewController {
    
    private let viewModel = PostsViewModel()
    private let refreshControl = UIRefreshControl()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.separatorColor = .white
        tableView.register(PostTableViewCell.self)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        view.backgroundColor = .babylonPurple
        
        let navBarHeight = navigationController?.navigationBar.frame.height ?? 0.0
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(navBarHeight)
            make.leading.trailing.bottom.equalToSuperview()
        }
        tableView.addSubview(refreshControl)
        refreshControl.beginRefreshing()
        
        bindUI()
    }
    
    private func bindUI() {
        refreshControl.rx.controlEvent(.valueChanged)
            .asObservable().subscribe(onNext: { [weak self] in
                self?.viewModel.syncAllData()
            }).disposed(by: rx.disposeBag)
        
        viewModel.isLoading
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] loading in
                loading ? self?.refreshControl.beginRefreshing() : self?.refreshControl.endRefreshing()
        }).disposed(by: rx.disposeBag)
        
        viewModel.onError
            .subscribe(onNext: { [weak self] error in
                if let err = error {
                    self?.showSnackbar(forError: err)
                }
            }).disposed(by: rx.disposeBag)
        
        let dataSource = RxTableViewRealmDataSource<Post>(cellIdentifier: String(describing: PostTableViewCell.self), cellType: PostTableViewCell.self)
            { cell, indexPath, post in
                cell.configure(forPost: post)
        }
        
        viewModel.posts?
            .bind(to: tableView.rx.realmChanges(dataSource))
            .disposed(by: rx.disposeBag)
        
        tableView.rx.realmModelSelected(Post.self)
            .asObservable().subscribe(onNext: { [weak self] post in
                self?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                self?.navigationController?.pushViewController(DetailViewController(withPost: post), animated: true)
            }).disposed(by: rx.disposeBag)
    }
}
