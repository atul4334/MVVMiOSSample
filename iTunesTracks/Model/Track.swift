//
//  Track.swift
//  iTunesTracks
//
//  Created by atul.ghorpade on 10/05/18.
//  Copyright © 2018 Private. All rights reserved.
//

import UIKit

class Track: NSObject {
    
    let imageURL: String
    var title: String = ""
    var contentType: String = ""
    var currency: String = ""
    var country: String = ""

    init(with dictionary: Dictionary<String, Any>)
    {
        self.imageURL = dictionary["artworkUrl30"] as! String
        self.title = dictionary["trackName"] as! String
        self.contentType = dictionary["kind"] as! String
        self.currency = dictionary["currency"] as! String
        self.country = dictionary["country"] as! String

        super.init()
        
    }
}
