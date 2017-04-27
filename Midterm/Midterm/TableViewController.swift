//
//  TableViewController.swift
//  Midterm
//
//  Created by Truong Mai on 4/26/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit
import Foundation

class TableViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    //MARK: *** DATA MODELS
    
    var selectedArea : Area = Area()
    var areas = [Area]()
    

    //MARK: *** UI ELEMENTS
    
    @IBOutlet weak var txtTableNumber: UITextField!
    @IBOutlet weak var txtArea: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    
    let areaPicker = UIPickerView()
    
    //MARK: *** UI EVENT
    
    @IBAction func btnSave_Tapped(_ sender: Any) {
        
        let tableNumber = txtTableNumber.text!
        let area = txtArea.text!
        let description = txtDescription.text!
        
        let result = self.DataValidate(tableNumber: tableNumber, area: area, description: description)
        
        if result.isEmpty {
            let table = Table(Id: Int(tableNumber)!, Description: description, Images: [String](), Area: selectedArea, TableStatus: 1)
            
            //let isSuccess = DataContext.Instance.Tables.insert(value: table)
            let isSuccess = AppContext.Instance.AddTable(table: table)
            
            if isSuccess{
                AppUtils.DisplayAlertMessage(title: "Success", message: "Table created", controller: self)
            }
            else {
                AppUtils.DisplayAlertMessage(title: "Error", message: "some error occurred", controller: self)
            }
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
        //areas = DataContext.Instance.Areas.all()
        areas = AppContext.Instance.Areas
        if(!areas.isEmpty){
            createAreaPicker()
            selectedArea = areas.first!
            txtArea.text = selectedArea.Name
            
        }else {
            AppUtils.DisplayAlertMessage(title: "Warning", message: "Data area not found", controller: self)
        }
        
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
    
    
    func DisplayAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: Picker view
    func createAreaPicker(){
        areaPicker.delegate = self
        txtArea.inputView = areaPicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(areaPickerDonePress))
        toolbar.setItems([doneButton], animated: false)
        
        txtArea.inputAccessoryView = toolbar
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return areas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return areas[row].Name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtArea.text = areas[row].Name
        selectedArea = areas[row]
    }
    
    func areaPickerDonePress(){
        self.view.endEditing(true)
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
