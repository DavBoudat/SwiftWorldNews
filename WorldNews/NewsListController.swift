//
//  NewsListController.swift
//  WorldNews
//
//  Created by David on 17/05/2018.
//  Copyright © 2018 ynov. All rights reserved.
//

import UIKit
import Alamofire
import Freddy
import Kingfisher

class NewsListController: UITableViewController {
    var headLines = [HeadLines]()
    let cellIdentifier = "NewsCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 300.0
        tableView.rowHeight = UITableViewAutomaticDimension
        updateData()
    }

    func updateData() {
        Alamofire.request("https://newsapi.org/v2/top-headlines?country=fr&apiKey=054526229eff4971b79cd5d70c0a8880").responseJSON { response in
            response.result.ifSuccess {
                do {
                    self.headLines.removeAll();
                    self.headLines.append(contentsOf: try JSON(data: response.data!).getArray(at: "articles").map(HeadLines.init))
                    self.tableView.reloadData()
                } catch {
                    print("caught: \(error)")
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return headLines.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsTableViewCell else {
            fatalError("The dequeued cell is not an instance of NewsCell.")
        }
       if headLines[indexPath.row].urlToImage != nil {
            let url = URL(string: headLines[indexPath.row].urlToImage!)
            cell.illustration.kf.setImage(with: url)
       } else {
            cell.illustration.isHidden = true
        }
        cell.title.text = headLines[indexPath.row].title
        cell.articleDescription.text = headLines[indexPath.row].description

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showArticle" {
            let articleView = segue.destination as! ArticleViewController
            articleView.urlString = self.headLines[tableView.indexPathForSelectedRow!.row].url
        }
    }

}
