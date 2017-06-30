//
//  Media.swift
//  NyTimesMostPopularArticles
//
//  Created by Balázs Varga on 2017. 06. 29..
//  Copyright © 2017. Balazs Varga. All rights reserved.
//

import Foundation
import Gloss

struct Media : Decodable {
    var type: String?
    var subtype: String?
    var caption: String?
    var copyright: String?
    var mediaMetadata: Array<MediaMetadata>?
    
    init?(json: JSON) {
        self.type = "type" <~~ json
        self.subtype = "subtype" <~~ json
        self.caption = "caption" <~~ json
        self.copyright = "copyright" <~~ json
        self.mediaMetadata = "media-metadata" <~~ json
    }
}
