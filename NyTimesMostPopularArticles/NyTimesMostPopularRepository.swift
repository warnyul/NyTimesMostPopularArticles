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
import SwiftyBeaver

class NyTimesMostPopularRepository {
    
    let api: RxMoyaProvider<NyTimesMostPopularArticlesApi>!
    let log: SwiftyBeaver.Type! = SwiftyBeaver.self
    
    init(api: RxMoyaProvider<NyTimesMostPopularArticlesApi>!) {
        self.api = api
    }
    
    func mostViewed() -> Observable<Response> {
        return api.request(.mostViewed(section: Section.allSections, timePeriod: TimePeriod.sevenDays))
    }

}
