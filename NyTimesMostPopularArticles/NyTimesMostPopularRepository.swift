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

class NyTimesMostPopularRepository {
    
    let api: RxMoyaProvider<NyTimesMostPopularArticlesApi>!
    
    init(api: RxMoyaProvider<NyTimesMostPopularArticlesApi>!) {
        self.api = api
    }
    
    func mostViewed() -> Observable<ArticlesResponse> {
        return api.request(.mostViewed(section: Section.allSections, timePeriod: TimePeriod.sevenDays)).mapObject(type: ArticlesResponse.self)
    }

}
