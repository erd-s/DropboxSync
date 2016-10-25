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
	// MARK: - Properties
	//--------------------------------------
	var dummyData = [NSDictionary]()
	
	//--------------------------------------
	// MARK: - View
	//--------------------------------------
	override func viewDidLoad() {
		super.viewDidLoad()
		
		dummyData = [
			["name": "Namor",
			 "description": "Half-human and half-atlantean, Namor the sub-mariner was one of the earliest superheroes in the Marvel universe. The stereotypical antihero, his short fuse and long list of superpowers would make him a formidable foe.",
			 "avatar_url": "https://s3.amazonaws.com/superheropediaimages/namor.png",
			 "name": "Captain Marvel"],
			["description": "Whenever he utters the phrase Shazam!, young Billy Batson becomes one of the universe's most versatile superheroes. His list of powers include the wisdom of Solomon, the strength of Hercules, the stamina of Atlas, the power of Zeus, the courage of Achilles, and the speed of Mercury. Known as Earth's mightiest mortal. Captain Marvel is a force to be reckoned with.",
			 "avatar_url": "https://s3.amazonaws.com/superheropediaimages/captainmarvel.png"],
			["name": "Firestorm",
			 "description": "Unlike other superheroes Firestorm is actually two people that when combined create a superbeing with the ability to rearrange matter on the molecular level. If it weren't for the fact that he were limited to non-organic material he would probably be a lot closer to #1.",
			 "avatar_url": "https://s3.amazonaws.com/superheropediaimages/firestorm.png"]
		]
	}
	
	func showAlertWithTitle(_ title: String) {
		let successAlertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
		let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
		successAlertController.addAction(ok)
		
		present(successAlertController, animated: true, completion: nil)
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
	
	@IBAction func uploadFilesButtonTapped(_ sender: UIButton) {
		if DropboxHandler.canSyncFiles() {
			DropboxHandler.uploadFiles(json: self.dummyData, path: "/\(NSDate())").then {
				self.showAlertWithTitle("Successfully uploaded files!")
				}.catch { thrownError in
					self.showAlertWithTitle(thrownError.localizedDescription)
			}
		} else {
			DropboxHandler.authorizeDropbox(viewController: self).then {
				DropboxHandler.uploadFiles(json: self.dummyData, path: "/\(NSDate())")
				}.then {
					self.showAlertWithTitle("Successfully uploaded files!")
				}.catch { thrownError in
					self.showAlertWithTitle(thrownError.localizedDescription)
			}
		}
	}
	
	@IBAction func retrieveFilesButtonTapped(_ sender: UIButton) {
	}
}
