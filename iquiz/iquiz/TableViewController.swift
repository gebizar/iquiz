//
//  File.swift
//  iquiz
//
//  Created by Gabe Bizar on 2/21/19.
//  Copyright © 2019 Gabe Bizar. All rights reserved.
//

import Foundation
import UIKit

//var subjects = ["Mathematics", "Marvel Super Heroes", "Science"]
var subImNames = ["science", "marvel", "math"]
//var subjDesc = ["Test your algebraic, trignometric, and calculus knowledge!", "How super is your knowledge of pop superherodom?", "General Science Test!"]
var currIndex = 0

class TableViewController: UITableViewController {

    @IBAction func settingsPress(_ sender: Any) {
        let alert = UIAlertController(title: "Setting", message: "Settings go here", preferredStyle:.alert)
        alert.addAction(UIAlertAction(title:"OK", style: .default, handler: {_ in NSLog("\"OK\" pressed.")}))
        alert.addAction(UIAlertAction(title:"Cancel", style: .cancel, handler: {_ in NSLog("\"Cancel\" pressed.")}))
        self.present(alert, animated: true, completion: {NSLog("The completion handler fired")})
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated: animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModController.titleArray.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        ModController.loadJson()
        self.tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = ModController.titleArray[indexPath.row]
        let cellImage: UIImage = UIImage(named: subImNames[indexPath.row])!
        cell.imageView?.image = cellImage
        cell.detailTextLabel?.text = ModController.descArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }
    
}
