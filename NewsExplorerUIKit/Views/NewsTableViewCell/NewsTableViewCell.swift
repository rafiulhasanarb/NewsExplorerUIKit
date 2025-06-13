//
//  NewsTableViewCell.swift
//  NewsExplorerUIKit
//
//  Created by Rafiul Hasan on 6/13/25.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var publishedAtlabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureUI(with article: Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        publishedAtlabel.text = article.publishedAt
        contentLabel.text = article.content
        
        newsImageView.image = UIImage(systemName: "photo")
        if let urlString = article.urlToImage, let url = URL(string: urlString) {
            if let cachedImage = ImageCache.shared.getImage(for: urlString) {
                self.newsImageView.image = cachedImage
            } else {
                URLSession.shared.dataTask(with: url) { data, _, error in
                    guard let data = data else { return }
                    guard let image = UIImage(data: data) else { return }
                    ImageCache.shared.setImage(image, for: urlString)
                    DispatchQueue.main.async {
                        self.newsImageView.image = UIImage(data: data)
                    }
                }.resume()
            }
        }
    }
}
