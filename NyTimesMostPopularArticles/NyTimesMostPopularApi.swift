//
//  MostViewedArticlesApi.swift
//  NyTimesMostPopularArticles
//
//  Created by Balázs Varga on 2017. 06. 29..
//  Copyright © 2017. Balazs Varga. All rights reserved.
//

import Foundation
import Moya

enum NyTimesMostPopularApi {
    case mostViewed(section: Section, timePeriod: TimePeriod)
}

extension NyTimesMostPopularApi : TargetType {
    
    var baseURL: URL { return URL(string: "http://api.nytimes.com/svc/mostpopular/v2")! }
    
    var path: String {
        switch self {
        case let .mostViewed(section, timePeriod):
            // TODO api key
            return "/mostviewed/\(section)/\(timePeriod).json?api-key={apikey}"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String: Any]? { return nil }
    
    var parameterEncoding: ParameterEncoding { return JSONEncoding.default }
    
    var sampleData: Data {
        switch self {
        case .mostViewed(_):
            return stubbedResponse("most_popular_articles")
        }
    }
    
    var task: Task { return .request }
}

fileprivate func stubbedResponse(_ filename: String) -> Data! {
    let bundle = Bundle.main
    let path = bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}
