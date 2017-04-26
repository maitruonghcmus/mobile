//
//  TableViewController.swift
//  Midterm
//
//  Created by Truong Mai on 4/26/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    //MARK: *** DATA MODELS
    
    var selectedArea : Area = Area()
    
    
    //MARK: *** UI ELEMENTS
    
    @IBOutlet weak var txtTableNumber: UITextField!
    @IBOutlet weak var txtArea: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    
    //MARK: *** UI EVENT
    
    @IBAction func btnSave_Tapped(_ sender: Any) {
        
        let tableNumber = txtTableNumber.text!
        let area = txtArea.text!
        let description = txtDescription.text!
        
        let result = self.DataValidate(tableNumber: tableNumber, area: area, description: description)
        
        if result.isEmpty {
            let table = Table(Id: Int(tableNumber)!, Description: description, Images: [String](), Area: selectedArea, TableStatus: 1)
            _ = DataContext.Instance.Tables.insert(value: table)
//            if isSuccess != nil {
//                
//            }
//            else {
//                AppUtils.DisplayAlertMessage(title: "Error", message: "some error occurred", controller: self)
//            }
        }
        else{
            AppUtils.DisplayAlertMessage(title: "Warning", message: result, controller: self)
        }
    }
    
    
    @IBAction func btnAddImage_Tapped(_ sender: Any) {
        
    }
    
    //MARK: *** CUSTOM FUNCTION
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func DataValidate(tableNumber: String, area: String, description: String) -> String{
        var result = ""
        
        if tableNumber.isEmpty {
            result += "You must enter the valid Table Number \n"
        }
        
        if area.isEmpty {
            result += "Please select the Area \n"
        }
        
        return result
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
