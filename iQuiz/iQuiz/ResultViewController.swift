//
//  ResultViewController.swift
//  iQuiz
//
//  Created by iGuest on 11/14/17.
//  Copyright © 2017 iGuest. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var isTrue = false
    var corranswer = ""
    
    @IBOutlet weak var indicateMessage: UILabel!
    @IBOutlet weak var correctAnswer: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog(corranswer)
        correctAnswer.text = corranswer
        if isTrue == false {
            indicateMessage.text = "You got it wrong"
        } else {
            indicateMessage.text = "You got it right!"
        }

        // Do any additional setup after loading the view.
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
