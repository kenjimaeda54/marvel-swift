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
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "singleHero" {
			let vc = segue.destination as! HeroViewController
			//toda row seleciado fica no indexPathForSelectedRow
			vc.hero = heroes[tableView.indexPathForSelectedRow!.row]
		}
	}
	
	func loadHeros() {
		isLoadingHero = true
		marvelManager.getCharacters(name: name,page: currentPage) { [self](response) in
			//aqui e para colocar mais heroes conforme passa
			//por exemplo inicia com 50 depois 100
			if response != nil {
				heroes += response!.data.results
				total = response!.data.total
				//estou disparando um fila main porque e assincrona
				//os dados
				DispatchQueue.main.async {
					//apos fazer reload se nao sumir o text e porque
					//nao encontrei heroi
					//importante o dispactQueue.main pois aqui e assincrono
					self.isLoadingHero = false
					self.label.text = "Dont finded heores with name   \(self.name!)"
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
		tableView.backgroundView = count  == 0 ? label : nil
		return count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HeroesTableViewCell
		let hero = heroes[indexPath.row]
		cell.prepareCell(hero)
		return cell
	}
	
	//metodo sermpre chamado quando mostrar a celula
	//vou pegar quando estiver no 40
	//assim garanto loading infito evito usuario scrollar
	//para tras e fazer novos requests porcausa do !isLoadingHero
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if indexPath.row == heroes.count - 10 && heroes.count < total && !isLoadingHero {
			  currentPage += 1
			  loadHeros()
		}
		 
	}

	
}
