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

    //MARK: - VARIABLE
    var imagepicker = UIImagePickerController()
    var area:Area = Area()
    
    
    //MARK: - UI ELEMENT
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textDescription: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK: - CUSTOM FUNCTION
    func load(refresh : Bool) {
        if refresh == true {
            area = Area()
        }
        // set property when area id != 0
        if self.area.Id != 0 {
            textName.text = area.Name
            textDescription.text = area.Description
        }
    }
    
    //MARK: - UI EVENT
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        self.load(refresh:false)
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
    
    @IBAction func clickSave(_ sender: Any) {
        self.area.Name = textName.text!
        self.area.Description = textDescription.text!
        // check id = 0 do insert and id != 0 do update
        if self.area.Id == 0 {
            if DataContext.Instance.Areas.insert(value: self.area).Id != 0 {
                AppUtils.DisplayAlertMessage(title: "Success", message: "Area created", controller: self)
                self.load(refresh:true)
            }
            else {
                AppUtils.DisplayAlertMessage(title: "Error", message: "Area created fail", controller: self)
            }
        }
        else {
            if DataContext.Instance.Areas.update(value: area) == true {
                AppUtils.DisplayAlertMessage(title: "Success", message: "Area updated", controller: self)
            }
            else {
                AppUtils.DisplayAlertMessage(title: "Error", message: "Area updated fail", controller: self)
            }
        }
    }
    
    //MARK: - COLLECTION VIEW
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return area.Images.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell  {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewcell", for: indexPath) as! CollectionViewCell
        let data = AppUtils.GetImageData(name: area.Images[indexPath.row].Path)
        cell.imageView.image = UIImage(data: data)
        return cell
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
