//
//  RemoteDataManager.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/12/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

class RemoteDataManager: DataManager {
    
    let apiClient: APIClient
    
    init(_ client: APIClient) {
        apiClient = client
    }
    
    func fetchServices(for clinician: Clinician, _ completion: @escaping ServiceCompletion) {
        apiClient.sendRequest(.services(clinician), completion: completion)
    }
    
    func fetchLocations(for clinician: Clinician, service: Service, _ completion: @escaping LocationCompletion) {
        apiClient.sendRequest(.locations(clinician, service), completion: completion)
    }
    
    func fetchNext<T: Response>(_ response: T, completion: @escaping(Result<T>) -> ()) {
        
    }
    
    func fetchPrevious<T: Response>(_ response: T, completion: @escaping(Result<T>) -> ()) {
        
    }
    
}
