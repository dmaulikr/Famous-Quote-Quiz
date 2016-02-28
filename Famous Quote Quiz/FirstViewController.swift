//
//  FirstViewController.swift
//  Famous Quote Quiz
//
//  Created by Ivaylo Todorov on 26.02.16 г..
//  Copyright © 2016 г. Ivaylo Todorov. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
   
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var binarySuggestAnswerLabel: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var newGame: UIButton!
    
// struct to collect all questions information
    struct question {
        var question: String!
        var answers: [String]!
        var IntAnswer: Int!
        var boolAnswer: Bool!
        var stringAnswer: String!
        var binarySuggestion: String!
    }
    
    var gameOver = false
    var allQuestions = [question]()
    var questions = [question]()
    var questionNumber = Int()
    var buttonsArray: [UIButton] = [UIButton]()
    var answersNumber = Int()
    var answersBool = Bool()
    var answerString = String()
    var choosenAnswer = Int()
    var correctAnswers = Int()
    var incorrectAnswers = Int()
    var yesBut = true
    var noBut = false


// function of modal popup message for Next Question
    func displayAlert(title: String, answerIs: String) {
        
        let alert = UIAlertController(title: title, message: answerIs, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK, next question!", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
// info from http://stackoverflow.com/questions/32606469/swift-quiz-reset-button

        func pickQuestion() {
       
            if questions.count > 0 {
            
            questionNumber = random() % questions.count
            questionLabel.text = questions[questionNumber].question
            answersNumber = questions[questionNumber].IntAnswer
            answersBool = questions[questionNumber].boolAnswer
            answerString = questions[questionNumber].stringAnswer
            binarySuggestAnswerLabel.text = questions[questionNumber].binarySuggestion
            
            for i in 0..<buttonsArray.count {
                buttonsArray[i].setTitle(questions[questionNumber].answers[i], forState: UIControlState.Normal)
            }
            
            questions.removeAtIndex(questionNumber)
            
        } else {
            
            gameOver = true
            
            if gameOver == true {

                newGame.hidden = false
                button1.hidden = true
                button2.hidden = true
                button3.hidden = true
                yesButton.hidden = true
                noButton.hidden = true
                binarySuggestAnswerLabel.hidden = true
                questionLabel.text = ("Congratulations! You have \(correctAnswers) correct and \(incorrectAnswers) incorrect answers!")
          
            }
            
        }
    
    }
    
// when "New Game" button is pressed
    @IBAction func newGamePress(sender: AnyObject) {
        
        questions = allQuestions
        gameOver = false
        correctAnswers = 0
        incorrectAnswers = 0
        newGame.hidden = true
        button1.hidden = true
        button2.hidden = true
        button3.hidden = true
        yesButton.hidden = false
        noButton.hidden = false
        binarySuggestAnswerLabel.hidden = false
        questionLabel.text = ""
        pickQuestion()

        NSNotificationCenter.defaultCenter().postNotificationName("switchReset", object: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
// questions from http://www.businessballs.com/quizballs/quizballs59_free_trivia_quiz_questions_answers.htm
       
        allQuestions = [
            question(question:
                "Which singer joined Mel Gibson in the movie Mad Max: Beyond The Thunderdome?",
                answers: ["TINA TURNER", "MICHAEL JACKSON", "BRYAN ADAMS"], IntAnswer: 1, boolAnswer: true, stringAnswer: "TINA TURNER", binarySuggestion: "TINA TURNER ?"),
            question(question:
                "Vodka, Galliano and orange juice are used to make which classic cocktail?",
                answers: ["BLOODY MARY", "HARVEY WALLBANGER", "DAIQUIRI RECIPES"], IntAnswer: 2, boolAnswer: false, stringAnswer: "HARVEY WALLBANGER", binarySuggestion: "BLOODY MARY ?"),
            question(question:
                "Which American state is nearest to the former Soviet Union?",
                answers: ["ALASKA", "NEVADA", "NEW YORK"], IntAnswer: 1, boolAnswer: false, stringAnswer: "ALASKA", binarySuggestion: "NEW YORK ?"),
            question(question:
                "In which year did Foinavon win the Grand National?",
                answers: ["2001", "1999", "1967"], IntAnswer: 3, boolAnswer: true, stringAnswer: "1967", binarySuggestion: "1967 ?"),
            question(question:
                "In what year was Prince Andrew born?",
                answers: ["1900", "1950", "1960"], IntAnswer: 3, boolAnswer: false, stringAnswer: "1960", binarySuggestion: "1900 ?"),
            question(question:
                "Consecrated in 1962, where is the Cathedral Church of St Michael?",
                answers: ["COVENTRY", "MANCHESTER", "LONDON"], IntAnswer: 1, boolAnswer: true, stringAnswer: "COVENTRY", binarySuggestion: "COVENTRY ?"),
            question(question:
                "On TV, who did the character Lurch work for?",
                answers: ["FRIENDS", "ADDAMS FAMILY", "THE X FILES"], IntAnswer: 2, boolAnswer: true, stringAnswer: "ADDAMS FAMILY", binarySuggestion: "ADDAMS FAMILY ?"),
            question(question:
                "Which children's classic book was written by Anna Sewell?",
                answers: ["BLACK BEAUTY", "WHITE BEAUTY", "ORANGE BEAUTY"], IntAnswer: 1, boolAnswer: false, stringAnswer: "BLACK BEAUTY", binarySuggestion: "ORANGE BEAUTY ?"),
            question(question:
                "What is converted into alcohol during brewing?",
                answers: ["SUGAR", "SALT", "PEPER"], IntAnswer: 1, boolAnswer: false, stringAnswer: "SUGAR", binarySuggestion: "SALT ?"),
            question(question:
                "Which river forms the eastern section of the border between England and Scotland?",
                answers: ["AMAZONKA", "TWEED", "MARITSA"], IntAnswer: 2, boolAnswer: false, stringAnswer: "TWEED", binarySuggestion: "MARITSA ?")]

        questions = allQuestions
        
        
// info from https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSNotificationCenter_Class/
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "switchTappedON:", name:"SwitchTapON", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "switchTappedOFF:", name:"SwitchTapOFF", object: nil)
        
        self.buttonsArray = [self.button1, self.button2, self.button3]
        
        
        
// start game in default binary mode
        
        if gameOver == false   {

            newGame.hidden = true
            button1.hidden = true
            button2.hidden = true
            button3.hidden = true
            yesButton.hidden = false
            noButton.hidden = false
            binarySuggestAnswerLabel.hidden = false
            pickQuestion()
            
        }
        
// to test multiple Game mode separate
//        else if gameOver == true {
//            
//            button1.hidden = false
//            button2.hidden = false
//            button3.hidden = false
//            yesButton.hidden = true
//            noButton.hidden = true
//            binarySuggestAnswerLabel.hidden = true
//            pickQuestion()
//        }

        }
    

// when switch toggle changed to OFF
    func switchTappedOFF(notification: NSNotification) {
       
        questions = allQuestions
        pickQuestion()
        correctAnswers = 0
        incorrectAnswers = 0
        newGame.hidden = true
        button1.hidden = true
        button2.hidden = true
        button3.hidden = true
        yesButton.hidden = false
        noButton.hidden = false
        binarySuggestAnswerLabel.hidden = false
        
        }
    
// when switch toggle changed to ON
    func switchTappedON(notification: NSNotification) {
        
        questions = allQuestions
        pickQuestion()
        correctAnswers = 0
        incorrectAnswers = 0
        newGame.hidden = true
        button1.hidden = false
        button2.hidden = false
        button3.hidden = false
        yesButton.hidden = true
        noButton.hidden = true
        binarySuggestAnswerLabel.hidden = true

        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
    }
    
    
// binary choise Game buttons

    @IBAction func yesButtonPressed(sender: AnyObject) {
        
        if yesBut == answersBool {
           
            displayAlert("Correct! The right answer is:", answerIs: answerString)
            correctAnswers++
            
        } else {
            
            displayAlert("Sorry, you are wrong! The right answer is:", answerIs: answerString)
            incorrectAnswers++
        }
        
        pickQuestion()
    }
    
    
    @IBAction func noButtonPressed(sender: AnyObject) {
        
        
        if noBut == answersBool {
            
            displayAlert("Correct! The right answer is:", answerIs: answerString)
            correctAnswers++
            
        } else {
            
            displayAlert("Sorry, you are wrong! The right answer is:", answerIs: answerString)
            incorrectAnswers++
        
        }
        
        pickQuestion()
    }

    
// multiple choise Game buttons
    
    @IBAction func clickButton1(sender: AnyObject) {
       
        choosenAnswer = 1
        if answersNumber == choosenAnswer {
        
            
            displayAlert("Correct! The right answer is:", answerIs: answerString)
            correctAnswers++
        
        } else {
          
            displayAlert("Sorry, you are wrong! The right answer is:", answerIs: answerString)
            incorrectAnswers++
        }
        
        pickQuestion()
        
    }
    
    @IBAction func clickButton2(sender: AnyObject) {
      
        choosenAnswer = 2
        if answersNumber == choosenAnswer {
           
            displayAlert("Correct! The right answer is:", answerIs: answerString)
            correctAnswers++
       
        } else {
            
            displayAlert("Sorry, you are wrong! The right answer is:", answerIs: answerString)
            incorrectAnswers++
        }
        
        pickQuestion()
   
    }
    
    
    @IBAction func clickButton3(sender: AnyObject) {
    
        choosenAnswer = 3
        if answersNumber == choosenAnswer {
     
            displayAlert("Correct! The right answer is:", answerIs: answerString)
            correctAnswers++
       
        } else {
            
            displayAlert("Sorry, you are wrong! The right answer is:", answerIs: answerString)
            incorrectAnswers++
        }
        
        pickQuestion()
   
    }

}