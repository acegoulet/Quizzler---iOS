//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    let questionCount = QuestionBank().list.count
    var pickedAnswer = false
    var questionNumber = 0
    var score = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if(sender.tag == 1){
            pickedAnswer = true
        } else {
            pickedAnswer = false
        }
        
        checkAnswer()
    }
    
    
    func updateUI() {
        let currentQuestion = allQuestions.list[questionNumber]
        questionLabel.text = currentQuestion.questionText
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1)/\(questionCount)"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
    }
    

    func nextQuestion() {
        questionNumber += 1
        if(questionNumber < questionCount){
            updateUI()
        } else {
            let alert = UIAlertController(title: "All Done!", message: "Start over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Sure", style: .default, handler: { ( UIAlertAction ) in
                self.startOver()
            })
            
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer() {
        
        let correctAnswer = allQuestions.list[questionNumber].answer
        if(pickedAnswer == correctAnswer){
            ProgressHUD.showSuccess("HUZZAH!")
            score += 1
            
        } else {
            ProgressHUD.showError("MORON!")
        }
        nextQuestion()
    }
    
    
    func startOver() {
        questionNumber = 0
        score = 0
        updateUI()
    }
    

    
}
