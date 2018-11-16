//
//  PokemonsViewController.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 12/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import UIKit

protocol PokemonsVCProtocol {
    func reloadData()
    func present(viewController: UIViewController)
}

enum GridType: Int {
    case two
    case three
    case four
}

class PokemonsViewController: UIViewController {
    
    @IBOutlet weak var gridBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate let refreshControl = UIRefreshControl()
    fileprivate var gridType: GridType = .two {
        didSet {
            presenter.changeLimit(grid: gridType)
        }
    }
    fileprivate var presenter: PokemonsPresenterProtocol!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    //MARK: - Setup
    
    private func setup() {
        setupNavigation()
        setupPresenter()
        setupCollectioView()
        setupGrid()
    }
    
    private func setupNavigation() {
        title = "Pokemons"
    }
    
    private func setupPresenter() {
        presenter = PokemonsPresenter(view: self)
        presenter.loadPokemons()
    }
    
    private func setupCollectioView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PokemonCollectionViewCell.nib(),
                                forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier())
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    private func setupGrid() {
        gridType = .two
        collectionView.collectionViewLayout = TwoColumnFlowLayout()
        gridBarButtonItem.image = Constants.images.barItems.three
    }
    
    //MARK: - Actions
    
    @IBAction func gridDidTap(_ sender: Any) {
        let flowLayout: UICollectionViewLayout
        switch gridType {
        case .two:
            gridType = .three
            flowLayout = ThreeColumnFlowLayout()
            gridBarButtonItem.image = Constants.images.barItems.four
            break
        case .three:
            gridType = .four
            flowLayout = FourColumnFlowLayout()
            gridBarButtonItem.image = Constants.images.barItems.two
            break
        case .four:
            gridType = .two
            flowLayout = TwoColumnFlowLayout()
            gridBarButtonItem.image = Constants.images.barItems.three
            break
        }
        UIView.animate(withDuration: 1, delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 5,
                       options: .curveEaseOut,
                       animations: { [weak self] in
                        self?.collectionView.collectionViewLayout = flowLayout
            }, completion: nil)
    }
    
    @objc func pullToRefresh() {
        presenter.pullToRefresh()
    }
}

//MARK: - PokemonsVCProtocol

extension PokemonsViewController: PokemonsVCProtocol {
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func present(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension PokemonsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRows(inSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PokemonCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier(), for: indexPath) as! PokemonCollectionViewCell
        presenter.configurateCell(cell: cell, row: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectCell(row: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row > presenter.numberOfRows(inSection: indexPath.section)-presenter.limitCount() {
            presenter.loadMore()
        }
    }
}