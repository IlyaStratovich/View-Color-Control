//
//  MainViewController.swift
//  View Color Control
//
//  Created by Илья Стратович on 22.02.23.
//

import UIKit

protocol ColorViewControllerDelegate: AnyObject {
    func setNewColor(_ color: UIColor)
}

final class MainViewController: UIViewController {
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorVC = segue.destination as? ColorViewController else { return }
        colorVC.delegate = self
        colorVC.viewColor = view.backgroundColor
    }
    
}


// MARK: -ColorViewControllerDelegate
extension MainViewController: ColorViewControllerDelegate {
    func setNewColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
