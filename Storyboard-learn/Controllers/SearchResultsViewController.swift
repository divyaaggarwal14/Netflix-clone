//
//  SearchResultsViewController.swift
//  Storyboard-learn
//
//  Created by Divya Aggarwal on 23/08/22.
//

import UIKit

protocol SearchResultsViewControllerDelegate:AnyObject{
    func SearchResultsViewControllerDidTapCell(_ viewModel:TitlePreviewViewModel)
}

class SearchResultsViewController: UIViewController {
    public weak var delegate:SearchResultsViewControllerDelegate?
    public var titles:[Title] = [Title]()
    let searchResults:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3 - 10, height: 180)
        layout.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collection
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        view.addSubview(searchResults)
        searchResults.delegate = self
        searchResults.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResults.frame = view.bounds
    }
    
}


extension SearchResultsViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for:  indexPath) as? TitleCollectionViewCell else {return UICollectionViewCell()}
        let title = titles[indexPath.row]
        cell.configure(with:title.poster_path ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        delegate?.SearchResultsViewControllerDidTapCell(TitlePreviewViewModel(title: title.original_title ?? title.original_name ?? "", titleOverview: title.overview ?? ""))
    }
}
