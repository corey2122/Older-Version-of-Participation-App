//
//  DeskView.swift
//  ParticipationApp
//
//  Created by CJS  on 7/22/16.
//  Copyright © 2016 CJS . All rights reserved.
//

import UIKit

class DeskViewController: UICollectionViewController, UIGestureRecognizerDelegate, UIPopoverPresentationControllerDelegate  {
    
    @IBOutlet weak var deskTextField: UITextField!
    var random = -1
    var seatArray = [String]()
    var newVariable = String ()
    var flow = UICollectionViewFlowLayout()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        seatArray = ["Corey Schwarzkopf", "Alfred H.", "Chris", "Janet P.", "Samson Rolf", "Miranna Kutrhapualie", "Paul", "Sandy", "Smith", "", "", "", "Corey Schwarzkopf", "Alfred H.", "Chris", "Janet P.", "Samson Rolf", "Miranna Kutrhapualie", "Paul", "Sandy", "Smith", "", "", "", "Corey Schwarzkopf", "Alfred H.", "Chris", "Janet P.", "", ""]
      
        
        self.navigationItem.title = "\(newVariable)"
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DeskViewController.rotated), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        flow = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsetsMake(25, 10, 10, 10)
        
    }
        
        override func viewWillAppear(animated: Bool) {
            super.viewWillAppear(true)
            
            rotated()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(true)
        NSNotificationCenter.defaultCenter().removeObserver(self)
        print("when am I called?")
    }
    
    func rotated()
    {
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {
            
            let width = UIScreen.mainScreen().bounds.size.width - 200;
            flow.itemSize = CGSizeMake(width/7, width/7)
            flow.minimumInteritemSpacing = 25
            flow.minimumLineSpacing = 10
            print("landscape")
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {
            
            let width = UIScreen.mainScreen().bounds.size.width - 100;
            flow.itemSize = CGSizeMake(width/7, width/7)
            flow.minimumInteritemSpacing = 2
            flow.minimumLineSpacing = 25
            print("Portrait")
        }
        self.collectionView?.reloadData()
    
        print("The current value of friendlyWelcome is \(newVariable)")
    }
    
   //Random Call Button
    @IBAction func RandomCallButton(sender: UIBarButtonItem){
      self.random = Int(arc4random_uniform(UInt32(self.seatArray.count)))
      self.collectionView!.reloadData() // reloads the visible cells, highlighting the random one
      
        
        
        //popover screen
        let popoverContent = (self.storyboard?.instantiateViewControllerWithIdentifier("PresentationStudentController"))! as! PresentationStudentController
        let nav = UINavigationController(rootViewController: popoverContent)
        nav.modalPresentationStyle = UIModalPresentationStyle.Popover
        let popover = nav.popoverPresentationController
        popoverContent.preferredContentSize = CGSizeMake(500,500)
        popover!.delegate = self
    
        popover!.sourceView = self.view
        
        popover!.sourceRect = CGRectMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds),0,0)
        popover!.permittedArrowDirections.isEmpty
        popover?.permittedArrowDirections = UIPopoverArrowDirection()
        popover!.delegate = self
        self.presentViewController(nav, animated: true, completion: nil)
    }
    
         func adaptivePresentationStyle() -> UIModalPresentationStyle {
            return UIModalPresentationStyle.OverFullScreen
        }
    //For iphone presentation Popover screen
    
//    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
//        return UIModalPresentationStyle.None
//    
//    }
//    
//    func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
//        let navigationController = UINavigationController(rootViewController: controller.presentedViewController)
//        let btnDone = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(DeskViewController.dismiss))
//        navigationController.topViewController!.navigationItem.rightBarButtonItem = btnDone
//        return navigationController
//    }
//    
//    func dismiss() {
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
//        
    

    

    @IBAction func AddSeatButton(sender: UIBarButtonItem) {
        //Alert View for Student Name
        let alertController = UIAlertController(title: "Student Name:", message:
            nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addTextFieldWithConfigurationHandler () { (textField:UITextField!) -> Void in  textField.autocorrectionType = UITextAutocorrectionType.Yes;
            textField.autocapitalizationType = UITextAutocapitalizationType.Words
            }
        
       
        
        alertController.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.Default,handler: {(action) -> Void in
        
           let textf = alertController.textFields![0] as UITextField
            
            
            // if let statement to get text of textField
            if let nameStr = textf.text where !nameStr.isEmpty{
                print(nameStr)
                self.seatArray.append(nameStr)
                self.collectionView!.reloadData()
            }
            }))
        
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {(action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    
    }
        
        
   
    
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellDesk = collectionView.dequeueReusableCellWithReuseIdentifier("cellDesk", forIndexPath: indexPath) as! DeskNameCell

        //cellDesk.layer.backgroundColor = ColorManager().colorFromRGBHexString("966C4D").CGColor
        cellDesk.deskNameLabel.text = seatArray[indexPath.row]
        
        cellDesk.layer.cornerRadius = 15
        
        cellDesk.layer.shadowColor = UIColor.darkGrayColor().CGColor
        cellDesk.layer.shadowOffset = CGSizeMake(0, 5)
        cellDesk.layer.shadowOpacity = 0.5
        cellDesk.layer.shadowRadius = 10
        cellDesk.clipsToBounds = false
        cellDesk.layer.masksToBounds = false
        cellDesk.layer.shouldRasterize = false
        
        
        cellDesk.deskNameLabel.text = seatArray[indexPath.row]
       
//        print("Desk cell Info was called")
        
        // Configure the cell
        cellDesk.deskNameLabel.text = seatArray[indexPath.row]
       
        
        
        if(random == indexPath.row) {
            cellDesk.backgroundColor = UIColor.purpleColor()
        } else {
            cellDesk.layer.backgroundColor = ColorManager().colorFromRGBHexString("966C4D").CGColor
        }
        
        
        
        return cellDesk
    }

    func collectionView(collectionView: UICollectionView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    
    // Return false if you do not want the specified item to be editable.
        return true
   // }
    }
     override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return self.seatArray.count
    }
   
    override func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        // swap values if sorce and destination
        let temp = seatArray[sourceIndexPath.row]
        seatArray[sourceIndexPath.row] = seatArray[destinationIndexPath.row]
        seatArray[destinationIndexPath.row] = temp
    
            }
    
}




