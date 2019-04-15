//
//  DataManagerProtocol.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/12/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

typealias ServicesCompletion = ([Service]?) -> Void
typealias LocationsCompletion = ([Location]?) -> Void

protocol DataManager {
    
    func getServices(for clinician: Clinician, _ completion: @escaping ServicesCompletion)
    func getLocations(for clinician: Clinician, service: Service, _ completion: @escaping LocationsCompletion)
    
    func updateServices(_ services: [Service], for clinician: Clinician)
    func updateLocations(_ locations: [Location], for clinician: Clinician, service: Service)

}

extension DataManager {

    // Empty convenience implementations; not all versions of DM will be updatable
    func updateServices(_ services: [Service], for clinician: Clinician) {}
    func updateLocations(_ locations: [Location], for clinician: Clinician, service: Service) {}

}
