//
//  DetailViewController.swift
//  ImageCaptions
//
//  Created by Rodrigo Cavalcanti on 17/05/24.
//

import UIKit

class DetailViewController: UIViewController {
    var uiImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        setupNavBar()
    }
    
    func setupImageView() {
        view.backgroundColor = .systemBackground
        let imageView = UIImageView(image: uiImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupNavBar() {
        navigationItem.largeTitleDisplayMode = .never
        title = "Image Details"
    }
}
