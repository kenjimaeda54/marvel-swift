//
//  ViewController.swift
//  HeroisMarvel
//
//  Created by Eric Brito on 22/10/17.
//  Copyright © 2017 Eric Brito. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var tfName: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		 super.viewDidDisappear(animated)
		tfName.text = ""
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "allHeroes" {
			let vc = segue.destination as! HeroesTableViewController
			vc.name = tfName.text
			tfName.resignFirstResponder()
		}
	}
	
}


