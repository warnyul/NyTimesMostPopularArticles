//
//  ArticleViewModel.swift
//  NyTimesMostPopularArticles
//
//  Created by Balázs Varga on 2017. 06. 29..
//  Copyright © 2017. Balazs Varga. All rights reserved.
//

import Foundation

protocol ArticleViewModel {
    var title: String? { get }
    var byline: String? { get }
    var publishedDate: String? { get }
    var imageURL: URL? { get }
    var url: String? { get }
}

extension Article : ArticleViewModel {
    var imageURL: URL? {
        
        let metadata = self.media?
            .first?
            .mediaMetadata?
            .first
            
        if let urlString = metadata?.url {
            return URL(string: urlString)
        }
        return nil
    }
}
