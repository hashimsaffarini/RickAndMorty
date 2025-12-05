//
//  RMService.swift
//  RickAndMorty
//
//  Created by Hashim Saffarini on 05/12/2025.
//

final class RMService {
    static let shared = RMService()
    
    private init (){}
    
    public func execute<T: Codable>(_ request : RMRequest,expecting : T.Type , completion : @escaping (Result<T, Error>) -> Void){
        
    }
}
