//
//  ViewController.swift
//  ImageCaptions
//
//  Created by Rodrigo Cavalcanti on 17/05/24.
//

import UIKit

class ViewController: UITableViewController {
    var imageCaptions: [ImageCaption] = [] {
        didSet {
            saveImageCaptions()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        loadImageCaptions()
    }

    func setupNavBar() {
        title = "ImageCaptions"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAdd))
        navigationItem.rightBarButtonItem = addButton
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        imageCaptions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imageCaption = imageCaptions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CaptionCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.textProperties.numberOfLines = 1
        content.text = imageCaption.caption
        content.image = UIImage(contentsOfFile: getDocumentsDirectory().appendingPathComponent(imageCaption.imageName).path())
        content.imageProperties.maximumSize = CGSize(width: 125, height: 125)
        content.textProperties.color = .accent
        cell.contentConfiguration = content
        
        return cell
    }
}

// MARK: - Loading and Saving to UserDefaults and Document Directory
extension ViewController {
    func loadImageCaptions() {
        let defaults = UserDefaults.standard
        let jsonDecoder = JSONDecoder()
        guard let savedCaptions = defaults.object(forKey: "imageCaptions") as? Data,
              let loadedCaptions = try? jsonDecoder.decode([ImageCaption].self, from: savedCaptions) else { return }
        imageCaptions = loadedCaptions
    }
    
    func saveImageCaptions() {
        let defaults = UserDefaults.standard
        let jsonEncoder = JSONEncoder()
        
        guard let captionData = try? jsonEncoder.encode(imageCaptions) else { return }
        defaults.setValue(captionData, forKey: "imageCaptions")
    }
    
    func getDocumentsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}

// MARK: - ImagePicker
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func onAdd() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let imageCaption = ImageCaption(caption: "", imageName: imageName)
        imageCaptions.insert(imageCaption, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        dismiss(animated: true)
    }
}
