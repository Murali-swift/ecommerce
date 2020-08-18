//
//  Network.swift
//  Ecommerce
//
//  Created by Murali on 17/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import Foundation

protocol Fetchable {
    static var apiBase: String { get }
}

struct Client {
    let session: URLSession
    let baseURL = URL(string: Constants.baseURLString ?? "")!
    init(session: URLSession) {
        self.session = session
    }
}

extension Client {
    
    func fetch<Model: Fetchable & JSONINitializer>(
        _: Model.Type, persistent:StoreDataLocally,
        completion: @escaping (Result<Model, Error>) -> Void)
    {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(Model.apiBase))
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error { completion(.failure(error)) }
            else if let data = data{
                if let json = (try? JSONSerialization.jsonObject(with: data, options: [.allowFragments])) as? [String:AnyObject] {
                    // try to read out a string array
                    
                    completion(.success(Model.init(json,persistent)))
                }
                let error = NSError(domain:"", code:404, userInfo:[ NSLocalizedDescriptionKey: "Parsing Error"]) as Error
                completion(.failure(error))
            }else {
                let error = NSError(domain:"", code:404, userInfo:[ NSLocalizedDescriptionKey: "Unknown Error"]) as Error
                completion(.failure(error))
            }
        }.resume()
    }
}

extension Categories: Fetchable {
    static var apiBase: String { return "b/5f3b6155b88c04101cf62ba5" }
}

protocol JSONINitializer {
    init(_ json:Dictionary<String, Any>,_ persistent: StoreDataLocally)
}

extension Categories: JSONINitializer{
    
}


