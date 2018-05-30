//
//  ArticleViewController.swift
//  WorldNews
//
//  Created by David on 27/05/2018.
//  Copyright © 2018 ynov. All rights reserved.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    public var urlString : String = ""
    
    override func loadView() {
        let webConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfig)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let articleUrl = URL(string: urlString)
        let request = URLRequest(url: articleUrl!)
        webView.load(request)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
