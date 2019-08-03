//
//  CollectionViewCell.swift
//  News app
//
//  Created by hossein shademany on 3/26/19.
//  Copyright © 2019 Hassan Mostafa. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    // MARK:- Varibles
    var cornerRadius: CGFloat = 8
    // MARK:- Components
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5658191143)
        view.layer.cornerRadius = cornerRadius
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    lazy var articleImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = cornerRadius
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let spinner: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()
    // MARK:- Life cyle
    override init(frame: CGRect) {
        super.init(frame: frame)
        spinner.startAnimating()
        
        constaintSetup()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadius).cgPath
        containerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        containerView.layer.shadowOffset = CGSize(width: 2, height: 2)
        containerView.layer.shadowRadius = 5
        containerView.layer.shadowOpacity = 1
    }
    // MARK:- Setup
    func constaintSetup(){
        addSubview(containerView)
        
        containerView.addSubview(spinner)
        containerView.addSubview(articleImageView)
        containerView.addSubview(bottomView)
        bottomView.addSubview(titleLbl)
        
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            spinner.safeAreaLayoutGuide.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            bottomView.heightAnchor.constraint(equalToConstant: 30),
            bottomView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            bottomView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            bottomView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            
            titleLbl.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 0),
            titleLbl.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: 0),
            titleLbl.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 0),
            
            articleImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            articleImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            articleImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            articleImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            
            ])
    }
}
