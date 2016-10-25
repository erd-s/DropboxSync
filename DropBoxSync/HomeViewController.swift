//
//  HomeViewController.swift
//  DropBoxSync
//
//  Created by Christopher Erdos on 10/24/16.
//  Copyright © 2016 Erdos. All rights reserved.
//

import UIKit
import SwiftyDropbox

class HomeViewController: UIViewController {
	//--------------------------------------
	// MARK: - View
	//--------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

    }
	
	
	//--------------------------------------
	// MARK: - Dropbox
	//--------------------------------------
	@IBAction func authDropboxButtonTapped(_ sender: AnyObject) {
		DropboxHandler.authorizeDropbox(viewController: self).then { _ -> Void in
			
			}.catch { _ in
				print("error occured during process of authorizing dropbox.")
		}
	}
	
	@IBAction func syncFilesButtonTapped(_ sender: UIButton) {
		if DropboxHandler.canSyncFiles() {
			DropboxHandler.syncFiles()
		} else {
			DropboxHandler.authorizeDropbox(viewController: self).then { _ -> Void in
				DropboxHandler.syncFiles()
				return
			}.catch { _ in
			print("error occured during process of authorizing dropbox.")
			}
		}
	}
 }
