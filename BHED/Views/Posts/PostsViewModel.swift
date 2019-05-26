//
//  PostsViewModel.swift
//  BHED
//
//  Created by Joel Youngblood on 5/23/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import Foundation
import RealmSwift
import RxRealm
import RxSwift

final class PostsViewModel {
    
    private let disposeBag = DisposeBag()
    private(set) var posts: Observable<(AnyRealmCollection<Post>, RealmChangeset?)>?
    private(set) var onError = BehaviorSubject<Error?>(value: nil)
    private(set) var isLoading = BehaviorSubject<Bool>(value: false)
    
    init() {
        syncAllData()
        bindOutput()
    }
    
    func syncAllData() {
        isLoading.on(.next(true))
        Request.allPosts()
        .observeOn(SerialDispatchQueueScheduler(qos: .background))
        .do(onError: { [weak self] error in
            self?.isLoading.on(.next(false))
            self?.onError.on(.next(error))
        }, onCompleted: { [weak self] in
            self?.isLoading.on(.next(false))
        }).bind(to: Realm.rx.add(update: true, onError: { [weak self] elements, error in
            if let elems = elements {
                self?.onError.onNext(RealmError.save(error: error, elements: elems))
            } else {
                self?.onError.onNext(RealmError.connectionError)
            }
        })).disposed(by: disposeBag)
    }
    
    private func bindOutput() {
        guard let realm = try? Realm() else {
            onError.on(.next(RealmError.connectionError))
            return
        }
        
        posts = Observable.changeset(from: realm.objects(Post.self)).share()
    }
}
