# Marvel
Projeto para consumir [api marvel](https://developer.marvel.com/)

#  Motivação
Reforçar aprendizado de gerenciamento dependências com Cocoapods, scrooll infinto e consumo de api

# Featture
- Quando tem necessidade de usar palavras reservadas do swit coloque entre crases
- Aprendi o uso do [Alamofire](https://github.com/Alamofire/Alamofire)
- Ele facilita o consumo de api


```swift
//exemplo como usar palavras reservadas do swift

struct Thumbnail: Codable {
	let path: String
	//para usar uma palavra reservada
	//utiliza os ``
	let `extension`: String
	
	var url: String {
	  return  "\(path).\(`extension`)"
	}

}

//exemplo do Alamofire
func getCharacters (name: String?,page: Int = 0 , onComplete: @escaping (MarvelInfo?) ->Void)  {
		
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
	

```


##
- Aprendi criar minhas próprias closure ao invés de usar retorno da função, criei uma função callback
- Para permitir isto preciso da palavra @escaping
- Para realizar scrool infinito, recebo um argumento contendo a página atual, em posso desse valor multiplico pelo limit, assim consigo offset
- Offset e recurso esperado pela api para saltar novos dados
- Preciso garantir que o texto capturado não houve espaço vazio, por isso uso do replacingOccurences
- Com os três métodos abaixo eu realizo uma requisição no servidor, faço carregamento dele e aplico scrool infito

```swift
//requisicao
func getCharacters (name: String?,page: Int = 0 , onComplete: @escaping (MarvelInfo?) ->Void)  {
  let offset = limit * page
  let nameStartsWith: String
		 
  if let name = name, !name.isEmpty{
  nameStartsWith = "nameStartsWith=\(name.replacingOccurrences(of:" ",with: ""))"
  }else {
		
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
	
//quem vai usar funcao que criei
func loadHeros() {
isLoadingHero = true
marvelManager.getCharacters(name: name,page: currentPage) { [self](response) in
if response != nil {
heroes += response!.data.results
total = response!.data.total
//estou disparando um fila main porque e assincrona
//os dadoS
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

// metodo do table view que e acionado a cada vez que aparece um cellula na tela
override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
 if indexPath.row == heroes.count - 10 && heroes.count < total && !isLoadingHero {
 currentPage += 1
 loadHeros()
  }
		 
}

```

## 
- Para possuir acesso a row selecionado usamos o método indexPathForSelectedRow
- Utilizei o [kingfisher](https://github.com/onevcat/Kingfisher) para lidar com requisição de imagens no servidor
- Para usar requisição fora de https precisei liberar [NSAppTransportSecurity](https://stackoverflow.com/questions/32631184/the-resource-could-not-be-loaded-because-the-app-transport-security-policy-requi)

```swift
	func prepareCell(_ hero:Hero) {
	labDescription.text = hero.description
	labName.text = hero.name
	
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
  
  
//acessar celula selecionada
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   if segue.identifier == "singleHero" {
    let vc = segue.destination as! HeroViewController
    //toda row seleciado fica no indexPathForSelectedRow
    vc.hero = heroes[tableView.indexPathForSelectedRow!.row]
		}
}

```




