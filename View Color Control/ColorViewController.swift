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
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    @IBOutlet var redColorBoard: UILabel!
    @IBOutlet var greenColorBoard: UILabel!
    @IBOutlet var blueColorBoard: UILabel!
    
    var viewColor: UIColor!
    unowned var delegate: ColorViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 15
        
        redColorSlider.tintColor = .red
        greenColorSlider.tintColor = .green
        
        colorView.backgroundColor = viewColor
        
        setValue(for: redColorSlider, greenColorSlider, blueColorSlider)
        setValue(for: redColorBoard, greenColorBoard, blueColorBoard)
        setValue(for: redTextField, greenTextField, blueTextField)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    //MARK: - IBActions
    @IBAction func doneButtonDidTap() {
        delegate.setNewColor(colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        switch sender {
        case redColorSlider:
            setValue(for: redColorBoard)
            setValue(for: redTextField)
        case greenColorSlider:
            setValue(for: greenColorBoard)
            setValue(for: greenTextField)
        default:
        setValue(for: blueColorBoard)
        setValue(for: blueTextField)
        }
        updateColor()
    }
}
//MARK: = PrivateMethods
extension ColorViewController {
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
            default: label.text = string(from: blueColorSlider)
            }
        }
   }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField:
                textField.text = string(from: redColorSlider)
            case greenTextField:
                textField.text = string(from: greenColorSlider)
            default:
                textField.text = string(from: blueColorSlider)
            }
        }
    }
    
    private func setValue(for colorSliders: UISlider...) {
        let ciColor = CIColor(color: viewColor)
        colorSliders.forEach { colorSlider in
            switch colorSlider {
            case redColorSlider:
                colorSlider.value = Float(ciColor.red)
            case greenColorSlider:
                colorSlider.value = Float(ciColor.green)
            default:
                colorSlider.value = Float(ciColor.blue)
            }
        }
    }
    
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default){_ in
            textField?.text = "1.00"
            textField?.becomeFirstResponder()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension ColorViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            showAlert(
                title: "Wrong format!",
                message: "Please enter correct value"
            )
            return
        }
        guard let currentValue = Float(text), (0...1).contains(currentValue) else {
            showAlert(
                title: "Wrong format!",
                message: "Please enter correct value",
                textField: textField
            )
            return
        }
        
            switch textField {
            case redTextField:
                redColorSlider.setValue(currentValue, animated: true)
                setValue(for: redColorBoard)
            case greenTextField:
                greenColorSlider.setValue(currentValue, animated: true)
            default:
                blueColorSlider.setValue(currentValue, animated: true)
            }
        updateColor()
        }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard textField != redTextField else { return }
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.sizeToFit()
        textField.inputAccessoryView = keyboardToolBar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: textField,
            action: #selector(resignFirstResponder)
        )
        
        let flexBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolBar.items = [flexBarButtonItem, doneButton]
    }
}



 
 

