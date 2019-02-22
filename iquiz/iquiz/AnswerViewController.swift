//
//  AnswerViewController.swift
//  iquiz
//
//  Created by Gabe Bizar on 2/22/19.
//  Copyright © 2019 Gabe Bizar. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    let headerText: UILabel = {
        let retText = UILabel()
        retText.text = "Category " + ModController.currQuiz!.title!
        retText.adjustsFontSizeToFitWidth = true
        retText.translatesAutoresizingMaskIntoConstraints = false
        
        return retText
    }()
    
    let countText: UILabel = {
        let retText = UILabel()
        let currQ:Int = ModController.question
        retText.text = "Q#: \(currQ) of \(ModController.currQuiz!.questions.count)"
        retText.adjustsFontSizeToFitWidth = true
        retText.translatesAutoresizingMaskIntoConstraints = false
        return retText
    }()
    
    let qText: UILabel = {
        let retText = UILabel()
        retText.text = "Question: " + ModController.currQuiz!.questions[ModController.question - 1].text!
        retText.adjustsFontSizeToFitWidth = true
        retText.translatesAutoresizingMaskIntoConstraints = false
        return retText
    }()
    
    let answerTextText: UILabel = {
        let retText = UILabel()
        let correctAnswerIndex: Int = Int(ModController.currQuiz?.questions[ModController.question-1].answer!)!
        let correctAnswer: String = ModController.currQuiz?.questions[ModController.question-1].answers[correctAnswerIndex]
        if ModController.gotCorrect {
            

        }
        retText.adjustsFontSizeToFitWidth = true
        retText.translatesAutoresizingMaskIntoConstraints = false
        
        return retText
    }()

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
