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
        view.addSubview(headerText)
        view.addSubview(countText)
        view.addSubview(qText)
        view.addSubview(answerText)
        view.addSubview(finishButton)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipGest))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipGest))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        setupMain()
        // Do any additional setup after loading the view.
    }
    
    let headerText: UILabel = {
        let retText = UILabel()
        retText.text = "Category " + ModController.currQuiz!.title
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
        retText.font = retText.font.withSize(12)
        retText.text = "The question was: " + ModController.currQuiz!.questions[ModController.question - 1].text
        retText.adjustsFontSizeToFitWidth = true
        retText.translatesAutoresizingMaskIntoConstraints = false
        return retText
    }()
    
    let answerText: UILabel = {
        let retText = UILabel()
        let correctAnswerIndex: Int = Int(ModController.currQuiz!.questions[ModController.question-1].answer)!
        let correctAnswer: String = ModController.currQuiz!.questions[ModController.question-1].answers[correctAnswerIndex - 1]
        retText.font = retText.font.withSize(12)
        if ModController.gotCorrect {
            retText.text = "Correct! The answer you provided was: \(correctAnswer)"
            retText.textColor = .green
        } else {
            retText.text = "Incorrect! The correct answer is: \(correctAnswer)"
            retText.textColor = .red
        }
        retText.adjustsFontSizeToFitWidth = true
        retText.translatesAutoresizingMaskIntoConstraints = false
        
        return retText
    }()
    
    let finishButton: UIButton = {
        let retButton = UIButton()
        retButton.setTitle("Next", for: .normal)
        retButton.titleLabel?.adjustsFontSizeToFitWidth = true
        retButton.setTitleColor(.white, for: .normal)
        retButton.backgroundColor = .black
        retButton.layer.cornerRadius = 5
        retButton.layer.borderWidth = 1
        retButton.layer.borderColor = UIColor.black.cgColor
        retButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        retButton.translatesAutoresizingMaskIntoConstraints = false
        retButton.addTarget(self, action: #selector(AnswerViewController.nextScene), for: .touchUpInside)
        return retButton
    }()
    
    private func setupMain() {
        headerText.topAnchor.constraint(equalTo: view.topAnchor, constant: 55).isActive = true
        headerText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        countText.topAnchor.constraint(equalTo: headerText.bottomAnchor, constant: 15).isActive = true
        countText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        qText.topAnchor.constraint(equalTo:countText.bottomAnchor, constant: 25).isActive = true
        qText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        answerText.topAnchor.constraint(equalTo:qText.bottomAnchor, constant: 25).isActive = true
        answerText.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        finishButton.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: -35).isActive = true
        finishButton.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true

    }
    
    @objc func nextScene() {
        if ModController.question == ModController.currQuiz?.questions.count {
            performSegue(withIdentifier: "toFinish", sender: nil)
        } else {
            performSegue(withIdentifier: "backQuestion", sender: nil)
        }
    }
    
    @objc func swipGest(gesture:UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                nextScene()
            case UISwipeGestureRecognizer.Direction.left:
                ModController.restartGame()
                performSegue(withIdentifier: "exitAnswer", sender: nil)
            default:
                break
            }
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
