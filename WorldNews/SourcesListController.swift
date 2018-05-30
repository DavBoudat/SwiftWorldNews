//
//  SourcesListController.swift
//  WorldNews
//
//  Created by David on 30/05/2018.
//  Copyright © 2018 ynov. All rights reserved.
//

import UIKit
import Alamofire
import Freddy

class SourcesListController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsMultipleSelection = true
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        Alamofire.request("https://newsapi.org/v2/sources?language=fr&country=fr&apiKey=054526229eff4971b79cd5d70c0a8880").responseJSON { response in
            response.result.ifSuccess {
                do {
                    self.sources.removeAll();
                    self.sources.append(contentsOf: try JSON(data: response.data!).getArray(at: "sources").map(Source.init))
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

    var sources = [Source]()

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sources.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sourceCell", for: indexPath) as! SourceCell

        cell.Name.text = sources[indexPath.row].name

        return cell
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
