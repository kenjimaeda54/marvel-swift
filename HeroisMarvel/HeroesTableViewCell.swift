//
//  HeroesTableViewCell.swift
//  HeroisMarvel
//
//  Created by kenjimaeda on 06/10/22.
//  Copyright © 2022 Eric Brito. All rights reserved.
//

import UIKit
import Kingfisher

class HeroesTableViewCell: UITableViewCell {
	
	@IBOutlet weak var labDescription: UILabel!
	@IBOutlet weak var labName: UILabel!
	@IBOutlet weak var thumbImg: UIImageView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	func prepareCell(_ hero:Hero) {
		labDescription.text = hero.description
		labName.text = hero.name
		//precisa adicionar permissao de url fora do https
		//referencia, NSAppTransportSecurity isto e um dicionario
		//https://stackoverflow.com/questions/32631184/the-resource-could-not-be-loaded-because-the-app-transport-security-policy-requi
		if let urlImage = URL(string: hero.thumbnail.url){
			thumbImg.kf.setImage(with: urlImage)
			thumbImg.kf.indicatorType = .activity
		}else {
			thumbImg.image = nil
		}
	 
		//border radius
		thumbImg.layer.cornerRadius = thumbImg.frame.size.height/2
		thumbImg.layer.borderColor = UIColor.red.cgColor
		thumbImg.layer.borderWidth = 2
		
	}
	
}
