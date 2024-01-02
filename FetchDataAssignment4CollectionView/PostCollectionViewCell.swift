//
//  PostCollectionViewCell.swift
//  FetchDataAssignment4CollectionView
//
//  Created by Mac on 21/12/23.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userIdLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var bodyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
