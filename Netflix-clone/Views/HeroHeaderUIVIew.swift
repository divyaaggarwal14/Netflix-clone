//
//  HeroHeaderUIVIew.swift
//  Storyboard-learn
//
//  Created by Divya Aggarwal on 22/08/22.
//

import UIKit

class HeroHeaderUIVIew: UIView {
    private let playButton:UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let downloadButton:UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    
    private let heroImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        ApplyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    private func addGradient(){
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        layer.addSublayer(gradient)
        gradient.frame = bounds
    }
    
    private func ApplyConstraints(){
        let playButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 70),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -30),
            playButton.widthAnchor.constraint(equalToConstant: 110)
        ]
        let downloadButtonConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -70),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -30),
            downloadButton.widthAnchor.constraint(equalToConstant: 110)
        ]
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    
    
    public func configure(with model:TitleViewModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {return}
        heroImageView.sd_setImage(with: url,completed: nil)
    }
    
   
}
