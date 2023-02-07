//
//  ViewController.swift
//  View Color Control
//
//  Created by Илья Стратович on 6.02.23.
//

import UIKit

final class ViewController: UIViewController {
   //MARK: - IBOutlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    @IBOutlet var redColorBoard: UILabel!
    @IBOutlet var greenColorBoard: UILabel!
    @IBOutlet var blueColorBoard: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 10
    }
    //MARK: - IBActions
    @IBAction func redSliderValueChanged() {
        redColorBoard.text = String(format: "%.2f", redColorSlider.value)
        updateColor()
    }
    @IBAction func greenSliderValueChanged() {
        greenColorBoard.text = String(format: "%.2f",greenColorSlider.value)
        updateColor()
    }
    @IBAction func blueSliderValueChanged() {
        blueColorBoard.text = String(format: "%.2f", blueColorSlider.value)
        updateColor()
    }
    //MARK: = PrivateMethods
    private func updateColor() {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        
        if redColorSlider.value > 0 {
            red = CGFloat(redColorSlider.value)
        }
        
        if greenColorSlider.value > 0 {
            green = CGFloat(greenColorSlider.value)
        }
        
        if blueColorSlider.value > 0 {
            blue = CGFloat(blueColorSlider.value)
        }
        
        let color = UIColor(
            red: red,
            green: green,
            blue: blue,
            alpha: 1
        )
        
        colorView.backgroundColor = color
    }
}

