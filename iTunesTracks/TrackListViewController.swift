//
//  ViewController.swift
//  iTunesTracks
//
//  Created by Atul Ghorpade on 10/05/18.
//  Copyright © 2018 Private. All rights reserved.
//

import UIKit

class TrackListViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: TrackListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewModel = TrackListViewModel()
        viewModel.updateLoadingStatus = { [weak self] in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    self?.tableView.alpha = 0.0
                }
                else{
                    self?.activityIndicator.stopAnimating()
                    self?.tableView.alpha = 1.0
                }
            }
            
        }
        
        viewModel.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension TrackListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "trackCellIdentifier", for: indexPath) as? TrackListTableViewCell  else {
            fatalError("Cell does not exist")
        }
        
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        
        cell.labelName.text = cellViewModel.titleText
        cell.labelType.text = cellViewModel.contentTypeText
        cell.labelCurrency.text = cellViewModel.currencyText
        cell.labelCountry.text = cellViewModel.countryText
        
        return cell
    }
}

