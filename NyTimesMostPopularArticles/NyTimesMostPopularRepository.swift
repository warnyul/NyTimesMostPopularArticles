//
//  NyTimesMostPopularRepository.swift
//  NyTimesMostPopularArticles
//
//  Created by Balázs Varga on 2017. 06. 29..
//  Copyright © 2017. Balazs Varga. All rights reserved.
//

import Foundation
import Moya
import Moya_Gloss
import RxSwift
import RxCocoa
import SwiftyBeaver

class NyTimesMostPopularRepository {
    
    private let api: RxMoyaProvider<NyTimesMostPopularArticlesApi>!
    private let log: SwiftyBeaver.Type! = SwiftyBeaver.self
    private var cache: Response? = nil
    var activityIndicator = ActivityIndicator()
    
    init(api: RxMoyaProvider<NyTimesMostPopularArticlesApi>!) {
        self.api = api
    }
    
    func mostViewed() -> Observable<[Article]> {
        if let cache = self.cache {
            return Observable.just(cache).flatMap {
                return try self.resolveArticles(response: $0)
            }
        }
        
        let request = api.request(.mostViewed(section: Section.allSections, timePeriod: TimePeriod.sevenDays))
        .do(onNext: { (response) in
            if (response.statusCode == 200) {
                self.cache = response
            }
        })
        
        return request.flatMap {
            return try self.resolveArticles(response: $0)
        }.trackActivity(activityIndicator)
    }
    
    func mostViewed(filter text: String) -> Observable<[Article]> {
        return self.mostViewed().map({
            $0.filter({ text.isEmpty || ($0.title?.contains(text))! || ($0.section?.contains(text))! || ($0.abstract?.contains(text))! })
        })
    }
    
    private func resolveArticles(response: Response!) throws -> Observable<Array<Article>> {
        
        guard response.statusCode == 200 else {
            return Observable.just([])
        }
        
        let articlesResponse = try response.mapObject(ArticlesResponse.self)
        
        guard let articles = articlesResponse.results else {
            return Observable.just([])
        }
        
        return Observable.just(articles)
    }

}
