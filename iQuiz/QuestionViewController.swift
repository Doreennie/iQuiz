//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by iGuest on 11/14/17.
//  Copyright © 2017 iGuest. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    var selected = ""
    var category = ""
    var answer = ""
    var questions = [Any]()
    var allQuestions = [[String: String]]()
    var allAnswers = [[String]]()
    
    var index: Int = 0
    var numCorrect: Int = 0
    var currentA: String = ""
    var onQuestion = true
    
    
    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var results: UIButton!
    
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var MessageLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var Next: UIBarButtonItem!
    
    @IBAction func nextAction(_ sender: Any) {
     index = index + 1
        print("index is \(index)")
        print("count all : \(allAnswers.count)")
        print("correct is \(numCorrect)")
        if (index < allAnswers.count) {
        loadQuestionView()
        button1.setTitle(allAnswers[index][0], for: .normal)
        button2.setTitle(allAnswers[index][1], for: .normal)
        button3.setTitle(allAnswers[index][2], for: .normal)
        button4.setTitle(allAnswers[index][3], for: .normal)
        Next.isEnabled = false
        } else {
            results.isHidden = false
        }
        
    }
    
    @IBAction func submit(_ sender: Any) {
        start()
    }
    
    @IBAction func act1(_ sender: UIButton)
    {
        selected = sender.titleLabel!.text!
    }
    
    @IBAction func act2(_ sender: UIButton) {
        selected = sender.titleLabel!.text!
    }
    
    @IBAction func act3(_ sender: UIButton) {
        selected = sender.titleLabel!.text!
    }
    
    @IBAction func act4(_ sender: UIButton) {
        selected = sender.titleLabel!.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        answerLabel.isHidden = true
        MessageLabel.isHidden = true
        Next.isEnabled = false
        button1.setTitle(allAnswers[index][0], for: .normal)
        button2.setTitle(allAnswers[index][1], for: .normal)
        button3.setTitle(allAnswers[index][2], for: .normal)
        button4.setTitle(allAnswers[index][3], for: .normal)
        question.text = allQuestions[index]["text"]
        results.isHidden = true
    }
    
    func loadData() {
        for obj in questions as! [[[String: Any]]] {
            for things in obj {
                let qtext = things["text"] as! String
                let aindex = things["answer"] as! String
                let q_a = ["text": qtext, "answer": aindex]
                allQuestions.append(q_a)
                let a = things["answers"] as! [String]
                allAnswers.append(a)
            }
        }
    }
    
    func loadQuestionView () {
        button1.isHidden = false
        button2.isHidden = false
        button3.isHidden = false
        button4.isHidden = false
        submitButton.isHidden = false
        question.isHidden = false
        answerLabel.isHidden = true
        MessageLabel.isHidden = true
        question.text = allQuestions[index]["text"]
    }
    func loadResultsView() {
        button1.isHidden = true
        button2.isHidden = true
        button3.isHidden = true
        button4.isHidden = true
        submitButton.isHidden = true
        question.isHidden = true
        answerLabel.isHidden = false
        MessageLabel.isHidden = false
    }
    
    func start() {
            let rightIndex = Int(allQuestions[index]["answer"]!)
            answer = allAnswers[index][rightIndex! - 1]
            if selected == answer {
                loadResultsView()
                answerLabel.text = "The correct answer was \(answer)"
                MessageLabel.text = "You got it right!"
                numCorrect = numCorrect + 1
            } else {
                loadResultsView()
                answerLabel.text = "The correct answer was \(answer)"
                MessageLabel.text = "You got it wrong!"
            }
        Next.isEnabled = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier != "BackQuestion" {
        let toResult = segue.destination as! SummaryViewController
        toResult.right = numCorrect
        toResult.total = allAnswers.count
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
