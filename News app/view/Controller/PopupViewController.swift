//
//  PopupViewController.swift
//  News app
//
//  Created by Hassan Mostafa on 7/31/19.
//  Copyright © 2019 Hassan Mostafa . All rights reserved.
//

import UIKit
import SwiftMessages

protocol UpdateArticlesDelegate {
    func updateArticlesBySource(aricles: [Articles])
}
class PopupViewController: UIViewController {
    
    
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var selectCountryBtn: UIButton!
    @IBOutlet weak var newsSourceBtn: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    let filterViewModel = FilterViewModel()
    var updateArticlesDelegate: UpdateArticlesDelegate?
    
    var sourceId: String!
    var isFilteredByCompany = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.backgroundColor = #colorLiteral(red: 0.08310671896, green: 0.1732590795, blue: 0.3181556463, alpha: 1)
        setupButton(buttons: [selectCountryBtn, newsSourceBtn, filterBtn])
    }
    // MARK: - Error message when click on filter button with out select counter or news source
    func displayMessage(message: String, messageError: Bool) {
        
        let view = MessageView.viewFromNib(layout: MessageView.Layout.messageView)
        if messageError == true {
            view.configureTheme(.error)
        } else {
            view.configureTheme(.success)
        }
        
        view.iconImageView?.isHidden = true
        view.iconLabel?.isHidden = true
        view.titleLabel?.isHidden = true
        view.bodyLabel?.text = message
        view.titleLabel?.textColor = UIColor.white
        view.bodyLabel?.textColor = UIColor.white
        view.button?.isHidden = true
        
        var config = SwiftMessages.Config()
        config.presentationStyle = .bottom
        SwiftMessages.show(config: config, view: view)
    }
    fileprivate func setupButton(buttons: [UIButton]) {
        for btn in buttons {
            btn.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            btn.layer.cornerRadius = 10
        }
    }
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    // MARK:- action on news source button
    @IBAction func newsSourceButton(_ sender: UIButton) {
        isFilteredByCompany = false
        selectCountryBtn.isEnabled = isFilteredByCompany ? true : false
        selectCountryBtn.backgroundColor = isFilteredByCompany ?  #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1): #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        let sourcesNCountryVC = SorcesAndCountriesTableVC()
        sourcesNCountryVC.dataDelegate = self
        sourcesNCountryVC.countrySelected = false
        present(sourcesNCountryVC, animated: true, completion: nil)
    }
    // MARK:- action on country button
    @IBAction func selectCountryButtonPressed(_ sender: Any) {
        isFilteredByCompany = true
        newsSourceBtn.isEnabled = isFilteredByCompany ? false : true
        newsSourceBtn.backgroundColor = isFilteredByCompany ? #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1) : #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        let sourcesNCountryVC = SorcesAndCountriesTableVC()
        sourcesNCountryVC.countrySelected = true
        sourcesNCountryVC.countryName = { [weak self] country in
            self?.selectCountryBtn.setTitle(country, for: .normal)
        }
        sourcesNCountryVC.countrySelected = true
        present(sourcesNCountryVC, animated: true, completion: nil)
    }
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        
        if let selectedSource = newsSourceBtn.title(for: .normal), selectedSource != "Select News Source" {
            filterViewModel.fetchFilteredNewsBySorce(source: sourceId)
            filterViewModel.filteredBySources.bind { (articlesBySource) in
                self.updateArticlesDelegate?.updateArticlesBySource(aricles: articlesBySource)
            }
            self.dismiss(animated: true, completion: nil)
        }else if let selectedCountry = selectCountryBtn.title(for: .normal), selectedCountry != "Select Country" {
            filterViewModel.fetchFilteredNewsCountry(country: selectedCountry)
            
            filterViewModel.filteredByCountry.bind { (articlesByCountry) in
                self.updateArticlesDelegate?.updateArticlesBySource(aricles: articlesByCountry)
            }
            self.dismiss(animated: true, completion: nil)
        } else {
            displayMessage(message: "Please Select Country Or News Source", messageError: true)
        }
    }
}
// MARK:- Recieve Selected News Source

extension PopupViewController: TransferData {
    func transferSource(name: String, id: String) {
        self.newsSourceBtn.setTitle(name, for: .normal)
        self.sourceId = id
    }
}
