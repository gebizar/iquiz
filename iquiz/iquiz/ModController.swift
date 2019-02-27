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
        var text: String
        var answer: String
        var answers: [String]
    }
    
    struct quiz: Codable{
        var title: String
        var desc: String
        var questions: [questions]
    }
    
    // holds a var to check against the total number of questions which is the count of questions in a quiz
    static var question: Int = 0
    // for tracking on the answer page
    static var numRight: Int = 0
    // Holds all the cell titles
    static var titleArray:Array<String> = []
    // Holds all the descriptions for the cells
    static var descArray:[String] = []
    // describes the full set of all quizes to switch between
    static var currSet: [quiz] = []
    // describes the current quiz the user is on
    static var currQuiz: quiz?
    static var loaded: Bool = false
    static var gotCorrect: Bool = false
    static var offline: Bool = false
    
    
    class func loadJson() {
        do {
              if let x = UserDefaults.standard.object(forKey:"read") as? String {
                let jsonData = try JSONDecoder().decode([quiz].self, from: x.data(using:.utf8)!)
                print("JSON DATA", jsonData)
                for quiz in jsonData {
                    titleArray.append(quiz.title)
                    descArray.append(quiz.desc)
                    currSet.append(quiz)
                }
                currQuiz = currSet[0]            }
            else {
                offline = true
                print("Defaulting to regular json file use Offline: \(offline)")
                guard let url = Bundle.main.url(forResource: "iquiz", withExtension: "json") else {
                    print("Unable to find file")
                    return
                }
                let data = try Data(contentsOf: url)
                let jsonData = try JSONDecoder().decode([quiz].self, from: data)
                for quiz in jsonData {
                    titleArray.append(quiz.title)
                    descArray.append(quiz.desc)
                    currSet.append(quiz)
                }
                currQuiz = currSet[0]
            }
           
        } catch let error {
            print(error)
        }
        
    }
    
    class func selectQuiz(_ setNum: Int) {
        currQuiz = currSet[setNum]
        
    }
    
    class func restartGame() {
        question = 0
        numRight = 0
        currQuiz = nil
        gotCorrect = false
    }

}
