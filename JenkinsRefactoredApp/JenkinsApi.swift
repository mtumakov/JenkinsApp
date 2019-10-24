//
//  JenkinsApi.swift
//  JenkinsRefactoredApp
//
//  Created by Mihail Tumakov on 14/10/2019.
//  Copyright © 2019 Mihail Tumakov. All rights reserved.
//

import Foundation

class JenkinsApi: NSObject {
    var completionHandler: ((Data) -> Void)!
    
    func retrieveURL(_ url: URL, completionHandler: @escaping ((Data) -> Void)) {
        self.completionHandler = completionHandler
        let request: URLRequest = URLRequest(url: url)
        let conf: URLSessionConfiguration = URLSessionConfiguration.default
        let session: URLSession = URLSession(configuration: conf, delegate: self, delegateQueue: nil)
        let task: URLSessionDownloadTask = session.downloadTask(with: request)
        task.resume()
    }
}

extension JenkinsApi: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        do {
            let data: Data = try Data(contentsOf: location)
            DispatchQueue.main.async(execute: {
                self.completionHandler(data)
            })
        } catch {
            print("Can't get data from location.")
        }
    }
}
