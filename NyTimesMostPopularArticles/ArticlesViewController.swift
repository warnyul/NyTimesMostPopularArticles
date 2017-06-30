//
//  ViewController.swift
//  NyTimesMostPopularArticles
//
//  Created by Balázs Varga on 2017. 06. 29..
//  Copyright © 2017. Balazs Varga. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Moya
import Moya_Gloss
import RxDataSources

class ArticlesViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var articlesRepository: NyTimesMostPopularRepository?
    var disposeBag: DisposeBag! = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.articlesRepository?
            .activityIndicator.asDriver().drive(onNext: { visible in
                self.activityIndicator.isHidden = !visible
            }).disposed(by: disposeBag)
        
        setupTableViewItemSelect()
        setupHideKeyboardOnTableViewScroll()
        setupSearchBar()
    }
    
    private func setupTableViewItemSelect() {
        tableView.rx.modelSelected(ArticleViewModel.self).asDriver().drive(onNext: { (article) in
            
            self.showArticlesDetails(article: article)
            
            if (self.searchBar.isFirstResponder) {
                self.searchBar.endEditing(true)
            }
            
        }).disposed(by: disposeBag)
    }
    
    private func showArticlesDetails(article: ArticleViewModel) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ArticleDetails") as! ArticleDetailsViewController
        
        vc.article = article
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    private func setupHideKeyboardOnTableViewScroll() {
        tableView.rx.contentOffset
            .asDriver()
            .drive(onNext: { _ in
                if self.searchBar.isFirstResponder {
                    _ = self.searchBar.resignFirstResponder()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupSearchBar() {
        searchBar.rx.text.orEmpty
            .asDriver()
            .throttle(0.3)
            .distinctUntilChanged()
            .flatMapLatest { text in
                (self.articlesRepository?.mostViewed(filter: text)
                    .startWith([])
                    .asDriver(onErrorJustReturn: []))!
                
            }.drive (self.tableView.rx.items(cellIdentifier: "ArticleCell")) {
                (index, article: ArticleViewModel, cell: ArticleTableViewCell) in
                cell.bind(article: article)
            }.disposed(by: disposeBag)
    }
}

