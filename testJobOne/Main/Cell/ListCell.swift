//
//  ListCell.swift
//  testJobOne
//
//  Created by Tauã on 19/03/20.
//  Copyright © 2020 Tauã. All rights reserved.
//

import UIKit
import Kingfisher

class ListCell: UITableViewCell {
    
    static var idCell = "idListCell"
    static var nameCell = "ListCell"
    
    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var labeDescription: UILabel!
    @IBOutlet weak var star: UILabel!
    @IBOutlet weak var store: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    func setup(data: ListModel.Item) {
        selectionStyle = .none
        
        imgUser.setRounded()
        
        labeDescription.text = data.description
        name.text = data.name
        store.text = data.open_issues?.description
        star.text = data.stargazers_count?.description
        userName.text = data.owner?.login
        
        if let image = data.owner?.avatar_url {
            let urlImage : String = image
            let url = URL(string: urlImage)
            
            imgUser.kf.indicatorType = .activity
            imgUser.kf.setImage(with: url)
        }
        
    }
    
    
}
