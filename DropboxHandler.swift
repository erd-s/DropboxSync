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
	
	- parameter json: Type `Any`. The object to be serialized into a JSON object.
	- parameter path: Path to write the data to.
	- returns: Promise. Fulfills when data has been uploaded w/o any errors. Catches any errors along the way.
	*/
	static func uploadFiles(json: Any, path: String) -> Promise<Void> {
		return Promise { (fulfill, reject) in
			if let client = DropboxClientsManager.authorizedClient {
				if let dataInput = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
					client.files.upload(path: path, input: dataInput)
						.response { (response, error) in
						if error == nil {
							fulfill()
						} else {
							let errorToReturn = NSError(domain: "DropboxError", code: 666, userInfo: [NSLocalizedDescriptionKey: error!.description])
							reject(errorToReturn)
						}
					}
				} else {
					//not valid json object
					let invalidJsonObjectErr = NSError(domain: "JSONError", code: 666, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON object."])
					reject(invalidJsonObjectErr)
				}
			}
		}
	}
	
	
	/**
	Downloads files to dropbox at a specified path. If there is a value for the
	last upload time in userdefaults, it will pull the file directly. Otherwise,
	it must pull the entire folder and choose the most recent result.
	
	- returns: Promise that fulfills with filecontents and rejects with download error.
	*/
	static func downloadFileAtPath(path: String) -> Promise<Data> {
		return Promise { fulfill, reject in
			if let client = DropboxClientsManager.authorizedClient {
				
				client.files.download(path: path)
					.response { response, error in
						if let response = response {
							let responseMetadata = response.0
							print(responseMetadata)
							let fileContents = response.1
							fulfill(fileContents)
							print(fileContents)
						} else if let err = error {
							var downloadError: NSError!
							if err.description.contains("not_found") {
								downloadError = NSError(domain: "DropboxError", code: 666, userInfo: [NSLocalizedDescriptionKey: "File not found."])

							} else {
								downloadError = NSError(domain: "DropboxError", code: 666, userInfo: [NSLocalizedDescriptionKey: err.description])
							}
							
							reject(downloadError)
						}
				}
			} else {
				//not logged in
			}
		}
	}
}












