//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by iGuest on 11/14/17.
//  Copyright © 2017 iGuest. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    var answer = "3"
    var q = "What is the square root of 9?"
    var selected = ""
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
 
   
    
//    sender.setTitle("buttonName", for: .normal)
    
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
        button1.setTitle("3", for: .normal)
        button2.setTitle("1", for: .normal)
        button3.setTitle("2", for: .normal)
        button4.setTitle("5", for: .normal)
        question.text = q
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let toResult = segue.destination as! ResultViewController
        let isEqual = (answer == selected)
        toResult.isTrue = isEqual
        toResult.corranswer = answer
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
