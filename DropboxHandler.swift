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
	
	static func authorizeDropbox(viewController: UIViewController) -> Promise<Void> {
		return Promise { (fulfill, reject) in
			DropboxClientsManager.authorizeFromController(UIApplication.shared, controller: viewController, openURL:  { (URL) in
				fulfill()
			})
		}
	}
	
	static func canSyncFiles() -> Bool {
		if let client = DropboxClientsManager.authorizedClient {
				print(client)
			return true
		} else {
			return false
		}
	}
	
	static func syncFiles() {
		if let client = DropboxClientsManager.authorizedClient {
			print(client)
		}
	}
}
