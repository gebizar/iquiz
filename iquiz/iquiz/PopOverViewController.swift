//
//  PopOverViewController.swift
//  iquiz
//
//  Created by Gabe Bizar on 2/26/19.
//  Copyright © 2019 Gabe Bizar. All rights reserved.
//

import UIKit

class PopOverViewController: UIViewController {

    @IBAction func checkButton(_ sender: Any) {
        guard let neatUrl = URL(string: textIn.text!) else {
            notificationLab.text = "Improper URL"
            return
        }
        URLSession.shared.dataTask(with: neatUrl) {(data, response, err) in
            guard let data = data else {
                self.notificationLab.text = "Sorry, Network Not Available"
                self.notificationLab.textColor = .red
                return
            }
            do {
                let jsonData = try JSONDecoder().decode([ModController.quiz].self, from: data)
                do {
                    let backToJson = try JSONEncoder().encode(jsonData)
                    let toString = String(data:backToJson, encoding: .utf8)!
                    UserDefaults.standard.set(toString, forKey: "read")
                    UserDefaults.standard.set(self.textIn.text!, forKey: "url")
                    print("LOL", UserDefaults.standard.object(forKey: "url"))
                }
            } catch {
                self.notificationLab.text = "Sorry, Network Not Available"
                self.notificationLab.textColor = .red
                return
            }
        }.resume()
    }
    @IBOutlet weak var textIn: UITextField!
    @IBOutlet weak var notificationLab: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()

        // Do any additional setup after loading the view.
    }
    
    func setUp() {
        if let placeholder = UserDefaults.standard.object(forKey: "url") as? String {
            textIn.text = placeholder
        }
       
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
