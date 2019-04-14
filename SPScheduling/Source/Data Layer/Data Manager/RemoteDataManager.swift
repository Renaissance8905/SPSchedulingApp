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
    
    func getServices(for clinician: Clinician, _ completion: @escaping ServicesCompletion) {
        
        fetchServices(for: clinician) { (result) in
            
            switch result {
            case .success(let response):
                completion(response.data)
                
            default:
                // FUTURE: more refined error-handling could happen here
                completion(nil)
                
            }
            
        }
        
    }
    
    func getLocations(for clinician: Clinician, service: Service, _ completion: @escaping LocationsCompletion) {
        
        fetchLocations(for: clinician, service: service) { (result) in
            
            switch result {
            case .success(let response):
                completion(response.data)
                
            default:
                // FUTURE: more refined error-handling could happen here
                completion(nil)
                
            }
            
        }
        
    }
    
    private func fetchServices(for clinician: Clinician, _ completion: @escaping ResultCompletion<ServiceResponse>) {
        apiClient.sendRequest(.services(clinician), completion: completion)
        
    }
    
    private func fetchLocations(for clinician: Clinician, service: Service, _ completion: @escaping ResultCompletion<LocationResponse>) {
        apiClient.sendRequest(.locations(clinician, service), completion: completion)
        
    }
    
}
