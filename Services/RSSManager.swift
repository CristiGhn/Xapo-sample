//
//  RSSManager.swift
//  Xapo
//
//  Created by Cristian Florin Ghinea on 13/06/2018.
//  Copyright © 2018 Cristian Florin Ghinea. All rights reserved.
//

import Foundation

protocol RSSManagerDelegate: class {
    
    func rssReady(items: Array<Project>?)
}

class RSSManager {
    
    private weak var delegate : RSSManagerDelegate? = nil
    private var url : String?
    
    init(url: String?, delegate: RSSManagerDelegate) {
        self.url = url
        self.delegate = delegate
    }
    
    func start() {
        
        if self.url != nil {
            
            if let validURL = URL(string:self.url!) {
                let request = URLRequest(url: validURL)
                let session = URLSession(configuration: URLSessionConfiguration.default)
                
                let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
                    
                    if data != nil {
                        
                        do {
                            
                            let dictionary = try XMLReader.dictionary(forXMLData: data!, options: UInt(XMLReaderOptionsProcessNamespaces))
                            self.process(dictionary: dictionary)
                            
                        } catch {
                            
                        }
                        
                    }
                })
                
                task.resume()
            }
        }
    }
    
    private func process(dictionary: Dictionary<AnyHashable, Any>) {
        
        if let rss = dictionary["rss"] as? Dictionary<AnyHashable, Any> {
            
            if let channel = rss["channel"] as? Dictionary<AnyHashable, Any> {
                
                if let items = channel["item"] as? Array<Dictionary<String, Any>> {
                    
                    DispatchQueue.main.async { // DECODE and response must be from main thread, othwerise the app will crash
                        
                        var itemsArray : Array<Project> = []
                        
                        for i in 0..<items.count {
                            
                            let item = items[i]
                            let project = Project()
                            
                            if let link = item["link"] as? Dictionary<String, String> {
                                project.link = URL(string: link["text"]!)
                            }
                            
                            if let title = item["title"] as? Dictionary<String, String> {
                                if let title = title["text"] {
                                    project.title = title
                                }
                            }
                            
                            if let description = item["description"] as? Dictionary<String, String> {
                                if let description = description["text"] {
                                    project.projectDescription = description
                                }
                            }
                            
                            if project.link != nil && project.title != nil {
                                itemsArray.insert(project, at: itemsArray.count)
                            }
                        }
                        
                        if itemsArray.count > 0 {
                            self.delegate?.rssReady(items: itemsArray)
                        }
                    }
                }
            }
        }
    }
}
