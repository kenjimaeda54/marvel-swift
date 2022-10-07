//
//  HeroViewController.swift
//  HeroisMarvel
//
//  Created by Eric Brito on 22/10/17.
//  Copyright © 2017 Eric Brito. All rights reserved.
//

import UIKit
import WebKit

class HeroViewController: UIViewController  {
	
	@IBOutlet weak var webView: WKWebView!
	@IBOutlet weak var loading: UIActivityIndicatorView!
	
	var hero: Hero?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = hero?.name
		let url = URL(string: hero!.urls.first!.url )
		if let url = url {
			let requestUrl =  URLRequest(url: url)
			webView.allowsBackForwardNavigationGestures = true
			webView.navigationDelegate = self
			webView.load(requestUrl)
		}
	}
	
}

//sempre que terminar de carregar o webview este metodo e chamado
//MARK: - WKNavigationDelegate
extension HeroViewController:WKNavigationDelegate {
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		loading.stopAnimating()
	}
}


