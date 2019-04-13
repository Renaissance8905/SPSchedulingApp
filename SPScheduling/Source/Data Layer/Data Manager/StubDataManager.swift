//
//  StubDataManager.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/12/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

class StubDataManager: DataManager {
    
    func fetchServices(for clinician: Clinician, _ completion: @escaping ServiceCompletion) {
        do {
            let path = Bundle.main.path(forResource: "stubGetServices", ofType: "json")
            let data = try Data(contentsOf: URL(fileURLWithPath: path!, isDirectory: false))
            let response = try JSONDecoder().decode(ServiceResponse.self, from: data)
            completion(.success(response))
        } catch let error {
            print(error)
            return
        }
    }
    
    func fetchLocations(for clinician: Clinician, service: Service, _ completion: @escaping LocationCompletion) {
        do {
            let path = Bundle.main.path(forResource: "stubGetLocations", ofType: "json")
            let data = try Data(contentsOf: URL(fileURLWithPath: path!, isDirectory: false))
            let response = try JSONDecoder().decode(LocationResponse.self, from: data)
            completion(.success(response))
        } catch let error {
            print(error)
            return
        }
    }
    
    func fetchNext<T: Response>(_ response: T, completion: @escaping(Result<T>) -> ()) {
        
    }
    
    func fetchPrevious<T: Response>(_ response: T, completion: @escaping(Result<T>) -> ()) {
        
    }
    
}
