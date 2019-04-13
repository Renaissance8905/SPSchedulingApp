//
//  DataManagerProtocol.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/12/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

typealias ServiceCompletion = ResultCompletion<ServiceResponse>
typealias LocationCompletion = ResultCompletion<LocationResponse>

protocol DataManager {
    
    func fetchServices(for clinician: Clinician, _ completion: @escaping ServiceCompletion)
    func fetchLocations(for clinician: Clinician, service: Service, _ completion: @escaping LocationCompletion)
    
    func fetchNext<T: Response>(_ response: T, completion: @escaping(Result<T>) -> ())
    func fetchPrevious<T: Response>(_ response: T, completion: @escaping(Result<T>) -> ())
    
}
