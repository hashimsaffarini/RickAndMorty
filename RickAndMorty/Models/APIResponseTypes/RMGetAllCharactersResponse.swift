//
//  RMGetAllCharactersResponse.swift
//  RickAndMorty
//
//  Created by Hashim Saffarini on 05/12/2025.
//

import Foundation

struct RMGetAllCharactersResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }

    let info: Info
    let results: [RMCharacter]
}
