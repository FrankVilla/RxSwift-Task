//
//  ArticlesSource.swift
//  RxSwiftAPIExample
//
//  Created by KOVIGROUP on 26/02/2022
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class ArticlesSource: UIViewController {
    
    // MARK: - implementation UI
    @IBOutlet weak var tblview: UITableView!
    private let apiClient = APIClient()
    private let disposeBag = DisposeBag()
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search Top Stories"
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureProperties()
        configureLayout()
        configureReactiveBinding()
    }
    
    // MARK: -- todo: write init for [cellIdentifiers]
    private func configureProperties() {
        
        tblview.register(UINib(nibName: CellName.articleTableviewCell, bundle: nil), forCellReuseIdentifier: CellName.articleTableviewCell)
        navigationItem.title = listViewName
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureLayout() {
        
        tblview.contentInset.bottom = view.safeAreaInsets.bottom
        tblview.estimatedRowHeight = 108.0
        tblview.rowHeight = UITableView.automaticDimension
    }
    
    private func configureReactiveBinding() {
        searchController.searchBar.rx.text.asObservable()
            .map { ($0 ?? "").lowercased() }
            .map { ArticleAPIRequest(name: $0) }
            .flatMap { request -> Observable<[ArticleModelData]> in
                return self.apiClient.send(apiRequest: request)
        }
        .bind(to: tblview.rx.items(cellIdentifier: CellName.articleTableviewCell, cellType: ArticleTableviewCell.self)) { row, viewModel, cell in
            cell.bind(viewModel)
        }.disposed(by: disposeBag)
        
        
        tblview.rx.modelSelected(ArticleModelData.self)
            .subscribe(onNext: { item in
                
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ArticlesDetailSource") as? ArticlesDetailSource
                vc!.articleModel = item
                self.navigationController?.pushViewController(vc!, animated: true)
                
            }).disposed(by: self.disposeBag)
        
    }

}
