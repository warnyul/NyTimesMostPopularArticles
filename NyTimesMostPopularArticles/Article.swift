//
//  Article.swift
//  NyTimesMostPopularArticles
//
//  Created by Balázs Varga on 2017. 06. 29..
//  Copyright © 2017. Balazs Varga. All rights reserved.
//

import Foundation
import Gloss

struct Article : Decodable {
    var url: String?
    var countType: String?
    var column: String?
    var section: String?
    var byline: String?
    var title: String?
    var abstract: String?
    var publishedDate: String?
    var source: String?
    var desFacet: Array<String>?
    var orgFacet: Array<String>?
    var perFacet: Array<String>?
    var geoFacet: Array<String>?
    var media: Array<Media>?
    
    init?(json: JSON) {
        self.url = "url" <~~ json
        self.countType = "count_type" <~~ json
        self.column = "column" <~~ json
        self.section = "section" <~~ json
        self.byline = "byline" <~~ json
        self.title = "title" <~~ json
        self.abstract = "abstract" <~~ json
        self.publishedDate = "published_date" <~~ json
        self.source = "source" <~~ json
        self.desFacet = "des_facet" <~~ json
        self.desFacet = "org_facet" <~~ json
        self.desFacet = "per_facet" <~~ json
        self.desFacet = "geo_facet" <~~ json
        self.media = "media" <~~ json
    }
}
