//
//  DetailViewController.swift
//  ImageCaptions
//
//  Created by Rodrigo Cavalcanti on 17/05/24.
//

import UIKit

class DetailViewController: UIViewController {
    var uiImage: UIImage!
    var caption: String!
    
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
        
        let changeButton = UIBarButtonItem(
            image: UIImage(systemName: "captions.bubble"),
            style: .plain,
            target: self,
            action: #selector(onChangeCaption)
        )
        
        navigationItem.rightBarButtonItem = changeButton
    }
    
    @objc func onChangeCaption() {
        let ac = UIAlertController(title: "Insert a new caption", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.view.tintColor = .accent
        ac.textFields?.first?.text = caption
        
        let confirmChangeAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let typedCaption = ac.textFields?.first?.text, !typedCaption.isEmpty else { return }
            self?.caption = typedCaption
        }
        ac.addAction(confirmChangeAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
}
