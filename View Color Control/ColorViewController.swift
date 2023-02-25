//
//  ViewController.swift
//  View Color Control
//
//  Created by Илья Стратович on 6.02.23.
//

import UIKit

final class ColorViewController: UIViewController {
   //MARK: - IBOutlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    @IBOutlet var redColorBoard: UILabel!
    @IBOutlet var greenColorBoard: UILabel!
    @IBOutlet var blueColorBoard: UILabel!
    
    var color: UIColor!
    unowned var delegate: ColorViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 10
        colorView.backgroundColor = color
        updateColor()
        setValue(for: redColorBoard, greenColorBoard, blueColorBoard)
    }
    //MARK: - IBActions
    @IBAction func doneButtonDidTap() {
        delegate.setNewColor(for: colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    @IBAction func sliderAction(_ sender: UISlider) {
        updateColor()
        switch sender {
        case redColorSlider:
            redColorBoard.text = string(from: redColorSlider)
        case greenColorSlider:
            greenColorBoard.text = string(from: greenColorSlider)
        default: blueColorBoard.text = string(from: blueColorSlider)
        }
    }
    //MARK: = PrivateMethods
    private func updateColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1
        )
    }
    
    private func string(from slider: UISlider) -> String {
        return String(format: "%.2f", slider.value)
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redColorBoard:
                redColorBoard.text = string(from: redColorSlider)
            case greenColorBoard:
                greenColorBoard.text = string(from: greenColorSlider)
            default: blueColorBoard.text = string(from: blueColorSlider)
            }
        }
   }
    
    private func getColor(from color: UIColor) {
    let ciColor = CIColor(color: color)
        CGFloat(ciColor.red.value) = redColorSlider.value
    }
}
 
 

