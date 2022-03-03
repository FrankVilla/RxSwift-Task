//
//  ArticlesDetailSource.swift
//  RxSwiftAPIExample
//
//  Created by KOVIGROUP on 26/02/2022
//

import UIKit

class ArticlesDetailSource: UIViewController {
    
    var articleModel: ArticleModelData?
    
    // MARK: - implementation UI Decleration
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    
    // MARK: - implementation loadview
    override func viewDidLoad() {
        
        navigationItem.title = detailViewName
        
        lblTitle.text = articleModel?.title
        lblDescription.text = articleModel?.abstract
        lblAuthor.text = articleModel?.byline
        
        if ((articleModel?.multimedia!.count)! > 0)
        {
            let urlImage:MultimediaApiModel = (articleModel?.multimedia?.last)!
            if let strImage = urlImage.url
            {
                self.imageview?.kf.indicatorType = .activity
                self.imageview?.kf.setImage(with: URL(string: strImage))
            }
        }
        else
        {
            self.imageview.image = UIImage(named: imageName)
        }
        super.viewDidLoad()
    }
}
