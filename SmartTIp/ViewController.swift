//
//  ViewController.swift
//  SmartTIp
//
//  Created by Kelvin Lui on 12/5/17.
//  Copyright © 2017 Kelvin Lui. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var totalTipLabel: UILabel!
    @IBOutlet private weak var tipForEachPersonLabel: UILabel!
    @IBOutlet private weak var totalAmountLabel: UILabel!
    @IBOutlet private weak var display: UILabel!
    private var numberOfPeople = 1.0
    private var tipPercentage = 0.15
    private var defaults = UserDefaults.standard
    
    private var textCurrentlyInDisplay = "0" {
        didSet {
            display.text = textCurrentlyInDisplay
            if textCurrentlyInDisplay == "0" {
                isInTheMiddleOfTyping = false
            }
            updateTipLabels()
            decimalIndex = textCurrentlyInDisplay.index(of: ".")
        }
    }
    private var isInTheMiddleOfTyping = false
    private var decimalIndex: String.Index? = nil
    
    private func updateTipLabels() {
        let bill = Double(textCurrentlyInDisplay)!
        totalTipLabel.text = String(format: "$%.2f", bill * tipPercentage)
        tipForEachPersonLabel.text = String(format: "$%.2f", bill * tipPercentage / Double(numberOfPeople))
        totalAmountLabel.text = String(format: "$%.2f", bill + bill * tipPercentage)
    }
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        // Do not allow user to insert more digit to the display after two decimal places
        if let di = decimalIndex {
            if (textCurrentlyInDisplay.distance(from: di, to: textCurrentlyInDisplay.endIndex) > 2) {
                return
            }
        }

        if isInTheMiddleOfTyping {
            textCurrentlyInDisplay.insert(Character(digit), at: textCurrentlyInDisplay.endIndex)
        } else {
            if digit != String(0) {
                textCurrentlyInDisplay = String(digit)
                isInTheMiddleOfTyping = true
            }
        }
    }
    
    @IBAction private func touchDel(_ sender: UIButton) {
        if(textCurrentlyInDisplay.index(before: textCurrentlyInDisplay.endIndex) > String.Index(encodedOffset: 0)) {
            textCurrentlyInDisplay.remove(at: textCurrentlyInDisplay.index(before: textCurrentlyInDisplay.endIndex))
        } else {
            textCurrentlyInDisplay = "0"
            isInTheMiddleOfTyping = false
        }
    }
    
    @IBAction private func touchDecimal(_ sender: UIButton) {
        if decimalIndex == nil {
            textCurrentlyInDisplay += "."
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        numberOfPeople = defaults.double(forKey: "numberOfPeopleDefault")
        tipPercentage = defaults.double(forKey: "tipPercentageDefault") / 100.0
        updateTipLabels() 
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
}

