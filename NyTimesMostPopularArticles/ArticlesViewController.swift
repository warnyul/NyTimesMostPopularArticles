//
//  ViewController.swift
//  NyTimesMostPopularArticles
//
//  Created by Balázs Varga on 2017. 06. 29..
//  Copyright © 2017. Balazs Varga. All rights reserved.
//

import UIKit
import RxSwift
import Moya_Gloss
import RxDataSources

class ArticlesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var articlesRepository: NyTimesMostPopularRepository?
    var disposeBag: DisposeBag! = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articlesRepository?.mostViewed()
            .flatMap({ (response) -> Observable<[ArticleViewModel]> in
                let articlesResponse = try response.mapObject(ArticlesResponse.self)
            
                guard let articles = articlesResponse.results else {
                    return Observable.just([])
                }
            
                return Observable.just(articles)
            }).bind(to: self.tableView.rx.items(cellIdentifier: "ArticleCell")) {
                (index, article: ArticleViewModel, cell: ArticleTableViewCell) in
                    cell.bind(article: article)
            }.disposed(by: disposeBag)
    }
}

