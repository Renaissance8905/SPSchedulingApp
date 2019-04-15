//
//  HybridDataManager.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/14/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

//
// In most cases, this is the Data Manager that will actually be used
// It fetches/stores no data directly, but rather curates interaction
// between local and remote Data Managers.
//
// The general pattern for this is:
//
//  1)  Check the local manager for non-stale data
//  2a) If present, return local data
//  2b) Else if needed, ask the remote manager for fresh data
//  3)  Give the results to the local manager for storage
//  4)  Return results to the consumer
//
class HybridDataManager: DataManager {
    
    private let remote: DataManager
    private let local: DataManager?
    
    init(_ apiClient: APIClient) {
        remote = RemoteDataManager(apiClient)
        local = LocalDataManager()
    }
    
    func getServices(for clinician: Clinician, _ completion: @escaping ServicesCompletion) {
        
        guard let local = local else {
            return remote.getServices(for: clinician, completion)
            
        }
        
        local.getServices(for: clinician) { (cached) in
            if let cached = cached {
                return completion(cached)
            }
            
            self.remote.getServices(for: clinician) { (services) in
                completion(services)
                self.updateServices(services, for: clinician)
                
            }
            
        }
        
    }
    
    func getLocations(for clinician: Clinician, service: Service, _ completion: @escaping LocationsCompletion) {
        
        guard let local = local else {
            return remote.getLocations(for: clinician, service: service, completion)
            
        }
        
        local.getLocations(for: clinician, service: service) { (cached) in
            if let cached = cached {
                return completion(cached)
            }
            
            self.remote.getLocations(for: clinician, service: service) { (locations) in
                completion(locations)
                self.updateLocations(locations, for: clinician, service: service)
                
            }
            
        }
        
    }
    
    func updateServices(_ services: [Service]?, for clinician: Clinician) {
        guard let services = services else { return }
        local?.updateServices(services, for: clinician)
        
    }
    
    func updateLocations(_ locations: [Location]?, for clinician: Clinician, service: Service) {
        guard let locations = locations else { return }
        local?.updateLocations(locations, for: clinician, service: service)
        
    }
    
}
