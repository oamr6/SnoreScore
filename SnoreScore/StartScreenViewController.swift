//
//  StartScreenViewController.swift
//  SnoreScore
//
//  Created by MU IT Program on 2/19/16.
//  Copyright © 2016 Corey Matzat. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {

    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientLayer.frame = self.view.bounds
        
        // 3
        
        let color1 = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 204.0/255.0, alpha: 1.0).CGColor as CGColorRef
        let color2 = UIColor(red: 47.0/255.0, green: 47.0/255.0, blue: 144.0/255.0, alpha: 1.0).CGColor as CGColorRef

        gradientLayer.colors = [color1, color2]
        
        // 4
        gradientLayer.locations = [0.2, 1.0]
        
        // 5
        //self.view.layer.addSublayer(gradientLayer)
        
        NSUserDefaults.standardUserDefaults().setInteger(8, forKey: "numberTimes")
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func goToCalibrate(sender: AnyObject)
    {
        if let viewController = storyboard?.instantiateViewControllerWithIdentifier("PrepareCal") as? PrepareCalibrationViewController{
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    @IBAction func goToSnoreRecorder(sender: AnyObject)
    {
        if let viewController = storyboard?.instantiateViewControllerWithIdentifier("SnoreRecorder") as? SnoreRecorderViewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    @IBAction func goToSettings(sender: AnyObject) {
        if let viewController = storyboard?.instantiateViewControllerWithIdentifier("Settings") as? SettingTableViewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}