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
    private let refreshControl = UIRefreshControl()
    
    // MARK: - View Loading
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupViewModel()
        
        self.setupPullToRefresh()
        
        self.setupAuthoHeightTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Private Methods

    private func setupViewModel(){
        viewModel = TrackListViewModel()
        
        //setup loading status handling
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
                    self?.refreshControl.endRefreshing()
                }
            }
        }
        
        //setup reload table handling
        viewModel.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func setupPullToRefresh(){
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshTrackList(_:)), for: .valueChanged)
    }
    
    private func setupAuthoHeightTableView(){
        self.tableView.estimatedRowHeight = 150
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    @objc private func refreshTrackList(_ sender: Any) {
        // Fetch track data
        viewModel.getTrackList()
    }
}

// MARK: - Extension for table view delegates

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
        
        cell.imageViewTrack.sd_setImage(with: URL(string: cellViewModel.imageURL)!)
        
        cell.imageViewTrack.layer.cornerRadius = cell.imageViewTrack.frame.width/8.0
        cell.imageViewTrack.clipsToBounds = true
        
        return cell
    }
}

