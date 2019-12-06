//
//  ViewController.swift
//  Calculator
//
//  Created by Travis Agne on 11/26/19.
//  Copyright © 2019 Travis Agne. All rights reserved.
//

import UIKit

struct Converter{
    var label: String
    var inputUnit: String
    var outputUnit: String
    var index: Int
}

let conversionTypes: [Converter] = [
    Converter(label:"Fahrenheit to Celsius", inputUnit:"°F",outputUnit:"°C",index:0),
    Converter(label:"Celsius to Fahrenheit",inputUnit:"°C",outputUnit:"°F",index:1),
    Converter(label:"Miles to Kilometers", inputUnit:"m", outputUnit:"km",index:2),
    Converter(label:"Kilometers to Miles", inputUnit:"km", outputUnit:"m",index:3)
]


class ViewController: UIViewController {

    @IBOutlet weak var conversionField: UITextField!
    @IBOutlet weak var inputField: UITextField!
    
    var currentConverter: Converter? = conversionTypes[0]
    var inputValue: String = "0"
    var outputValue: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conversionField.text = currentConverter?.outputUnit
        inputField.text = currentConverter?.inputUnit
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clear(_ sender: Any) {
        conversionField.text = currentConverter?.outputUnit
        inputField.text = currentConverter?.inputUnit
    }
    
    @IBAction func plusminus(_ sender: Any) {
        let input = Double(inputValue)
        if let inputAsDouble = input {
            if inputAsDouble > 0 {
                inputValue = "-" + inputValue
                performConversions()
            }
            if inputAsDouble < 0 {
                inputValue.removeFirst()
                performConversions()
                if let suffix = currentConverter?.inputUnit{
                 inputField.text = inputValue + suffix
                }
            }
        }
        return
    }
    
    func performConversions(){
        
        var celsius: Double
        var fahrenheit: Double
        var miles: Double
        var kilometers: Double
        
        let input = Double(inputValue)
        
        if let inputAsDouble = input {
            switch currentConverter?.index{
            case 0:
               celsius = ( inputAsDouble - 32 ) * (5 / 9)
               if let suffix = currentConverter?.outputUnit{
                conversionField.text = String(celsius) + suffix
               }
            case 1:
                fahrenheit = (inputAsDouble * (9/5)) - 32
                if let suffix = currentConverter?.outputUnit{
                 conversionField.text = String(fahrenheit) + suffix
                }
            case 2:
                kilometers = inputAsDouble * 1.609
                if let suffix = currentConverter?.outputUnit{
                 conversionField.text = String(kilometers) + suffix
                }
            case 3:
                miles = inputAsDouble / 1.609
                if let suffix = currentConverter?.outputUnit{
                 conversionField.text = String(miles) + suffix
                }
            default:
                print("bye")
        }
        }
    }
    
    @IBAction func decimal(_ sender: Any) {
        if inputValue.contains(".") {
            return
        }
        else {
            if let suffix = currentConverter?.inputUnit{
             conversionField.text = outputValue + "." + suffix
            }
            if let suffix = currentConverter?.outputUnit{
             inputField.text = inputValue + "." + suffix
            }
        }
    }
    
  
    @IBAction func addNumber(_ sender: UIButton) {
        let num: String? = String(sender.tag)
        if(Double(inputValue) == 0 ){
            if let newnumber = num {
                inputValue =  inputValue + newnumber
                performConversions()
                if let suffix = currentConverter?.inputUnit{
                    inputField.text = inputValue + "." + suffix
                }
                
            }
        }
    }
    
    
    @IBAction func conversionAlert(_ sender: Any) {
        let alert = UIAlertController(title:"Choose a new conversion type",message: "go ahead already",preferredStyle: UIAlertController.Style.actionSheet)
        
        for converter in conversionTypes{
        alert.addAction(UIAlertAction(title: converter.label, style:UIAlertAction.Style.default, handler: {
            (alertAction) -> Void in
            self.updateConverter(converter.index)
        }))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateConverter(_ index: Int) {
        currentConverter = conversionTypes[index]
        inputField.text = currentConverter?.inputUnit
        conversionField.text = currentConverter?.outputUnit
    }
    
}

