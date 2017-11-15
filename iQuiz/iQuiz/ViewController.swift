//
//  ViewController.swift
//  TableView
//
//  Created by iGuest on 10/31/17.
//  Copyright © 2017 iGuest. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cellToq", sender: self)
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        NSLog("indexPath: \(indexPath)")
        var cell = tableView.dequeueReusableCell(withIdentifier: "subjectCell", for: indexPath)
        cell = UITableViewCell(style: UITableViewCellStyle.subtitle,
                               reuseIdentifier: "UITableViewCell")
        
        cell.textLabel?.text = (UIApplication.shared.delegate as! AppDelegate).subjects[indexPath.row]
        cell.detailTextLabel?.text = (UIApplication.shared.delegate as! AppDelegate).subtitle[indexPath.row]
        cell.imageView?.image = (UIApplication.shared.delegate as! AppDelegate).images[indexPath.row]
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Setting(_ sender: Any) {
        let alertController = UIAlertController(title: "Settings", message:
            "OK!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
