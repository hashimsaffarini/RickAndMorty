//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Hashim Saffarini on 12/12/2025.
//

import UIKit

final class RMCharacterDetailViewController: UIViewController {
    private let viewModel : RMCharacterDetailViewViewModel
    
    init(viewModel : RMCharacterDetailViewViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }

}
