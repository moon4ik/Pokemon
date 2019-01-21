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
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var gridBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noDataLabel: UILabel!
    fileprivate let refreshControl = UIRefreshControl()
    fileprivate var gridType: GridType = .two {
        didSet {
            presenter.changeLimit(grid: gridType)
        }
    }
    fileprivate var presenter: PokemonsPresenterProtocol!
    fileprivate var isWating = false
    
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
        setupSearchBar()
    }
    
    private func setupNavigation() {
        title = "Pokemons"
    }
    
    private func setupPresenter() {
        presenter = PokemonsPresenter(view: self)
        activityIndicator.startAnimating()
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
    
    private func setupSearchBar() {
        searchBar.delegate = self
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
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.collectionViewLayout.invalidateLayout()
        self.collectionView.setContentOffset(.zero, animated: true)
//        UIView.animate(withDuration: 1, delay: 0,
//                       usingSpringWithDamping: 0.8,
//                       initialSpringVelocity: 5,
//                       options: .curveEaseOut,
//                       animations: { [weak self] in
//                        self?.collectionView.collectionViewLayout = flowLayout
//            }, completion: nil)
    }
    
    @objc func pullToRefresh() {
        view.endEditing(true)
        searchBar.text = ""
        presenter.filter(searchText: "")
        noDataLabel.isHidden = true
        presenter.pullToRefresh()
    }
}

//MARK: - PokemonsVCProtocol

extension PokemonsViewController: PokemonsVCProtocol {
    
    func reloadData() {
        if activityIndicator.isAnimating {
            activityIndicator.stopAnimating()
        }
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
        collectionView.reloadData()
        isWating = false
    }
    
    func present(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension PokemonsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let rowsCount = presenter.numberOfRows(inSection: section)
        noDataLabel.isHidden = !((rowsCount == 0) && presenter.isFiltered())
        return rowsCount
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
        if indexPath.row > presenter.numberOfRows(inSection: indexPath.section)-4 && !isWating{
            isWating = true
            presenter.loadPokemons()
        }
    }
}

extension PokemonsViewController: UISearchBarDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
 
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        presenter.filter(searchText: "")
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, !text.isEmpty {
            presenter.filter(searchText: text)
            view.endEditing(true)
        } else {
            
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text.isEmpty {
            presenter.filter(searchText: "")
            view.endEditing(true)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.isEmpty) {
            presenter.filter(searchText: "")
        }
    }
}
