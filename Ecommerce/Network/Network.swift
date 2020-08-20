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
    let baseURL = URL(string: Constants.baseURLString)!
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
            var genericError = "Unknown Error"
            if let error = error { completion(.failure(error)) }
            else if let data = data{
                if let json = (try? JSONSerialization.jsonObject(with: data, options: [.allowFragments])) as? [String:AnyObject] {
                    // try to read out a string array
                    DispatchQueue.main.async { 
                        completion(.success(Model.init(json,persistent)))
                    }
                    return
                }
                genericError = "Parsing Error"
            }
            let error = NSError(domain:"", code:404, userInfo:[ NSLocalizedDescriptionKey: genericError]) as Error
            completion(.failure(error))
        }.resume()
    }
}





