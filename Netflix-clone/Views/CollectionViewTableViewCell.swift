//
//  CollectionViewTableViewCell.swift
//  Storyboard-learn
//
//  Created by Divya Aggarwal on 22/08/22.
//

import UIKit


protocol CollectionViewTableViewCellDelegate:AnyObject{
    func CollectionViewTableViewCellDidTapCell(_ cell:CollectionViewTableViewCell,viewModel:TitlePreviewViewModel)
}
class CollectionViewTableViewCell: UITableViewCell {
    static let identifier = "CollectionViewTableViewCell"
    private var titles:[Title] = [Title]()
    weak var delegate:CollectionViewTableViewCellDelegate?
    private let collectionView: UICollectionView = {
        let layout  = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier:TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with titles:[Title]){
        self.titles = titles
        DispatchQueue.main.async {[weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func downloadTitleAt(indexPath:IndexPath){
        DataPersistenceManager.shared.downloadTitleWith(model: titles[indexPath.row]){ result in
            switch result{
            case .success(): NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
            case .failure(let error):print("error",error.localizedDescription)
            }
        }
    }
}

extension CollectionViewTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {return UICollectionViewCell()}
        guard let poster_path = titles[indexPath.row].poster_path else {return UICollectionViewCell()}
        cell.configure(with: poster_path)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else {return}
        delegate?.CollectionViewTableViewCellDidTapCell(self, viewModel: TitlePreviewViewModel(title: titleName, titleOverview: title.overview ?? ""))
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil){_ in
            let downloadAction = UIAction(title: "Download", image: nil, identifier: nil, discoverabilityTitle: nil, state: .off){[weak self] _ in
                self?.downloadTitleAt(indexPath: indexPath)
            }
            return UIMenu(title: "", subtitle: nil, image: nil, identifier: nil, options: .displayInline, children:[downloadAction] )
        }
        return config
    }
}
