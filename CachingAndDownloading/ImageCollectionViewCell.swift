//
//  ImageCollectionViewCell.swift
//  CachingAndDownloading
//
//  Created by 1 on 23/11/21.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var badgeImageView: UIImageView!
    
    var representedIdentifier: String = ""
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var badge: UIImage? {
        didSet {
            badgeImageView.image = badge
        }
    }
}
