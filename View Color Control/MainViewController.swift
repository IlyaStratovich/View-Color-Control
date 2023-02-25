//
//  MainViewController.swift
//  View Color Control
//
//  Created by Илья Стратович on 22.02.23.
//

import UIKit

protocol ColorViewControllerDelegate: AnyObject {
    func setNewColor(for color: UIColor)
}

final class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorVC = segue.destination as? ColorViewController else { return }
        colorVC.color = view.backgroundColor
        colorVC.delegate = self
    }
    
}


// MARK: -ColorViewControllerDelegate
extension MainViewController: ColorViewControllerDelegate {
    func setNewColor(for color: UIColor) {
        view.backgroundColor = color
    }
}
