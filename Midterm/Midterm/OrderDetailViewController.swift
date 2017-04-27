//
//  OrderDetailViewController.swift
//  Midterm
//
//  Created by An Le on 4/27/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

class OrderDetailViewController: UIViewController {
    var detail = OrderDetail()
    @IBOutlet weak var textName: UILabel!
    @IBOutlet weak var textPrice: UILabel!
    @IBOutlet weak var textQuantity: UITextField!
    @IBOutlet weak var textTotal: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textName.text = detail.MenuItem?.Name
        textPrice.text = AppUtils.formatPrice(value: (detail.MenuItem?.Price)!)
        textQuantity.text = "\(detail.Quantity)"
        textTotal.text = AppUtils.formatPrice(value: (detail.MenuItem?.Price)! * Double(detail.Quantity))
    }
    @IBAction func changeQuantity(_ sender: Any) {
        textTotal.text = AppUtils.formatPrice(value: (detail.MenuItem?.Price)! * Double(detail.Quantity))
    }
    
    @IBAction func saveClick(_ sender: Any) {
        detail.Quantity = Int(textQuantity.text!)!
        detail.Amount = (detail.MenuItem?.Price)! * Double(textQuantity.text!)!
        if DataContext.Instance.OrderDetails.update(value: detail) == true {
            dismiss(animated: true, completion: nil)
        }else {
            AppUtils.DisplayAlertMessage(title: "Error", message: "some error occurred", controller: self)
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
