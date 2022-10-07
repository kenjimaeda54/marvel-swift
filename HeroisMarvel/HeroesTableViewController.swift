//
//  HeroesTableViewController.swift
//  HeroisMarvel
//
//  Created by Eric Brito on 22/10/17.
//  Copyright © 2017 Eric Brito. All rights reserved.
//

import UIKit

class HeroesTableViewController: UITableViewController {
	
	var label: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = .white
		return label
	}()
	
	var name: String?
	var marvelManager = MarvelManager()
	var isLoadingHero = false
	var total = 0
	var currentPage = 0
	var heroes: [Hero] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		label.text = "Wait searching heroes"
		loadHeros()
	}
	
	func loadHeros() {
		isLoadingHero = true
		marvelManager.getCharacters(name: name,page: currentPage) { [self](response) in
			//aqui e para colocar mais heroes conforme passa
			//por exemplo inicia com 50 depois 100
			if response != nil {
				heroes += response!.data.results
				total = response!.data.total
				//estou disparando um fila main que e assincrona
				//para acessar o reloadData
				DispatchQueue.main.async {
					//apos fazer reload se nao sumir o text e porque
					//nao encontrei heroi
					//importante o dispactQueue.main pois aqui e assincrono
					self.isLoadingHero = false
					self.label.text = "Dont finded heores with name \(String(describing: self.name))"
					self.tableView.reloadData()
					
				}
			}
		}
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	// MARK: - Table view data source
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let count = heroes.count
		let backgroundView = count  == 0 ? label : nil
		return count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HeroesTableViewCell
		let hero = heroes[indexPath.row]
		cell.prepareCell(hero)
		return cell
	}
	
	
	/*
	 // Override to support conditional editing of the table view.
	 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
	 // Return false if you do not want the specified item to be editable.
	 return true
	 }
	 */
	
	/*
	 // Override to support editing the table view.
	 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
	 if editingStyle == .delete {
	 // Delete the row from the data source
	 tableView.deleteRows(at: [indexPath], with: .fade)
	 } else if editingStyle == .insert {
	 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	 }
	 }
	 */
	
	/*
	 // Override to support rearranging the table view.
	 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
	 
	 }
	 */
	
	/*
	 // Override to support conditional rearranging of the table view.
	 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
	 // Return false if you do not want the item to be re-orderable.
	 return true
	 }
	 */
	
	/*
	 // MARK: - Navigation
	 
	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	 // Get the new view controller using segue.destinationViewController.
	 // Pass the selected object to the new view controller.
	 }
	 */
	
}
