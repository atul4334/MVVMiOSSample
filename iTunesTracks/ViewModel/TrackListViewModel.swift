//
//  TrackListViewModel.swift
//  iTunesTracks
//
//  Created by Atul Ghorpade on 10/05/18.
//  Copyright © 2018 Private. All rights reserved.
//

import UIKit

class TrackListViewModel: NSObject {
    
    var updateLoadingStatus:(() -> ())?
    var reloadTableViewClosure:(() -> ())?
    
    private var cellViewModels:[TrackCellViewModel] = [TrackCellViewModel](){
        didSet {
            self.reloadTableViewClosure?()
        }
    }

    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> TrackCellViewModel
    {
        return cellViewModels[indexPath.row]
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    
}
