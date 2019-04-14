//
//  LocalDataManager.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/14/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

class LocalDataManager: DataManager {
    
    private var serviceStorage: [String: (Date, [Service])] = [:]
    private var locationStorage: [String: [String: (Date, [Location])]] = [:]
    private let cacheLifespan = 5.minutes
    
    private func isExpired(_ date: Date) -> Bool {
        return date + cacheLifespan < Date()
        
    }
    
    func getServices(for clinician: Clinician, _ completion: @escaping ServicesCompletion) {
        guard
            let (modified, services) = serviceStorage[clinician.id],
            !isExpired(modified),
            !services.isEmpty
            else { return completion(nil) }
        
        completion(services)
        
    }
    
    func getLocations(for clinician: Clinician, service: Service, _ completion: @escaping LocationsCompletion) {
        guard
            let (modified, locations) = locationStorage[clinician.id]?[service.id],
            !isExpired(modified),
            !locations.isEmpty
            else { return completion(nil) }
        
        completion(locations)
        
    }
    
    func updateServices(_ services: [Service], for clinician: Clinician) {
        serviceStorage[clinician.id] = (Date(), services)
        
    }
    
    func updateLocations(_ locations: [Location], for clinician: Clinician, service: Service) {
        var servicesForClinician = locationStorage[clinician.id] ?? [:]
        servicesForClinician[service.id] = (Date(), locations)
        locationStorage[clinician.id] = servicesForClinician
        
    }
    
}
