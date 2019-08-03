//
//  SorcesAndCountriesTableVC.swift
//  News app
//
//  Created by Hassan Mostafa on 7/31/19.
//  Copyright © 2019 Hassan Mostafa . All rights reserved.
//

import UIKit
protocol TransferData {
    func transferSource(name: String, id: String)
}
class SorcesAndCountriesTableVC: UITableViewController {
    var dataDelegate: TransferData?
    var countryName: ((String)->Void)?
    var newsSourceVM = NewsSourceViewModel()
    var countrySelected = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "SourceAndCountryTableViewCell", bundle: nil), forCellReuseIdentifier: "SourceAndCountryTableViewCell")
        newsSourceVM.fetchData()
        newsSourceVM.sources.bind { (_) in
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsSourceVM.sourcesCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SourceAndCountryTableViewCell", for: indexPath) as? SourceAndCountryTableViewCell else {
            return UITableViewCell()
        }
        cell.sourceNameLabel.text = newsSourceVM.updateSourceName(for: indexPath.row, isCountrySelected: countrySelected)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSource = newsSourceVM.sources.value[indexPath.row]
        if countrySelected {
            countryName?(selectedSource.country ?? "")
            print(selectedSource.country)
          
        } else {
            dataDelegate?.transferSource(name: selectedSource.name ?? "", id: selectedSource.id ?? "")
        }
        print("Country Selection is: \(countrySelected)")
        dismiss(animated: true, completion: nil)
    }
}
