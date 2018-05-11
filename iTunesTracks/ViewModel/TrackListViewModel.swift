//
//  TrackListViewModel.swift
//  iTunesTracks
//
//  Created by Atul Ghorpade on 10/05/18.
//  Copyright © 2018 Private. All rights reserved.
//

import UIKit

class TrackListViewModel: NSObject, ApiServiceProtocol {
    
    //Closure Variables
    var updateLoadingStatus:(() -> ())?
    var reloadTableViewClosure:(() -> ())?
    
    //Array of models
    var tracksArray: Array<Track> = []

    override init() {
        super.init()
        
        //Get Track List
        self.getTrackList()
    }
    
    func getTrackList(){
        ApiService.sharedInstane.getTrackList(onSuccess: handleSuccessResponse, onFailure: handleFailureResponse)
    }
    
    // MARK: - Closure Variables

    private var cellViewModels:[TrackCellViewModel] = [TrackCellViewModel](){
        didSet {
            self.reloadTableViewClosure?()
        }
    }

    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }

    //MARK: - Internal Functions
    
    func getCellViewModel(at indexPath: IndexPath) -> TrackCellViewModel
    {
        return cellViewModels[indexPath.row]
    }
    
    //MARK: - API response

    lazy var handleSuccessResponse: (_ responseArray: Array<Any>) -> Void =  {
         [weak self] responseArray in
        
        for dictionary in responseArray
        {
            let track: Track = Track (with: dictionary as! Dictionary<String, Any>)
            self?.tracksArray.append(track)
        }
        
        //Sort by date - descending
        self?.tracksArray.sort(by: { $0.releaseDate?.compare($1.releaseDate!) == .orderedDescending})
        self?.cellViewModels = (self?.createCellModelsFromTracksArray())!

        self?.isLoading = false
    }
    
    lazy var handleFailureResponse: (_ response: Error) -> Void =  {[weak self] _ in
        
        //TODO: Add error alert closure variable and assign it as a view controller blocks like updateLoadingStatus
        self?.isLoading = false
    }

    //MARK: - Create View Models from Models

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
