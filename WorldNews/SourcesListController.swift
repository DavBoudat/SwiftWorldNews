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
    
    var coreDataHelper : CoreDataHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsMultipleSelection = true
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Cannot use AppDelegate")
        }
        let context = appDelegate.persistentContainer.viewContext
        coreDataHelper = CoreDataHelper(context: context)
        savedSources.append(contentsOf: coreDataHelper!.GetEnabledSources(predicate: NSPredicate(value: true)))
        
        Alamofire.request("https://newsapi.org/v2/sources?language=fr&country=fr&apiKey=054526229eff4971b79cd5d70c0a8880").responseJSON { response in
            response.result.ifSuccess {
                do {
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
    var savedSources = [Source]()
    
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
        
        let source = sources[indexPath.row]
        cell.Source = source
        cell.Name.text = source.name
        if !savedSources.isEmpty {
            let t = savedSources.filter { x in (x.id == source.id!) && x.isEnabled }
            if !t.isEmpty {
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
            }
        } else {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
        }
        return cell
    }
    
    @IBAction func SaveBtnClick(_ sender: Any) {
        coreDataHelper!.emptyCoreData()
        for source in self.sources {
            coreDataHelper!.saveSource(source)
        }
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
