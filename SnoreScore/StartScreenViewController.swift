//
//  StartScreenViewController.swift
//  SnoreScore
//
//  Created by MU IT Program on 2/19/16.
//  Copyright © 2016 Corey Matzat. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func goToCalibrate(sender: AnyObject)
    {
        if let viewController = storyboard?.instantiateViewControllerWithIdentifier("Calibration") as? CalibratingViewController{
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