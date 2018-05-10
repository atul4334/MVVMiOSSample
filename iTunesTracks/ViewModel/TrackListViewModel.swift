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
    var tracksArray: Array<Track> = []

    override init() {
        super.init()
        
        self.getTrackList()
    }
    
    private func getTrackList(){
        ApiService.sharedInstane.getTrackList(onSuccess: handleSuccessResponse, onFailure: handleFailureResponse)
    }
    
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
    
    lazy var handleSuccessResponse: (_ responseArray: Array<Any>) -> Void =  {
         [weak self] responseArray in
        
        for dictionary in responseArray
        {
            let track: Track = Track (with: dictionary as! Dictionary<String, Any>)
            self?.tracksArray.append(track)
        }
        
        self?.cellViewModels = (self?.createCellModelsFromTracksArray())!

        self?.isLoading = false
    }
    
    lazy var handleFailureResponse: (_ response: Error) -> Void =  {[weak self] _ in
        
        self?.isLoading = false
    }

    private func createCellModelsFromTracksArray() -> [TrackCellViewModel]
    {
        var trackCellViewModelArray:[TrackCellViewModel] = []
        for track in self.tracksArray
        {
            trackCellViewModelArray.append(TrackCellViewModel.init(track: track))
        }
        
        return trackCellViewModelArray
    }
}
