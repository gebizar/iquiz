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
    @IBAction func settings(_ sender: Any) {
        alert()
    }
    
   
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModController.titleArray.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if !ModController.loaded {
            ModController.loadJson()
            ModController.loaded = true
            
        }
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pl = UserDefaults.standard.object(forKey: "url") as? String
        if let placeholder = UserDefaults.standard.object(forKey: "url") as? String {
            writeToFile(urlString: placeholder)
        } else {
            UserDefaults.standard.set("https://tednewardsandbox.site44.com/questions.json", forKey: "url")
            writeToFile(urlString: "https://tednewardsandbox.site44.com/questions.json")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if ModController.offline {
            alert()
        }
    }
    
    private func alert() {
        let alert = UIAlertController(title: "Offline", message: "Currently Offline, using backup file", preferredStyle:.alert)
        alert.addAction(UIAlertAction(title:"OK", style: .default, handler: {_ in NSLog("\"OK\" pressed.")}))
        alert.addAction(UIAlertAction(title:"Cancel", style: .cancel, handler: {_ in NSLog("\"Cancel\" pressed.")}))
        self.present(alert, animated: true, completion: {NSLog("The completion handler fired")})
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
        ModController.selectQuiz(currIndex)
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    private func writeToFile(urlString: String) {
        let fetchUrl = urlString
        print(urlString)
        guard let neatUrl = URL(string: fetchUrl) else {
            print("Improper URL")
            return
        }
        
        URLSession.shared.dataTask(with: neatUrl) {(data, response, err) in
            guard let data = data else {
                return
            }
            do {
                let jsonData = try JSONDecoder().decode([ModController.quiz].self, from: data)
                do {
                    let backToJson = try JSONEncoder().encode(jsonData)
                    let toString = String(data:backToJson, encoding: .utf8)!
                    UserDefaults.standard.set(toString, forKey: "read")
//                    if let x = UserDefaults.standard.object(forKey:"read") as? String {
//                        print("TEST123", x)
//                    }
                    ModController.offline = false
                }
            } catch let error2 {
                print(error2)
                return
            }
        }.resume()
        
    }
    
}
