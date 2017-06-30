//
//  ArticleDetailsViewController.swift
//  NyTimesMostPopularArticles
//
//  Created by Balázs Varga on 2017. 06. 30..
//  Copyright © 2017. Balazs Varga. All rights reserved.
//

import UIKit
import RxSwift

class ArticleDetailsViewController : UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var article: ArticleViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let article = article {
           loadArticle(article: article)
        }
    }
    
    private func loadArticle(article: ArticleViewModel!) {
        guard let urlString = article.url else {
            return
        }
        
        let request = URLRequest(url: URL(string: urlString)!)
        self.webView.loadRequest(request)
    }
}
