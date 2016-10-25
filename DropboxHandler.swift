//
//  DropboxHandler.swift
//  DropboxSync
//
//  Created by Christopher Erdos on 10/24/16.
//  Copyright © 2016 Erdos. All rights reserved.
//

import UIKit
import SwiftyDropbox
import PromiseKit


class DropboxHandler {
	fileprivate var appSecret = "g5nbjexv7p1mgci"
	fileprivate var appKey = "6n9m6c17lt0amwy"
	
	
	/**
	Presents authorization flow for user to authorize dropbox.
	
	- parameter viewController: View controller to present from.
	- returns: Promise that fulfills once auth flow is completed.
	*/
	static func authorizeDropbox(viewController: UIViewController) -> Promise<Void> {
		return Promise { (fulfill, reject) in
			DropboxClientsManager.authorizeFromController(UIApplication.shared, controller: viewController, openURL: {(url: URL) -> Void in UIApplication.shared.open(url, options: [:], completionHandler: { (true) in
				fulfill()
			})
				})
		}
	}
	
	/**
	Tests to see if client(app) is authorized.
	
	- returns: `true` if authorized, `false` if not.
	*/
	static func canSyncFiles() -> Bool {
		if let _ = DropboxClientsManager.authorizedClient {
			return true
		} else {
			return false
		}
	}
	
	
	/**
	Uploads files to dropbox at a specified path.
	
	
	*/
	static func uploadFiles(json: Any, path: String) -> Promise<Void> {
		return Promise { (fulfill, reject) in
			if let client = DropboxClientsManager.authorizedClient {
				if let dataInput = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
					let req = client.files.upload(path: path, input: dataInput)
					req.response(completionHandler: { (response, error) in
						if error == nil {
							fulfill()
						} else {
							let errorToReturn = NSError(domain: "DropboxError", code: 666, userInfo: [NSLocalizedDescriptionKey: error!.description])
							reject(errorToReturn)
						}
					})
					
					req.progress({ (progress) in
						//handle progress (spinner)
					})
					
				} else {
					//not valid json object
					let invalidJsonObjectErr = NSError(domain: "JSONError", code: 666, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON object."])
					reject(invalidJsonObjectErr)
				}
			}
		}
	}
}
