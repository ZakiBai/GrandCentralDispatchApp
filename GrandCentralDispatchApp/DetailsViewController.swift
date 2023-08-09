//
//  DetailsViewController.swift
//  GrandCentralDispatchApp
//
//  Created by Zaki on 07.08.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private let imageView = UIImageView()
    private let activityIndicator = UIActivityIndicatorView()
    
    fileprivate var imageURl: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        } set {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setLayoutSubviews()
        stylize()
        setActions()
    }
    
    func addSubviews() {
        view.addSubview(imageView)
        imageView.addSubview(activityIndicator)
    }
    
    func setLayoutSubviews() {
        var layoutConstraints: [NSLayoutConstraint] = []
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        layoutConstraints += [
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(layoutConstraints)
    }
    
    func stylize() {
        view.backgroundColor = .white
        
        imageView.backgroundColor = .gray
    }
    
    func setActions() {
        fetchImage()
        delay(3) {
            self.addAlert()
        }
    }
    
    fileprivate func delay(_ delay: Int, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay), execute: closure)
    }
    
    fileprivate func addAlert() {
        let alertController = UIAlertController(title: "Registration", message: "If you are not registered yet, please register", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        alertController.addTextField { (usernameTF) in
            usernameTF.placeholder = "Enter your username"
        }
        
        alertController.addTextField { (passwordTF) in
            passwordTF.placeholder = "Enter your password"
            
        }
        
        self.present(alertController, animated: true)
    }
    
    fileprivate func fetchImage() {
        imageURl = URL(string: "https://images.squarespace-cdn.com/content/v1/58b4791ad2b857c893179e34/1537971642021-LHW76T7O8JG0M4GLTSTP/IMG_2818.jpg?format=500w")
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        let queue = DispatchQueue.global(qos: .utility)
        
        queue.async {
            guard let url = self.imageURl, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
}
