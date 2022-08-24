//
//  SearchViewController.swift
//  Storyboard-learn
//
//  Created by Divya Aggarwal on 22/08/22.
//

import UIKit

class SearchViewController: UIViewController {
    private var titles:[Title] = [Title]()
    
    private let discoverTable:UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    private let serachController:UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Seatch for a Movie or a TV Show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.addSubview(discoverTable)
        discoverTable.delegate = self
        discoverTable.dataSource = self
        navigationItem.searchController = serachController
        navigationController?.navigationBar.tintColor = .black
        fetchDiscoverMovies()
        serachController.searchResultsUpdater = self
    }
    
    private func fetchDiscoverMovies(){
        ApiCaller.shared.getDiscoverMovies{[weak self] results in
            switch results{
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {[weak self] in
                    self?.discoverTable.reloadData()
                }
            case .failure(let error): print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
}

extension SearchViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier,for: indexPath) as? TitleTableViewCell else {return UITableViewCell()}
        let title = titles[indexPath.row]
        cell.configure(with: TitleViewModel(titleName: title.original_title ?? title.original_name ?? "Unknown", posterURL: title.poster_path ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else {return}
        DispatchQueue.main.async {[weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: TitlePreviewViewModel(title: titleName, titleOverview: title.overview ?? ""))
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension SearchViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty, query.trimmingCharacters(in: .whitespaces).count >= 3  else {return}
        
       guard let resultsController = searchController.searchResultsController as? SearchResultsViewController else {return}
        resultsController.delegate = self

        ApiCaller.shared.search(query: query){result in
            switch result{
            case .success(let movies): resultsController.titles = movies
                DispatchQueue.main.async {
                    resultsController.searchResults.reloadData()
                }
            case .failure(let error): print(error)
            }
        }
    }
}

extension SearchViewController:SearchResultsViewControllerDelegate{
    func SearchResultsViewControllerDidTapCell(_ viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async {[weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
