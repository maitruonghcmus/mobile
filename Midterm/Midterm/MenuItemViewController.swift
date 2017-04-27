//
//  MenuItemViewController.swift
//  Midterm
//
//  Created by An Le on 4/27/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit
protocol ReloadMenuItemTableDelegate{
    func reload()
}

class MenuItemViewController: UIViewController {
    //MARK: *** DATA MODELS
    
    var delegate : ReloadMenuItemTableDelegate? = nil
    var menuitem = MenuItem()
    //MARK: *** UI ELEMENTS
    @IBOutlet weak var typeSwitch: UISwitch!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    
    //MARK: *** UI EVENT
    
    @IBAction func btnSave_Tapped(_ sender: Any) {
        
        let result = self.DataValidate()

        if result.isEmpty {
            
            let type : Int = typeSwitch.isOn == true ? 1 : 0
            menuitem.MenuItemType = type
            menuitem.Name = txtName.text!
            menuitem.Description = txtDescription.text!
            menuitem.Price = Double(txtPrice.text!)!
            
            if menuitem.Id == 0 {
                if DataContext.Instance.MenuItems.insert(value: menuitem).Id != 0 {
                    AppUtils.DisplayAlertMessage(title: "Success", message: "Menuitem created", controller: self)
                    delegate?.reload()
                }else {
                    AppUtils.DisplayAlertMessage(title: "Error", message: "some error occurred", controller: self)
                }
            }
            else {
                if DataContext.Instance.MenuItems.update(value: menuitem) == true {
                    AppUtils.DisplayAlertMessage(title: "Success", message: "Menuitem updated", controller: self)
                    delegate?.reload()
                }else {
                    AppUtils.DisplayAlertMessage(title: "Error", message: "some error occurred", controller: self)
                }
            }
        }
        else{
            AppUtils.DisplayAlertMessage(title: "Warning", message: result, controller: self)
        }
    }
    
    func DataValidate() -> String{
        var result = ""
        
        if txtName.text!.isEmpty {
            result += "You must enter the valid name \n"
        }
        
        if txtDescription.text!.isEmpty {
            result += "You must enter the valid Description \n"
        }
        
        if txtPrice.text!.isEmpty {
            result += "You must enter the valid Price \n"
        }
        
        return result
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.menuitem.Id != 0 {
            txtName.text = self.menuitem.Name
            txtDescription.text = self.menuitem.Description
            txtPrice.text = String(self.menuitem.Price)
            let type : Bool = self.menuitem.MenuItemType == 1 ? true : false
            typeSwitch.setOn(type, animated: true)
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
