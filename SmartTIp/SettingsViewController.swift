//
//  SettingsViewController.swift
//  SmartTIp
//
//  Created by Kelvin Lui on 12/16/17.
//  Copyright © 2017 Kelvin Lui. All rights reserved.
//
import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet private(set) weak var numberOfPeopleLabel: UILabel!
    @IBOutlet private(set) weak var percentageLabel: UILabel!
    @IBOutlet private weak var numberOfPeopleStepper: UIStepper!
    @IBOutlet private weak var percentageStepper: UIStepper!
    private let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load tip percentage and number of people preferences from user defaults
        numberOfPeopleStepper.value = Double(defaults.integer(forKey: "numberOfPeopleDefault"))
        percentageStepper.value = Double(defaults.integer(forKey: "tipPercentageDefault"))
        defaults.synchronize()
        
        updateLabels()
    }
    
    @IBAction private func numberOfPeopleValueChanged(_ sender: UIStepper) {
        updateLabels()
        defaults.set(numberOfPeopleStepper.value, forKey: "numberOfPeopleDefault")
    }
    
    @IBAction private func percentageValueChanged(_ sender: UIStepper) {
        updateLabels()
        defaults.set(percentageStepper.value, forKey: "tipPercentageDefault")
    }
    
    private func updateLabels() {
        numberOfPeopleLabel.text =  numberOfPeopleStepper.value > 1 ? "\(Int(numberOfPeopleStepper.value).description) people" : "\(Int(numberOfPeopleStepper.value).description) person"
        percentageLabel.text = "\(Int(percentageStepper.value).description) %"
    }
    
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
