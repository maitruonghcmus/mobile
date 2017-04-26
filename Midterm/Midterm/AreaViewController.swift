//
//  AreaViewController.swift
//  Midterm
//
//  Created by An Le on 4/23/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit
import Foundation

class AreaViewController: UIViewController,
    UICollectionViewDelegateFlowLayout,
    UICollectionViewDataSource,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate  {

    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textDescription: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var imagepicker = UIImagePickerController()
    
    var area:Area = Area()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        // set property when area id != 0
        if self.area.Id != 0 {
            textName.text = area.Name
            textDescription.text = area.Description
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickAddImage(_ sender: Any) {
        imagepicker.allowsEditing = false
        imagepicker.sourceType = .photoLibrary
        imagepicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagepicker, animated: true, completion: nil)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return area.Images.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell  {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewcell", for: indexPath) as! CollectionViewCell
        let data = NSData(contentsOf: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(area.Images[indexPath.row]))
        cell.imageView.image = UIImage(data: data! as Data)
        return cell
    }
    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickSave() {
        
        if textName.text!.isEmpty{
            AppUtils.DisplayAlertMessage(title: "Error", message: "You must enter a name of area", controller: self)
        }
        else{
            performSegue(withIdentifier: "UnwindSegueToAreaTableViewID", sender: nil)
        }
    }
    
    
  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "UnwindSegueToAreaTableViewID" {
            let destination = segue.destination as! AreaTableViewController
            // update property
            self.area.Name = textName.text!
            self.area.Description = textDescription.text!
            // check id = 0 do insert and id != 0 do update
            if self.area.Id == 0 {
                DataContext.Instance.Areas.insert(value: self.area)
            }
            else {
                DataContext.Instance.Areas.update(value: area)
            }
            // call reload areas in AreaTableViewController
            destination.loadData()
            destination.tableView.reloadData()
        }
    }
}
