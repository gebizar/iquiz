//
//  FinishViewController.swift
//  iquiz
//
//  Created by Gabe Bizar on 2/22/19.
//  Copyright © 2019 Gabe Bizar. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(funText)
        view.addSubview(scoreText)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    let funText: UILabel = {
        let retText = UILabel()
        let dblVal: Double = Double(ModController.numRight / ModController.currQuiz!.questions.count)
        var textVal: String = ""
        if dblVal == 1 {
            textVal = "Perect Score! Nice!"
        } else if dblVal >= 0.74 && dblVal < 1{
            textVal = "Getting there! So Close!"
        } else {
            textVal = "Would you like to try again?"
        }
        retText.text = textVal
        retText.adjustsFontSizeToFitWidth = true
        retText.translatesAutoresizingMaskIntoConstraints = false
        
        return retText
    }()
    
    let scoreText: UILabel = {
        let retText = UILabel()
        retText.text = "\(ModController.numRight) of \(ModController.currQuiz!.questions.count) correct"
        retText.adjustsFontSizeToFitWidth = true
        retText.translatesAutoresizingMaskIntoConstraints = false
        
        return retText
    }()
    
    let finishButton: UIButton = {
        let retButton = UIButton()
        retButton.setTitle("Back to Quiz Selection", for: .normal)
        retButton.titleLabel?.adjustsFontSizeToFitWidth = true
        retButton.setTitleColor(.white, for: .normal)
        retButton.backgroundColor = .black
        retButton.layer.cornerRadius = 5
        retButton.layer.borderWidth = 1
        retButton.layer.borderColor = UIColor.black.cgColor
        retButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        retButton.translatesAutoresizingMaskIntoConstraints = false
        retButton.addTarget(self, action: #selector(FinishViewController.backScene), for: .touchUpInside)
        return retButton
    }()
    
    private func setupMain() {
        funText.topAnchor.constraint(equalTo: view.topAnchor, constant: 55).isActive = true
        funText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scoreText.topAnchor.constraint(equalTo: funText.bottomAnchor, constant: 55).isActive = true
        scoreText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        finishButton.topAnchor.constraint(equalTo: scoreText.bottomAnchor, constant: 100).isActive = true
        finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func backScene() {
        ModController.restartGame()
        performSegue(withIdentifier: "exitFinish", sender: nil)
    }
    
    @objc func swipGest(gesture:UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                backScene()
            case UISwipeGestureRecognizer.Direction.left:
                backScene()
            default:
                break
            }
        }
    }
    
    

}
