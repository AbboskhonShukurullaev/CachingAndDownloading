//
//  ViewController.swift
//  CachingAndDownloading
//
//  Created by 1 on 23/11/21.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Constants
    let networker = NetworkManager.shared
    
    //MARK: - Properties and Variables
    var posts: [Post] = []
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNetwork()
    }

    //MARK: - Private Methods
    private func setupNetwork() {
        networker.posts(query: "canada") { [weak self] posts, error in
            if let error = error {
                print("Error: ", error)
                return
            }
            self?.posts = posts!
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }

}

//MARK: - Collection View Data Source
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        
        let post = posts[indexPath.item]
        cell.title = post.description
        
        cell.image = nil
        cell.badge = nil
        
        let representedIdentifier = post.id
        cell.representedIdentifier = representedIdentifier
        
        func image(data: Data?) -> UIImage? {
            if let data = data {
                return UIImage(data: data)
            }
            return UIImage(systemName: "picture")
        }
        
        networker.image(post: post) { data, error in
                let image = image(data: data)
            DispatchQueue.main.async {
                print(representedIdentifier, cell.representedIdentifier, representedIdentifier == cell.representedIdentifier)
                if cell.representedIdentifier == representedIdentifier {
                    cell.image = image
                }
                }
        }
        
        networker.profileImage(post: post) { data, error in
                let image = image(data: data)
            DispatchQueue.main.async {
                print(representedIdentifier, cell.representedIdentifier, representedIdentifier == cell.representedIdentifier)
                if cell.representedIdentifier == representedIdentifier {
                    cell.badge = image
                }
                }
            }
        
        return cell
    }
}

