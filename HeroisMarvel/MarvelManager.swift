//
//  MarvelManager.swift
//  HeroisMarvel
//
//  Created by kenjimaeda on 06/10/22.
//  Copyright © 2022 Eric Brito. All rights reserved.
//

import Foundation
import SwiftHash
import Alamofire

struct MarvelManager {
	
	let apikey = "6ea7bb77ed8bfb1d9e508938cb409875"
	let privateKey = "945d7fbb424745562d84179510e7f52c30f87008"
	let baseUrl = "https://gateway.marvel.com:443/v1/public/characters?"
	let limit = 50

	
	//@escaping e preciso porque vou usar essa funcao dentro de uma closure
	//dessa maneira estou retornando o valor direto para closure,por isso o uso do onComplete
func getCharacters (name: String?,page: Int = 0 , onComplete: @escaping (MarvelInfo?) ->Void)  {
		//offset e recurso que a cada pagina vai pular
		//entao iniciar mostrara os 50 primeiros apos isto ira pular mais 50,mais 100
		let offset = limit * page
		let nameStartsWith: String
		
		//substituir caracters vazio
		if let name = name, !name.isEmpty{
			nameStartsWith = "nameStartsWith=\(name.replacingOccurrences(of:" ",with: ""))"
		}else {
			//vai ser vazio
			nameStartsWith = ""
		}
		
		let url = "\(baseUrl)\(configCredentials())&limit=\(limit)&offset=\(offset)&\(nameStartsWith)"
	 
		AF.request(url).validate().responseDecodable(of:MarvelInfo.self) { response in
			switch response.result {
			case let .success(data):
				onComplete(data)
			case let .failure(error):
				print(error)
				onComplete(nil)
			}
		}
	}
	
	
	func configCredentials () -> String {
		//espera um string iria retornar um date
		let  ts = String(Date().timeIntervalSince1970)
		let hash = MD5("\(ts)\(privateKey)\(apikey)").lowercased()
		let urlAuthentication = "ts=\(ts)&apikey=\(apikey)&hash=\(hash)"
		return urlAuthentication
	}
	
}
