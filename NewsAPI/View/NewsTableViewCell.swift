//
//  NewsTableViewCell.swift
//  NewsAPI
//
//  Created by Андрей Маслов on 13.10.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var descriptionNews: UILabel!
    //@IBOutlet weak var imageNews: UIImageView!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    private var urlString: String = ""
    
    // Setup values
    
    func selCellWithValuesOf(_ article: Article) {
        updateUI(title: article.title, description: article.description
                 //image: article.urlToImage
        )
    }
    
    //Update VIEW-UI
    
    private func updateUI(title: String?, description: String? //image: URL?
    ) {
        self.titleNews.text = title
        self.descriptionNews.text = description
        //self.imageNews.image = image
    }

}
