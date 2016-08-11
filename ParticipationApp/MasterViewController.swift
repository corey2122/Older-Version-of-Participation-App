//
//  MasterViewController.swift
//  ParticipationApp
//
//  Created by CJS  on 7/21/16.
//  Copyright © 2016 CJS . All rights reserved.
//

import UIKit

class MasterViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var flow = UICollectionViewFlowLayout()
    //Simple array
    var dataArray = [String]()
    var className = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Class/Hour"
        dataArray = ["World History", "English 2", "1st Hour", "APUSH", "2nd Hour", "English 2", "Health"]
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MasterViewController.rotated), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        flow = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
      
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        rotated()
        
    }
    
    func rotated()
    {
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {
         
            let height = UIScreen.mainScreen().bounds.size.height - 50;
            flow.itemSize = CGSizeMake(height/2.25, height/2.25)
            flow.minimumInteritemSpacing = 4
            flow.minimumLineSpacing = 55
            print("landscape from master")
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {
           
            let height = UIScreen.mainScreen().bounds.size.height;
            flow.itemSize = CGSizeMake(height/4.5, height/4.5)
            flow.minimumInteritemSpacing = 0
            flow.minimumLineSpacing = 10
            print("Portrait from master")
        }
       self.collectionView?.reloadData()
    }
    
    
    @IBAction func AddButton(sender: UIBarButtonItem) {
        print("pressed")
                //Alert View for Student Name
        
        let alertController = UIAlertController(title: "Class Name", message:
                    nil, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addTextFieldWithConfigurationHandler() { (textField:UITextField!) -> Void in  textField.autocorrectionType = UITextAutocorrectionType.Yes;
            textField.autocapitalizationType = UITextAutocapitalizationType.Words
        }
        
        alertController.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.Default,handler: {(action) -> Void in
                    
                    let textf = alertController.textFields![0] as UITextField
                    // if let statement to get text of textField
                    if let classNameStr = textf.text where !classNameStr.isEmpty{
                        print(classNameStr)
                        self.dataArray.append(classNameStr)
                        self.collectionView!.reloadData()
                    }
                }))
        
        
                alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {(action) -> Void in
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                }))
            
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }
    

    //Simple array
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    //cell information
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ClassCell

        //shadow
//        cell.layer.masksToBounds = false;
//        cell.layer.shadowOpacity = 0.5;
//        cell.layer.shadowRadius = 10.0;
//        cell.layer.shouldRasterize = false;
        
        cell.layer.borderWidth = 10
        cell.layer.borderColor = ColorManager().colorFromRGBHexString("966C4D").CGColor //brown
        cell.layer.backgroundColor = UIColor.clearColor().CGColor //clear
        cell.layer.cornerRadius = cell.frame.size.width/2
        cell.clipsToBounds = true
        
        cell.layer.shadowColor = UIColor.darkGrayColor().CGColor
        cell.layer.shadowOffset = CGSizeMake(0, 5)
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 5
        cell.clipsToBounds = false
        cell.layer.masksToBounds = false
        cell.layer.shouldRasterize = false;
        
        //circle inside
        cell.classViewCell.layer.borderWidth = 5
        cell.classViewCell.layer.borderColor = ColorManager().colorFromRGBHexString("D8D8D8").CGColor //silver
        cell.classViewCell.layer.backgroundColor = ColorManager().colorFromRGBHexString("2E2E2E").CGColor //black
        cell.classViewCell.layer.cornerRadius = cell.classViewCell.frame.size.width/2
        print("width: \(cell.classViewCell.frame.size.width)")
        cell.classViewCell.clipsToBounds = true
        
        cell.classNameLabel.text = dataArray[indexPath.row]
        print("Cell Info was called")
        
        
            return cell

    }
    


    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //perform segue with identifier
       
        className = dataArray[indexPath.row]
    }
    
    func collectionView(collectionView: UICollectionView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
            return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //prepare for segue and pass data
            if segue.identifier == "MySegue" {
                print ("Call Segue")
                NSNotificationCenter.defaultCenter().removeObserver(self)
                //get index path of cell
               let indexPath = collectionView!.indexPathForCell(sender as! ClassCell)
                className = dataArray[indexPath!.row]
                let svc = segue.destinationViewController as! DeskViewController;
                svc.newVariable = className
            }
        }
}

