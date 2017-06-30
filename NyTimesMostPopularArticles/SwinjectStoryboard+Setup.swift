//
//  SwinjectStoryboard+Setup.swift
//  NyTimesMostPopularArticles
//
//  Created by Balázs Varga on 2017. 06. 29..
//  Copyright © 2017. Balazs Varga. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard
import Moya
import SwiftyBeaver

extension SwinjectStoryboard {
    class func setup() {
        
        defaultContainer.storyboardInitCompleted(ArticlesViewController.self) { (r, c) in
            c.articlesRepository = r.resolve(NyTimesMostPopularRepository.self)!
        }
        
        defaultContainer.register(NyTimesMostPopularRepository.self) { (r) in
            let provider = r.resolve(RxMoyaProvider<NyTimesMostPopularArticlesApi>.self)
            return NyTimesMostPopularRepository(api: provider)
        }.inObjectScope(.container)
        
        defaultContainer.register(RxMoyaProvider<NyTimesMostPopularArticlesApi>.self) { (r) in
            let logger = NetworkLoggerPlugin(verbose: true)
            return RxMoyaProvider<NyTimesMostPopularArticlesApi>(plugins: [logger])
        }.inObjectScope(.container)
    }
}
