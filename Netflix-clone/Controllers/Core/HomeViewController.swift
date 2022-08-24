
import Foundation
import UIKit

enum Sections:Int{
    case TrendingMovies = 0
    case TrendingTV = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController:UIViewController{
    private var randomTrendingMovie:Title?
    private var headerView:HeroHeaderUIVIew?
    private let sectionTitles:[String] = ["Trending Movies","Trending TV","Popular","Upcoming Movies","Top rated"]
    
    private let homeFeedTable:UITableView = {
        let table = UITableView(frame: .zero,style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        configureNavigationBar()
        headerView = HeroHeaderUIVIew(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 390))
        homeFeedTable.tableHeaderView = headerView
        configureHeroHeaderView()
    }
    
    private func configureHeroHeaderView(){
        ApiCaller.shared.getTrendingMovies{[weak self] results in
            switch results{
            case .success(let movies):
                let selected = movies.randomElement()
                self?.randomTrendingMovie = selected
                self?.headerView?.configure(with: TitleViewModel(titleName:selected?.original_title ?? selected?.original_name ?? "" , posterURL: selected?.poster_path ?? ""))
            case .failure(let error): print(error)
            }
        }
    }
  
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func configureNavigationBar(){
        var image = UIImage(named:"logo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .black
    }
}


extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {return UITableViewCell()}
        cell.delegate = self
        switch indexPath.section{
        case Sections.TrendingMovies.rawValue:
            ApiCaller.shared.getTrendingMovies{ results in
                switch results{
                case .success(let movies): cell.configure(with: movies)
                case .failure(let error): print(error)
                }
            }
        case Sections.TrendingTV.rawValue:
            ApiCaller.shared.getTrendingTVs{ results in
                switch results{
                case .success(let tvs): cell.configure(with: tvs)
                case .failure(let error): print(error)
                }
            }
        case Sections.Popular.rawValue:
            ApiCaller.shared.getUpcomingMovies{ results in
                switch results{
                case .success(let movies): cell.configure(with: movies)
                case .failure(let error): print(error)
                }
            }
        case Sections.Upcoming.rawValue:
            ApiCaller.shared.getPopularMovies{ results in
                switch results{
                case .success(let movies):cell.configure(with: movies)
                case .failure(let error): print(error)
                }
            }
        case Sections.TopRated.rawValue:
            ApiCaller.shared.getTopRatedMovies{ results in
                switch results{
                case .success(let movies): cell.configure(with: movies)
                case .failure(let error): print(error)
                }
            }
        default: return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset =  view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y  + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 14,weight:.semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .black
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
}



extension HomeViewController:CollectionViewTableViewCellDelegate{
    func CollectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async {[weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
