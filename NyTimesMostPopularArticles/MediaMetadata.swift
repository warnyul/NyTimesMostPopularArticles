//
//  MediaMetadata.swift
//  NyTimesMostPopularArticles
//
//  Created by Balázs Varga on 2017. 06. 29..
//  Copyright © 2017. Balazs Varga. All rights reserved.
//

import Foundation
import Gloss

struct MediaMetadata : Decodable {
    var url: String?
    var format: String?
    var height: Int?
    var width: Int?
    
    init?(json: JSON) {
        self.url = "url" <~~ json
        self.format = "format" <~~ json
        self.height = "height" <~~ json
        self.width = "width" <~~ json
    }
}
