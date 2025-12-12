//
//  CharacterListViewViewModel.swift.swift
//  RickAndMorty
//
//  Created by Hashim Saffarini on 08/12/2025.
//

import UIKit

protocol CharacterListViewViewModelDelegate : AnyObject {
    func didLoadInitialCharacters()
    func didSelectCharacter(_ character : RMCharacter)
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
    private var apiInfo : RMGetAllCharactersResponse.Info? = nil
    
    func fetchCharacters() {
        RMService.shared.execute(.listCharactersRequests, expecting : RMGetAllCharactersResponse.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let result = responseModel.results
                self?.characters = result
                let info = responseModel.info
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func fetchAdditionalCharacters() {
        
    }
    
    private var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
}


extension CharacterListViewViewModel : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator else { return }
        
    }
}
