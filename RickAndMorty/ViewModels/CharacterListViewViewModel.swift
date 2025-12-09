//
//  CharacterListViewViewModel.swift.swift
//  RickAndMorty
//
//  Created by Hashim Saffarini on 08/12/2025.
//

import UIKit

protocol CharacterListViewViewModelDelegate : AnyObject {
    func didLoadInitialCharacters()
}

final class CharacterListViewViewModel  : NSObject {
    
    public weak var delegate: CharacterListViewViewModelDelegate?
    
    private var characters: [RMCharacter] = [] {
           didSet {
               for character in characters {
                   let viewModel = RMCharacterCollectionViewCellViewModel(
                       characterName: character.name,
                       characterStatus: character.status,
                       characterImageUrl: URL(string: character.image)
                   )
                   cellViewModels.append(viewModel)
               }
           }
       }

       private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
    
    func fetchCharacters() {
        RMService.shared.execute(.listCharactersRequests, expecting : RMGetAllCharactersResponse.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let result = responseModel.results
                self?.characters = result
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension CharacterListViewViewModel : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath) as! RMCharacterCollectionViewCell
        
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 30) / 2
        return CGSize(width: width, height: width * 1.5)

    }
}
