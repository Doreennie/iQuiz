//
//  ViewController.swift
//  TableView
//
//  Created by iGuest on 10/31/17.
//  Copyright © 2017 iGuest. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate {
    
    let url_string = "http://tednewardsandbox.site44.com/questions.json"
    var quizzes = [[String: Any]]()
    
    var subjects = [String]()
    var subtitle = [String]()
    var questions = [Any]()
    var test = Array<[String : Any]>()
    var textInput = ""
    
    
    @IBAction func submit(_ sender: Any) {
        
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cellToq", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "cellToq") {
            let controller = segue.destination as! QuestionViewController
            let currentPath = self.tableView.indexPathForSelectedRow!
            let quizCategory = subjects[currentPath[1]]
            controller.category = quizCategory
            let qCategory = questions[currentPath[1]]
            controller.questions = [qCategory]
            
        }
        if segue.identifier == "popover" {
            let popoverViewController = segue.destination
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            popoverViewController.popoverPresentationController!.delegate = self
            
        }
    }
    
 
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        var cell = tableView.dequeueReusableCell(withIdentifier: "subjectCell", for: indexPath)
        cell = UITableViewCell(style: UITableViewCellStyle.subtitle,
                               reuseIdentifier: "UITableViewCell")
        cell.textLabel?.text = subjects[indexPath.row]
        cell.detailTextLabel?.text = subtitle[indexPath.row]
        if cell.textLabel?.text == "Science!" {
            cell.imageView?.image = UIImage(named: "icons8-test-tube-filled")
        } else if cell.textLabel?.text == "Marvel Super Heroes" {
            cell.imageView?.image = UIImage(named: "icons8-superman-filled")
        } else {
            cell.imageView?.image = UIImage(named: "icons8-math-filled")
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (UIApplication.shared.delegate as! AppDelegate).subjects.count
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "subjectCell")
        getJsonFromUrl(JSON_URL: url_string)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readJSON(dir : String) {
        do {
            if let file = Bundle.main.url(forResource: dir, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [Any] {
                    // json is an array
                    print(object)
                    parseJSON(json_data: object as! Array<[String : Any]>)
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveToJsonFile() {
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        let fileUrl = documentDirectoryUrl.appendingPathComponent("output.json")
        // Transform array into data and save it into file
        do {
            let data = try JSONSerialization.data(withJSONObject: test, options: [])
            try data.write(to: fileUrl, options: [])
        } catch {
            print(error)
        }
    }
    
  
    func getJsonFromUrl(JSON_URL: String) {
        let urlRequest = URLRequest(url: URL(string: JSON_URL)!)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET")
                print(error!)
                self.readJSON(dir: "local_json")
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                self.readJSON(dir: "local_json")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let JSON = try JSONSerialization.jsonObject(with: responseData)
                    as? Array<[String: Any]> else {
                        print("error trying to convert data to JSON")
                        return
                }
                self.test = JSON
                self.saveToJsonFile()
                //self.readJSON(dir: "output")
                self.parseJSON(json_data: JSON)
            } catch  {
                print("error trying to convert data to JSON")
                self.readJSON(dir: "local_json")
                return
            }
        }
        task.resume()
    }
    

    func parseJSON(json_data: Array<[String: Any]>) {
        for quiz in json_data {
            let title = quiz["title"] as! String
            let desc = quiz["desc"] as! String
            var q = [String: Any]() // stores a subject -> title, caption
            q["title"] = title
            q["desc"] = desc
            var allQuestions = [[String: Any]]()
            for question in quiz["questions"] as! [AnyObject] {
                var single = [String: Any]() // a single question -> textq, rightanswer, all answers
                let qText = question["text"] as! String
                let rightIndex = question["answer"] as! String
                single["text"] = qText
                single["answer"] = rightIndex //
                let allAnswers = question["answers"] as! [AnyObject]
                var allAnswersArr = [String]() // all answers
                for ans in allAnswers {
                    allAnswersArr.append(ans as! String)
                }
                single["answers"] = allAnswersArr
                allQuestions.append(single) // stores single question
                q["questions"] = allQuestions
                
            }
            quizzes.append(q as [String : Any])
            
        }
        for quiz in quizzes {
            subjects.append(quiz["title"] as! String)
            subtitle.append(quiz["desc"] as! String)
            questions.append(quiz["questions"] as Any)
            
        }
        
    }
    
    
    
//    @IBAction func Setting(_ sender: Any) {
//        let alertController = UIAlertController(title: "Settings", message:
//            "OK!", preferredStyle: UIAlertControllerStyle.alert)
//        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
//
//        self.present(alertController, animated: true, completion: nil)
    //}
}

