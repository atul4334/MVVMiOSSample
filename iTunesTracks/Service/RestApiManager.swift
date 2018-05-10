//
//  RestApiManager.swift
//  iTunesTracks
//
//  Created by Atul Ghorpade on 10/05/18.
//  Copyright © 2018 Private. All rights reserved.
//

import Foundation


typealias ServiceResponse = (NSDictionary, NSError?) -> Void
class RestApiManager: NSObject {
    static let sharedInstane = RestApiManager()
    
    let baseURL = "https://itunes.apple.com/"
    
    func makeHTTPGetRequest(path: String, onCompletion:ServiceResponse){
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest, completionHandler:
        {
            (data, URLResponse, Error) -> Void in
            
            // Data to Swift Dictionary
//            var dictionaryResponse = PropertyListSerialization.propertyList(from: data!, options: PropertyListSerialization.ReadOptions., format: nil) as! Dictionary<String, AnyObject>
            
        let userCourseDictionary: NSDictionary = NSJSONDictionary.NSData(contentsOfURL: courseURL) as NSDictionary
        })
        
    }
}
