//
//  ViewController.swift
//  iquiz
//
//  Created by Gabe Bizar on 2/20/19.
//  Copyright © 2019 Gabe Bizar. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(headerText)
        view.addSubview(countText)
        view.addSubview(qText)
        view.addSubview(retView)
        view.addSubview(confirmationText)
        view.addSubview(submitButton)
        
        setupMain()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    let questionBox: UIView = {
        let retView = UIView()
        retView.translatesAutoresizingMaskIntoConstraints = false
        return retView
    }()
    
    let headerText: UILabel = {
        let retText = UILabel()
        retText.text = "Category " + ModController.currQuiz!.title!
        retText.adjustsFontSizeToFitWidth = true
        retText.translatesAutoresizingMaskIntoConstraints = false
        
        return retText
    }()
    
    let countText: UILabel = {
        let retText = UILabel()
        let currQ:Int = ModController.question + 1
        retText.text = "Q#: \(currQ) of \(ModController.currQuiz!.questions.count)"
        retText.adjustsFontSizeToFitWidth = true
        retText.translatesAutoresizingMaskIntoConstraints = false
        return retText
    }()
    
    let qText: UILabel = {
        let retText = UILabel()
        retText.text = "Question: " + ModController.currQuiz!.questions[ModController.question].text!
        retText.adjustsFontSizeToFitWidth = true
        retText.translatesAutoresizingMaskIntoConstraints = false
        return retText
    }()
    
    let retView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let confirmationText: UILabel = {
        let retText = UILabel()
        retText.text = "Selected Answer: None Selected"
        retText.adjustsFontSizeToFitWidth = true
        retText.translatesAutoresizingMaskIntoConstraints = false
        return retText
    }()
    
    let submitButton: UIButton = {
        let retButton = UIButton()
        retButton.setTitle("Next Question", for: .normal)
        retButton.titleLabel?.adjustsFontSizeToFitWidth = true
        retButton.setTitleColor(.blue, for: .normal)
        retButton.backgroundColor = .white
        retButton.backgroundColor = .white
        retButton.layer.cornerRadius = 5
        retButton.layer.borderWidth = 1
        retButton.layer.borderColor = UIColor.black.cgColor
        retButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        retButton.translatesAutoresizingMaskIntoConstraints = false
        retButton.addTarget(self, action: #selector(QuestionViewController.nextScene), for: .touchUpInside)
        return retButton
    }()
    
    var answerSet: [UIView] = []
    var selected: Int = 0
    
    private func setupMain() {
        headerText.topAnchor.constraint(equalTo: view.topAnchor, constant: 55).isActive = true
        headerText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        countText.topAnchor.constraint(equalTo: headerText.bottomAnchor, constant: 15).isActive = true
        countText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        qText.topAnchor.constraint(equalTo:countText.bottomAnchor, constant: 25).isActive = true
        qText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        retView.leadingAnchor.constraint(equalTo:view.leadingAnchor).isActive = true
        retView.widthAnchor.constraint(equalTo:view.widthAnchor).isActive = true
        retView.heightAnchor.constraint(equalTo:view.heightAnchor, multiplier: 2/5).isActive = true
        retView.topAnchor.constraint(equalTo:qText.bottomAnchor, constant: 15).isActive = true
        submitButton.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: -15).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmationText.bottomAnchor.constraint(equalTo:submitButton.topAnchor, constant: -15).isActive = true
        confirmationText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        for (index, answer) in ModController.currQuiz!.questions[ModController.question].answers.enumerated() {
            let toAdd:UIView = createAnswer(index, answer!)
            answerSet.append(toAdd)
        }
        
        for (index,answer) in answerSet.enumerated() {
            retView.addSubview(answer)
            answer.leadingAnchor.constraint(equalTo:retView.leadingAnchor).isActive = true
            answer.trailingAnchor.constraint(equalTo:retView.trailingAnchor).isActive = true
            answer.heightAnchor.constraint(equalTo:retView.heightAnchor, multiplier: 1/4).isActive = true
            if index != 0 {
                answer.topAnchor.constraint(equalTo:answerSet[index - 1].bottomAnchor).isActive = true
            } else {
                answer.topAnchor.constraint(equalTo:retView.topAnchor).isActive = true
            }
        }

    }
    
    private func createAnswer(_ represents: Int, _ answerText: String) -> UIView {
        let val = represents + 1
        let toAddLabel: UILabel = {
            let retText = UILabel()
            retText.font = retText.font.withSize(12)
            let tempText = ModController.currQuiz?.questions[ModController.question].answers[represents]!
            retText.text = "\(val). \(tempText!)"
            retText.adjustsFontSizeToFitWidth = true
            retText.translatesAutoresizingMaskIntoConstraints = false
            return retText
        }()
        
        let toAddButton: UIButton = {
            let retButton = UIButton()
            retButton.tag = val
            retButton.setTitle("Select", for: .normal)
            retButton.titleLabel?.adjustsFontSizeToFitWidth = true
            retButton.setTitleColor(.blue, for: .normal)
            retButton.backgroundColor = .white
            retButton.backgroundColor = .white
            retButton.layer.cornerRadius = 5
            retButton.layer.borderWidth = 1
            retButton.layer.borderColor = UIColor.black.cgColor
            retButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            retButton.translatesAutoresizingMaskIntoConstraints = false
            retButton.addTarget(self, action: #selector(QuestionViewController.chooseAnswer), for: .touchUpInside)
            return retButton
        }()
        
        let retView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        retView.addSubview(toAddLabel)
        retView.addSubview(toAddButton)
        toAddLabel.leadingAnchor.constraint(equalTo: retView.leadingAnchor, constant: 15).isActive = true
        toAddLabel.topAnchor.constraint(equalTo: retView.topAnchor, constant: 15).isActive = true
        toAddButton.trailingAnchor.constraint(equalTo: retView.trailingAnchor, constant: -15).isActive = true
        toAddButton.topAnchor.constraint(equalTo: retView.topAnchor, constant: 15).isActive = true


        return retView
    }
    
    @objc func chooseAnswer(sender: UIButton){
        selected = sender.tag
        confirmationText.text = "Selected Answer: \(sender.tag)"
        print(selected)
    }

    @objc func nextScene() {
        let lastChar = confirmationText.text!.last!
        if let num = Int(String(lastChar)) {
            ModController.question += 1
            ModController.currQuiz = ModController.currSet[ModController.question]
            if let ansNum = Int(ModController.currQuiz!.questions[ModController.question - 1].answer!) {
                print(ansNum == num)
                ModController.gotCorrect = (ansNum == num)
            }
            performSegue(withIdentifier: "toAnswer", sender: nil)

        } else {
            print("Nothing selected")
        }
    }
}

