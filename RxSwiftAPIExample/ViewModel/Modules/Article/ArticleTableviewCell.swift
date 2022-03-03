//
//  ArticleTableviewCell.swift
//  RxSwiftAPIExample
//
//  Created by KOVIGROUP on 26/02/2022
//

import Foundation
import UIKit

class ArticleTableviewCell: UITableViewCell{
    
    @IBOutlet weak var imageArticle: UIImageView!
    @IBOutlet weak var lblArticleTitle: UILabel!
    @IBOutlet weak var lblArticleAuthor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func bind(_ viewModel:ArticleModelData) {
        
        self.lblArticleTitle?.text = viewModel.title
        self.lblArticleAuthor?.text = viewModel.abstract
        
        self.lblArticleAuthor?.adjustsFontSizeToFitWidth = true
        
        if (viewModel.multimedia!.count > 0)
        {
            let urlImage:MultimediaApiModel = (viewModel.multimedia?.first)!
            if let strImage = urlImage.url
            {
                self.imageArticle?.kf.indicatorType = .activity
                self.imageArticle?.kf.setImage(with: URL(string: strImage))
            }
        }
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        layer.backgroundColor = UIColor.clear.cgColor
    }
  
}
