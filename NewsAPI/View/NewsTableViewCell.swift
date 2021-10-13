//
//  NewsTableViewCell.swift
//  NewsAPI
//
//  Created by Андрей Маслов on 13.10.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell{

    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var descriptionNews: UILabel!
    @IBOutlet weak var imageNews: UIImageView!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//    }
    
    private var urlString: String = ""
    
    // Setup values
    
    func selCellWithValuesOf(_ article: Article) {
        updateUI(title: article.title, description: article.description,
                 imageUrl: article.urlToImage
        )
    }
    
    //Update VIEW-UI
    
    private func updateUI(title: String?, description: String?, imageUrl: String?
    ) {
        self.titleNews.text = title
        self.descriptionNews.text = description
        //self.imageNews.image = imageUrl
        
        guard let urlString = imageUrl else { return }
        
        guard let posterImageURL = URL(string: urlString) else { return }
        
        print("posterImageURL: \(posterImageURL)")
        
        //self.imageNews.image = nil
        
        getImageDataFrom(url: posterImageURL)
    }
    
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            print("======DATA======\(data)")
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    print("image: \(image)")
                    self.imageNews?.image = image
                }
            }
        }.resume()
    }

}
