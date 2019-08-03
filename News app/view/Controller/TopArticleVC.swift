//
//  News app
//
//  Created by Hassan Mostafa on 8/1/19.
//  Copyright © 2019 Hassan Mostafa. All rights reserved.
//

import UIKit

class TopArticleVC: UICollectionViewController {
    // MARK:- Instance
    var viewModel = ArticleViewModel()
    // MARK:- Life cycle
    
    let spinner = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
        viewSetup()
        viewModel.fetchData()
        // after fetching data
        
        viewModel.articles.bind {_ in
            self.collectionView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    // MARK:- Setup
    func viewSetup(){
        view.backgroundColor = #colorLiteral(red: 0.08132412285, green: 0.1745293736, blue: 0.3156577349, alpha: 1)
        title = "Top Articles"
//        let filterButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(handleFilter))
        let filter = UIBarButtonItem(image: #imageLiteral(resourceName: "filter (1)"), style: .plain, target: self, action: #selector(handleFilter))
        filter.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationItem.rightBarButtonItem = filter
        
    }
    @objc func handleFilter() {
        
        let popupVC =  PopupViewController()
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.updateArticlesDelegate = self
        present(popupVC, animated: true, completion: nil)
    }
    
    func collectionViewSetup(){
        collectionView.backgroundColor = .clear
        //collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: IDs.articleCollectionCell.rawValue)
        collectionView.register(UINib(nibName: "NewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewsCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK:- Collectionview
extension TopArticleVC: UICollectionViewDelegateFlowLayout {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.articleCount
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IDs.articleCollectionCell.rawValue, for: indexPath) as! NewsCollectionViewCell
        
        cell.titleLabel.text = viewModel.updateTitle(for: indexPath.item)
        cell.imageView.downloadImageWithCache(stringUrl: viewModel.updateImage(for: indexPath.item))
        cell.dateLabel.text = viewModel.updateDate(for: indexPath.item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailArticleVC = DetailArticleVC()
        detailArticleVC.articleViewModel = viewModel
        detailArticleVC.indexPath = indexPath.item
        navigationController?.pushViewController(detailArticleVC, animated: true)
    }
}
// MARK:-  Recieve filtered data from popup
extension TopArticleVC: UpdateArticlesDelegate{
   
    func updateArticlesBySource(aricles: [Articles]) {
        self.viewModel.articles.value = aricles
    }
}
