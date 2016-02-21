//
//  SettingTableViewController.swift
//  SnoreScore
//
//  Created by MU IT Program on 2/20/16.
//  Copyright © 2016 Corey Matzat. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferenceChanged", name: "SnoringAlert", object: nil)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func preferenceChanged()
    {
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let preference = NSUserDefaults.standardUserDefaults().boolForKey("SnoringAlertPreference")
        if preference == true
        {
            return 4
        }
        else
        {
            return 2
        }
        // #warning Incomplete implementation, return the number of rows
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var identifier = ""
        if indexPath.row == 0
        {
            identifier = "Cell1"
        }
        else if indexPath.row == 1
        {
            identifier = "Cell2"
        }
        else if indexPath.row == 2
        {
            identifier = "Cell3"
        }
        else if indexPath.row == 3
        {
            identifier = "Cell4"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        

        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class SnoringAlert: UITableViewCell
{
    @IBOutlet weak var SnoringAlertSwitch: UISwitch!
    
    override func layoutSubviews() {
        SnoringAlertSwitch.on = NSUserDefaults.standardUserDefaults().boolForKey("SnoringAlertPreference")
    }
    
    @IBAction func snoringAlertStateChange(sender: AnyObject)
    {
        NSUserDefaults.standardUserDefaults().setBool(SnoringAlertSwitch.on, forKey: "SnoringAlertPreference")
        NSNotificationCenter.defaultCenter().postNotificationName("SnoringAlert", object: nil)
    }
}
class WatchVibration: UITableViewCell
{
    @IBOutlet weak var watchVibrationAlertSwitch: UISwitch!
    override func layoutSubviews() {
        watchVibrationAlertSwitch.on = NSUserDefaults.standardUserDefaults().boolForKey("WatchAlertPreference")
    }
    @IBAction func watchVibrationAlertStateChange(sender: AnyObject)
    {
            NSUserDefaults.standardUserDefaults().setBool(watchVibrationAlertSwitch.on, forKey: "WatchAlertPreference")
    }
    
}
class AlertFrequency: UITableViewCell
{
    @IBOutlet weak var alertFrequencySlider: UISlider!
    
    override func layoutSubviews() {
        alertFrequencySlider.value = NSUserDefaults.standardUserDefaults().floatForKey("AlertFrequencyPreference")
    }
    @IBAction func alertFrequencySlideState(sender: AnyObject)
    {
        NSUserDefaults.standardUserDefaults().setFloat(alertFrequencySlider.value, forKey: "AlertFrequencyPreference")
    }
    
}
class MaxVolume: UITableViewCell
{
   
    @IBOutlet weak var maxVolumeSlider: UISlider!
    override func layoutSubviews()
    {
        maxVolumeSlider.value = NSUserDefaults.standardUserDefaults().floatForKey("MaxVolumePreference")
    }
    @IBAction func maxVolumeSliderState(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setFloat(maxVolumeSlider.value, forKey: "MaxVolumePreference")
    }
    
}

