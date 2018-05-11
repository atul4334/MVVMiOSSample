//
//  ApiService.swift
//  iTunesTracks
//
//  Created by Atul Ghorpade on 10/05/18.
//  Copyright © 2018 Private. All rights reserved.
//

import Foundation

protocol ApiServiceProtocol: NSObjectProtocol {
    func onSuccess(response: Dictionary<String, Any>)
    func onFailure(response: Error)
}

class ApiService: NSObject {
    static let sharedInstane = ApiService()
    
    let baseURL = "https://itunes.apple.com/"
    
    func getTrackList(onSuccess: @escaping((Array<Any>) -> Void), onFailure: @escaping(Error) -> Void){
        
        let trackListURL = baseURL + "search?term=jack+johnson"

        let request = NSMutableURLRequest(url: NSURL(string: trackListURL)! as URL)
        
        let session = URLSession.shared
        
        let task: URLSessionTask = session.dataTask(with: request as URLRequest, completionHandler:
        {
            (data, URLResponse, error) -> Void in
            
            var responseDictionary: Dictionary<String, Any>?
            
            if(error != nil){
                onFailure(error!)
            } else{
                // Data to Dictionary
                do {
                    responseDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary
                    
                    print("response \(responseDictionary)")
                    
                } catch let parseError as Error {
                    onFailure(error!)
                    return
                }
                onSuccess(responseDictionary!["results"] as! Array<Any>)
            }
        })
        task.resume()
    }
}


