//
//  ConverterViewController.swift
//  Conversion Calc
//
//  Created by knstz4 on 4/12/19.
//  Copyright © 2019 knstz4. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {

    struct Converter {
        var label: String
        var inputUnit: String
        var outputUnit: String
    }
    //tracker for knowing which conversion is selected by the user
    var currentConverter:Int = 1
    var rawValue = ""
    var convertedValue = ""
    var positiveOrNegative = ""
    var isNegative = false
    
    @IBOutlet weak var outputDisplay: UITextField!
    @IBOutlet weak var inputDisplay: UITextField!
    
    var converter: [Converter]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        converter = [Converter(label: "fahrenheit to celcius", inputUnit: "°F", outputUnit: "°C"),
                     Converter(label: "celcius to fahrenheit", inputUnit: "°C", outputUnit: "°F"),
                     Converter(label: "miles to kilometers", inputUnit: "mi", outputUnit: "km"),
                     Converter(label: "kilometers to miles", inputUnit: "km", outputUnit: "mi")]
        
        updateValues()
    }
    
    @IBAction func triggerPlusMinus(_ sender: Any) {
        isNegative = !isNegative
        if isNegative{
            positiveOrNegative = "-"
        }else{
            positiveOrNegative = ""
        }
        updateValues()
    }
    //clear button functionality
    @IBAction func clear(_ sender: Any) {
        rawValue = ""
        convertedValue = ""
        positiveOrNegative = ""
        isNegative = false
        updateValues()
    }
    //functionality for button clicks.
    @IBAction func appendToInput(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        if let btnChar = button.titleLabel?.text{
            rawValue = rawValue + btnChar
            updateValues()
        }
    }
    //Original functionality from the initial converter. Converter selection is tracked with currentConverter and then updates values.
    @IBAction func changeConverter(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Converter", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: self.converter![0].label, style: UIAlertAction.Style.default, handler: {
            (alertAction) -> Void in
            self.currentConverter = 0
            self.updateValues()
        }))
        
        alert.addAction(UIAlertAction(title: self.converter![1].label, style: UIAlertAction.Style.default, handler: {
            (alertAction) -> Void in
            self.currentConverter = 1
            self.updateValues()
        }))
        
        alert.addAction(UIAlertAction(title: self.converter![2].label, style: UIAlertAction.Style.default, handler: {
            (alertAction) -> Void in
            self.currentConverter = 2
            self.updateValues()
        }))
        
        alert.addAction(UIAlertAction(title: self.converter![3].label, style: UIAlertAction.Style.default, handler: {
            (alertAction) -> Void in
            self.currentConverter = 3
            self.updateValues()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    //function to update the values that are shown in the label and conduct the conversions that are selected. Switch cases correspond to which converter is selected and perform the actions needed based on this.
    func updateValues() {
        switch currentConverter {
        case 0:
            if let temp = Float(positiveOrNegative + rawValue){
                let outcome = (temp-32)/1.8
                convertedValue = String(format: "%.2f", outcome)
            } else {
                convertedValue = ""
            }
            inputDisplay.text = positiveOrNegative + rawValue + converter![currentConverter].inputUnit
            outputDisplay.text = convertedValue + converter![currentConverter].outputUnit
            
        case 1:
            
            if let temp = Float(positiveOrNegative + rawValue){
                let outcome = (temp*1.8)+32
                convertedValue = String(format: "%.2f", outcome)
            } else {
                convertedValue = ""
            }
            inputDisplay.text = positiveOrNegative + rawValue + converter![currentConverter].inputUnit
            outputDisplay.text = convertedValue + converter![currentConverter].outputUnit
            
        case 2:
            
            if let temp = Double(positiveOrNegative + rawValue){
                let outcome = temp * 1.609344
                convertedValue = String(format: "%.2f", outcome)
                
            } else {
                convertedValue = ""
            }
            inputDisplay.text = positiveOrNegative + rawValue + converter![currentConverter].inputUnit
            outputDisplay.text = convertedValue + converter![currentConverter].outputUnit
            
        case 3:
            
            if let temp = Float(positiveOrNegative + rawValue){
                let outcome = temp / 1.609344
                convertedValue = String(format: "%.2f", outcome)
            } else {
                convertedValue = ""
            }
            inputDisplay.text = positiveOrNegative + rawValue + converter![currentConverter].inputUnit
            outputDisplay.text = convertedValue + converter![currentConverter].outputUnit
        default:
            print("no input")
        }
    }
}
