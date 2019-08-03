//
//  DetailArticleVC.swift
//  News app
//
//  Created by Hassan Mostafa on 8/1/19.
//  Copyright © 2019 Hassan Mostafa. All rights reserved.
//

import UIKit

class DetailArticleVC: UIViewController {
    // MARK:- Component
    var articleImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "0017")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    var imageViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var contentLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let contentContinerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let contentContinerBackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.contentInsetAdjustmentBehavior = .never
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    var articleViewModel: ArticleViewModel!
    var indexPath: Int!
    // MARK:- Life cylce
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        constriantSetup()
        contentSetup()
    }

    // MARK:- Setup
    func contentSetup(){
        // as free acount we only get few lines of news so we duplicate it to get larger news!
        let text = articleViewModel.updateContent(for: indexPath)
        contentLbl.text = text + "\n" + text + text  + "\n" + text  + "\n" + text + text
        articleImageView.downloadImageWithCache(stringUrl: articleViewModel.updateImage(for: indexPath))
    }
    func constriantSetup(){
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageViewContainer)
        scrollView.addSubview(articleImageView)
        scrollView.addSubview(contentContinerBackView)
        scrollView.addSubview(contentContinerView)
        contentContinerView.addSubview(contentLbl)
        // for making image view bounce
        let topAnchor = articleImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        topAnchor.priority = UILayoutPriority.defaultHigh
        topAnchor.isActive = true
        articleImageView.leadingAnchor.constraint(equalTo: imageViewContainer.leadingAnchor, constant: 0).isActive = true
        articleImageView.trailingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor, constant: 0).isActive = true
        articleImageView.bottomAnchor.constraint(equalTo: imageViewContainer.bottomAnchor).isActive = true
        let height = articleImageView.heightAnchor.constraint(greaterThanOrEqualTo: imageViewContainer.heightAnchor)
        height.priority = .required
        height.isActive = true
        
        NSLayoutConstraint.activate([
            // scroll view
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            // image containerView
            imageViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            imageViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            imageViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            imageViewContainer.heightAnchor.constraint(equalTo: imageViewContainer.widthAnchor, multiplier: 0.75),
            // content container view
            contentContinerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentContinerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentContinerView.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 0),
            contentContinerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            // containerBackView
            contentContinerBackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentContinerBackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentContinerBackView.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 0),
            contentContinerBackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            // content label
            contentLbl.topAnchor.constraint(equalTo: contentContinerView.topAnchor, constant: 10),
            contentLbl.bottomAnchor.constraint(equalTo: contentContinerView.bottomAnchor, constant: 0),
            contentLbl.leadingAnchor.constraint(equalTo: contentContinerView.leadingAnchor, constant: 10),
            contentLbl.trailingAnchor.constraint(equalTo: contentContinerView.trailingAnchor, constant: -10),
            
            ])
    }
    func viewSetup(){
        // navigation
        title = articleViewModel.updateSource(for: indexPath)
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .white

        // scrollView
        scrollView.scrollIndicatorInsets = view.safeAreaInsets
        scrollView.contentInset = UIEdgeInsets(top: view.safeAreaInsets.top + 20, left: 0, bottom: view.safeAreaInsets.bottom + 40, right: 0)
        // view
        view.backgroundColor = #colorLiteral(red: 0.08132412285, green: 0.1745293736, blue: 0.3156577349, alpha: 1)
    }
}
