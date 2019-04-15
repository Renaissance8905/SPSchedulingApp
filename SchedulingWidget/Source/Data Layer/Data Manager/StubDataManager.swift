//
//  StubDataManager.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/12/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

class StubDataManager: DataManager {
    
    func getServices(for clinician: Clinician, _ completion: @escaping ServicesCompletion) {
        do {
            completion(try parse(ServiceResponse.self, filename: "stubGetServices"))
            
        } catch let error {
            print(error)
            completion(nil)
            
        }
        
    }
    
    func getLocations(for clinician: Clinician, service: Service, _ completion: @escaping LocationsCompletion) {
        do {
            completion(try parse(LocationResponse.self, filename: "stubGetLocations"))
            
        } catch let error {
            print(error)
            completion(nil)
            
        }
        
    }
    
    private func parse<T: Response>(_ type: T.Type, filename: String) throws -> [T.DataType] {
        return  try decode(T.self, filename: filename).data
        
    }
    
    private func decode<T: Decodable>(_ type: T.Type, filename: String) throws -> T {
        return try JSONDecoder().decode(T.self, from: try data(from: filename))
        
    }
    
    private func data(from filename: String) throws -> Data {
        let path = Bundle.main.path(forResource: filename, ofType: "json")
        return try Data(contentsOf: URL(fileURLWithPath: path!, isDirectory: false))

    }
    
}
