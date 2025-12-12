//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Hashim Saffarini on 12/12/2025.
//

final class RMCharacterDetailViewViewModel {
    
    private let character: RMCharacter
    
    init(character: RMCharacter){
        self.character = character
    }
    
    public var title : String {
        character.name.uppercased()
    }
}
