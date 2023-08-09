//
//  MainViewController.swift
//  GrandCentralDispatchApp
//
//  Created by Zaki on 07.08.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private let nextPageButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setLayoutSubviews()
        stylize()
        setActions()
    
    }
    func addSubviews() {
        view.addSubview(nextPageButton)
    }
    
    func setLayoutSubviews() {
        var layoutConstraints: [NSLayoutConstraint] = []
        
        nextPageButton.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            nextPageButton.widthAnchor.constraint(equalToConstant: 150),
            nextPageButton.heightAnchor.constraint(equalToConstant: 40),
            nextPageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextPageButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(layoutConstraints)
        
    }
    
    func stylize() {
        view.backgroundColor = .white
        
        nextPageButton.setTitle("Next Page", for: .normal)
        nextPageButton.tintColor = .white
        nextPageButton.backgroundColor = .black
        nextPageButton.layer.cornerRadius = 12
    }
    
    func setActions() {
        nextPageButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc func buttonTapped() {
        print("Button tapped")
        let detailsVC = DetailsViewController()
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

