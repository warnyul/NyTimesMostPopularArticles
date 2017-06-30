//
//  ArticlesResponse.swift
//  NyTimesMostPopularArticles
//
//  Created by Balázs Varga on 2017. 06. 29..
//  Copyright © 2017. Balazs Varga. All rights reserved.
//

import Foundation
import Gloss

struct ArticlesResponse : Decodable {
    var status: String?
    var copyright: String?
    var numResults: Int?
    var results: Array<Article>?
    
    init?(json: JSON) {
        self.status = "status" <~~ json
        self.copyright = "copyright" <~~ json
        self.numResults = "num_results" <~~ json
        self.results = "results" <~~ json
    }

}
