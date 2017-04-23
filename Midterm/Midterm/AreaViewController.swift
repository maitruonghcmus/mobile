//
//  AreaViewController.swift
//  Midterm
//
//  Created by An Le on 4/23/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

class AreaViewController: UIViewController {

    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textDescription: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueShowAreaID" {
            let destination = segue.destination as! AreaTableViewController
            let area = Area(Id: 0, Name: textName.text!, Description: textDescription.text!, Images: [String]())
            Area.insert(value: area)
            destination.areas = Area.all()
            destination.tableView.reloadData()
        }
    }
    @IBAction func clickAddImage(_ sender: Any) {
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
