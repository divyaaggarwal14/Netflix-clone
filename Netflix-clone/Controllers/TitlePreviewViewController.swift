//
//  TitlePreviewViewController.swift
//  Storyboard-learn
//
//  Created by Divya Aggarwal on 23/08/22.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    private let label:UILabel = {
      let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize:18,weight:.bold)
        label.text = "Harry Porter"
        return label
    }()
    
    private let overViewLabel:UILabel = {
      let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize:13,weight:.regular)
        label.numberOfLines = 0
        label.text = "This is the best movie to watch as a kid."
        return label
    }()
    
    private let downloadButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let webview:WKWebView = {
        let view = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webview)
        view.addSubview(label)
        view.addSubview(overViewLabel)
        view.addSubview(downloadButton)
        
        configureConstraints()
    }
    
    func configure(with model:TitlePreviewViewModel){
        label.text = model.title
        overViewLabel.text = model.titleOverview
        guard let url = URL(string: "https://www.youtube.com/watch?v=9xwazD5SyVg") else {return}
        webview.load(URLRequest(url: url))
    }
    
    private func  configureConstraints(){
        let webviewConstraints = [
            webview.topAnchor.constraint(equalTo: view.topAnchor,constant: 80),
            webview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webview.heightAnchor.constraint(equalToConstant: 350)
        ]
        
        let labelConstraints = [
            label.topAnchor.constraint(equalTo: webview.bottomAnchor,constant: 20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
        ]
        
        let overViewLabelConstraints = [
            overViewLabel.topAnchor.constraint(equalTo: label.bottomAnchor,constant:15),
            overViewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            overViewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20)
        ]
        
        let  downloadButtonConstraints = [
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: overViewLabel.bottomAnchor,constant: 25),
            downloadButton.widthAnchor.constraint(equalToConstant: 120),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(webviewConstraints)
        NSLayoutConstraint.activate(labelConstraints)
        NSLayoutConstraint.activate(overViewLabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
        
    }
}
