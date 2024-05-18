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
    
    var captionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupImageView()
        setupCaptionLabel()
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
    
    func setupCaptionLabel() {
        
        captionLabel = UILabel()
        captionLabel.text = caption
        captionLabel.font = .systemFont(ofSize: 24, weight: .heavy)
        captionLabel.numberOfLines = 3
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        captionLabel.textAlignment = .center
        captionLabel.sizeToFit()
        view.addSubview(captionLabel)
        
        NSLayoutConstraint.activate([
            captionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            captionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            captionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
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
            self?.captionLabel.text = typedCaption
            NotificationCenter.default.post(name: UIApplication.updateImageCaptions, object: nil, userInfo: ["caption": typedCaption])
        }
        ac.addAction(confirmChangeAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
}
