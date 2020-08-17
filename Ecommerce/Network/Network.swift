//
//  Network.swift
//  Ecommerce
//
//  Created by Murali on 17/08/20.
//  Copyright © 2020 Murali. All rights reserved.
//

import Foundation
let baseURL = URL(string: "​https://stark-spire-93433.herokuapp.com​/")!

protocol Fetchable: Decodable {
    static var apiBase: String { get }
}

struct Client {
    let session: URLSession
    init(session: URLSession) {
        self.session = session
    }
}

extension Client {
    
    func fetch<Model: Fetchable>(
        _: Model.Type,
        completion: @escaping (Result<Model, Error>) -> Void)
    {
        let urlRequest = URLRequest(url: baseURL
            .appendingPathComponent(Model.apiBase))
        
        session.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error { completion(.failure(error)) }
            else if let data = data,let model = try? JSONDecoder().decode(Model.self,from: data){
                completion(.success(model))
            }else {
                let error = NSError(domain:"", code:404, userInfo:[ NSLocalizedDescriptionKey: "Parsing Error"]) as Error
                completion(.failure(error))
            }
        }.resume()
    }
}

extension Category: Fetchable {
    static var apiBase: String { return "json" }
}


