//
//  ModController.swift
//  iquiz
//
//  Created by Gabe Bizar on 2/21/19.
//  Copyright © 2019 Gabe Bizar. All rights reserved.
//

import UIKit

class ModController: NSObject {
    
    struct questions: Codable {
        var text: String?
        var answer: String?
        var answers: [String?]
    }
    
    struct quiz: Codable{
        var title: String?
        var desc: String?
        var questions: [questions]
    }
    
    
    static var question: Int = 0
    static var numRight: Int = 0
    static var titleArray:Array<String> = []
    static var descArray:[String] = []
    
    class func loadJson() {
        guard let url = Bundle.main.url(forResource: "iquiz", withExtension: "json") else {
            print("Unable to find file")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            
            let jsonData = try JSONDecoder().decode([quiz].self, from:data)
            if let JSONString = String(data:data, encoding: String.Encoding.utf8) {
                print(JSONString)
            }
            print(jsonData)
            for quiz in jsonData {
                titleArray.append(quiz.title!)
                descArray.append(quiz.desc!)
            }
            
        } catch let error {
            print(error, "123123123")
        }
        
    }
    
    class func restartGame() {
        titleArray = []
        descArray = []
    }

}
