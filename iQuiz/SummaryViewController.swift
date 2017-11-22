//
//  SummaryViewController.swift
//  iQuiz
//
//  Created by iGuest on 11/14/17.
//  Copyright © 2017 iGuest. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {
    var right = 0
    var total = 0
    
 
    @IBOutlet weak var summary: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if right/total < 1 {
           summary.text = "You got \(right) out of \(total) correct. Try harder!"
        } else {
            summary.text = "You got \(right) out of \(total) correct. Nice job!"
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
