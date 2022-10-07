//
//  MarvelInfo.swift
//  HeroisMarvel
//
//  Created by kenjimaeda on 05/10/22.
//  Copyright © 2022 Eric Brito. All rights reserved.
//

import Foundation

struct MarvelInfo: Codable {
	let code: Int
	let status: String
	let data: Data
}

struct Data: Codable {
	let offset: Int
	let limit: Int
	let total: Int
	let count: Int
	let results: [Hero]
}

struct Hero: Codable {
	let id: Int
	let name: String
	let description: String
	let modified: String
	let thumbnail: Thumbnail
	let urls: [HeroUrl]
	
}

struct Thumbnail: Codable {
	let path: String
	//para usar uma palavra reservada
	//utiliza os ``
	let `extension`: String
	
	var url: String {
	  return  "\(path).\(`extension`)"
	}

}

struct HeroUrl: Codable {
	let type: String
	let url: String
}




