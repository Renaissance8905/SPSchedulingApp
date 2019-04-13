//
//  APIClient.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/12/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

class APIClient {
    
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    func sendRequest<T: Codable>(_ request: Request, completion: @escaping ResultCompletion<T>) {
        
        do {
            
            let urlRequest = try request.urlRequest()
            
            session.dataTask(with: urlRequest) { [weak self] (data, response, error) in
                guard let `self` = self else { return }
                do {
                    
                    guard let data = data else {
                        throw error ?? ResponseError.noData
                    }
                    
                    let result = try self.decoder.decode(T.self, from: data)
                    
                    completion(.success(result))
                    
                } catch let error {
                    self.processError(error, for: completion)
                }
                
            }.resume()
            
        } catch let error {
            processError(error, for: completion)
        }
        
    }
    
    private func processError<T>(_ error: Error, for completion: @escaping ResultCompletion<T>) {
        switch error {
        case is APIClientError:
            completion(.requestFailure(error as? APIClientError))
        case is ResponseError:
            completion(.responseFailure(error as? ResponseError))
        case is DecodingError:
            completion(.responseFailure(.parsingError(error as? DecodingError)))
        default:
            completion(.responseFailure(.apiError(error)))
            
        }
        
    }
    
}




