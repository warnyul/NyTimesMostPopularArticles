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
        return media?.filter({$0.type == "image" && $0.mediaMetadata?.url != nil })
            .flatMap({ URL(string: ($0.mediaMetadata?.url)!)})
            .first
    }
}
