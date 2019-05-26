//
//  DetailViewModel.swift
//  BHED
//
//  Created by Joel Youngblood on 5/24/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import Foundation
import RxSwift
import RxRealm
import Realm
import RealmSwift

final class DetailViewModel {
    
    private let disposeBag = DisposeBag()
    let post: Post
    private(set) var isLoading = BehaviorSubject<Bool>(value: false)
    private(set) var onError = BehaviorSubject<Error?>(value: nil)
    private(set) var completion = BehaviorSubject<Void>(value: ())
    var author: User?
    var comments: Results<Comment>?
    
    init(withPost post: Post) {
        self.post = post
        setupAndSync()
    }
    
    private func setupAndSync() {
        if let user = User.fetchFirstWhere(key: "id", matchesValue: "\(post.userId)") {
            //we have data, so sync that way
            author = user
            comments = Comment.fetchAllWhere(key: "postId", matchesValue: "\(post.id)")
            completion.onNext(())
        } else {
            //presume we have no data, and need to sync with the server
            syncAllData()
        }
    }
    
    func syncAllData() {
        isLoading.on(.next(true))
        let users = Request.allUsers()
        
        users.bind(to: Realm.rx.add(update: true, onError: { [weak self] elements, error in
            if let elems = elements {
                self?.onError.onNext(RealmError.save(error: error, elements: elems))
            } else {
                self?.onError.onNext(RealmError.connectionError)
            }
        })).disposed(by: disposeBag)
        
        let comments = Request.allComments()
        
        comments.bind(to: Realm.rx.add(update: true, onError: { [weak self] elements, error in
            if let elems = elements {
                self?.onError.onNext(RealmError.save(error: error, elements: elems))
            } else {
                self?.onError.onNext(RealmError.connectionError)
            }
        })).disposed(by: disposeBag)
        
        //If I needed to access any of these values, I would probably wrap these up as an enum, but here I just want the completion, so a quick hack
        let userSync = users.map { $0 as Any }
        let commentSync = comments.map { $0 as Any }
        Observable.of(userSync, commentSync).merge().asObservable()
        .subscribe(onError: { [weak self] error in
            self?.isLoading.on(.next(false))
            self?.onError.onNext(error)
        }, onCompleted: { [weak self] in
            self?.isLoading.on(.next(false))
            self?.bindOutput()
        }).disposed(by: disposeBag)
    }
    
    private func bindOutput() {
        author = User.fetchFirstWhere(key: "id", matchesValue: "\(post.userId)")
        comments = Comment.fetchAllWhere(key: "postId", matchesValue: "\(post.id)")
        completion.onNext(()) 
    }
}
