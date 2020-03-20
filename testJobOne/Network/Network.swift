//
//  Network.swift
//  testJobOne
//
//  Created by Tauã on 19/03/20.
//  Copyright © 2020 Tauã. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class NetWork {
    
    let networkQueue = DispatchQueue(label: "com.appName.networkQueue")
    static var url: String = "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1"
    
    enum GetFailureReason: Int, Error {
        case unAuthorized = 401
        case notFound = 404
    }
    
    typealias GetResult = Result<[ListModel]>
    typealias GetCompletion = (_ result: GetResult) -> Void
    
    static func getList() -> Observable<[ListModel.Item]> {
        
        return Observable.create { observer -> Disposable in
            
            Alamofire.request(url, method: .get, parameters: nil).responseObject { (response: DataResponse<ListModel>) in
                
                switch response.result {
                case .success:
                    let dataResponse: ListModel = response.result.value ?? ListModel()
                    observer.onNext(dataResponse.results ?? [ListModel.Item()])
                case .failure(let error):
                    observer.onError(error)
                }
            }
        
            return Disposables.create()
            
        }
        
    }
    
}
