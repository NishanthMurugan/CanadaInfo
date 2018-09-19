//
//  APIManager.swift
//  Canada Special
//
//  Created by Nishanth Murugan on 19/09/18.
//  Copyright © 2018 WIPRO. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    private static let APIUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    
    public class func makeApiCall(completionHandler: @escaping (Result<InfoModel>)->Void)  {
        Alamofire.request(APIUrl).responseString { (response) in
            switch response.result {
            case .success:
                let data = response.result.value!.data(using: .utf8)
                let responseModel = APIManager.jsonSerialization(data: data!)
                completionHandler(.success(responseModel))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    public class func jsonSerialization(data :Data) -> InfoModel {
        let decoder = JSONDecoder()
        return try! decoder.decode(InfoModel.self, from: data)
    }
    
    public class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
}
