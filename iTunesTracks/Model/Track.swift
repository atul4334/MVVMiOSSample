//
//  Track.swift
//  iTunesTracks
//
//  Created by atul.ghorpade on 10/05/18.
//  Copyright © 2018 Private. All rights reserved.
//

import UIKit

class Track: NSObject {
    
    let imageURL: String?
    let title: String?
    let contentType: String?
    let currency: String?
    let country: String?
    let releaseDate: Date?

    init(with dictionary: Dictionary<String, Any>)
    {
        self.imageURL = dictionary["artworkUrl30"] as? String ?? ""
        self.title = dictionary["trackName"] as? String ?? ""
        self.contentType = dictionary["kind"] as? String ?? ""
        self.currency = dictionary["currency"] as? String ?? ""
        self.country = dictionary["country"] as? String ?? ""
        let dateString: String = dictionary["releaseDate"] as? String ?? ""
        
        //String to date
        //TODO: move this to utitlty
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        let date = dateFormatter.date(from: dateString)!
        releaseDate = date
        
        super.init()
    }
}
