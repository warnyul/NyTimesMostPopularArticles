//
//  ArticleTableViewCell.swift
//  NyTimesMostPopularArticles
//
//  Created by Balázs Varga on 2017. 06. 29..
//  Copyright © 2017. Balazs Varga. All rights reserved.
//

import UIKit
import AlamofireImage

class ArticleTableViewCell : UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var byline: UILabel!
    @IBOutlet weak var byline2: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    private var article: ArticleViewModel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        articleImage.layer.cornerRadius = articleImage.frame.width / 2.0

    }
    
    func bind(article: ArticleViewModel!) {
        self.article = article
        title.text = article.title
        byline.text = article.byline
        
        // TODO calculate truncated text
        byline2.text = nil
        date.text = article.publishedDate
        
        if let imageUrl = article.imageURL {
            self.articleImage.af_setImage(withURL: imageUrl)
        }
    }
    
    private func isTruncated(label: UILabel!) -> Bool {
        let textBounds = label.textRect(forBounds: self.bounds, limitedToNumberOfLines: 1)
        return textBounds.width >= label.bounds.width;
    }
}
