//
//  TrackCellViewModel.swift
//  iTunesTracks
//
//  Created by Atul Ghorpade on 10/05/18.
//  Copyright © 2018 Private. All rights reserved.
//

import UIKit

class TrackCellViewModel: NSObject {
    //In View Model properties are implicitly unwrapped, the value assignment is handled in model itself
    let imageURL: String!
    let titleText: String!
    let contentTypeText: String!
    let currencyText: String!
    let countryText: String!
    
    init(track: Track) {
        self.imageURL = track.imageURL
        self.titleText = track.title
        self.currencyText = track.currency
        self.countryText = track.country
        self.contentTypeText = track.contentType
        super.init()
    }
}
