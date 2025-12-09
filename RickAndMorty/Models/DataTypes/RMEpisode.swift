//
//  RMEpisode.swift
//  RickAndMorty
//
//  Created by Hashim Saffarini on 02/12/2025.
//

import Foundation

struct RMEpisode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
