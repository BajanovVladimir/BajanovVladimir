//
//  MainViewController.swift
//  Calculator
//
//  Created by Владимир Бажанов on 9/13/21.
//

import UIKit

class MainViewController: UIViewController {

    lazy var normalViewController: NormalViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "NormalViewController") as! NormalViewController
        self.addViewControllerAssChildViewController(chaildViewController: viewController)
        return viewController
    }()
    
    lazy var engineeringViewController: EngineeringViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "EngineeringViewController") as! EngineeringViewController
        self.addViewControllerAssChildViewController(chaildViewController: viewController)
        return viewController
    }()
     
    @IBOutlet weak var keyboardConteinerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        normalViewController.view.isHidden = false
    }
  
    private func addViewControllerAssChildViewController(chaildViewController:UIViewController){
    addChild(chaildViewController)
        keyboardConteinerView.addSubview(chaildViewController.view)
    chaildViewController.view.frame = view.bounds
    chaildViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    chaildViewController.didMove(toParent: self)
}
    
    @IBAction func changeViewControlSegmentControl(_ sender: UISegmentedControl) {
        
        UIView.transition(from: normalViewController.view, to: engineeringViewController.view, duration: 1, options:[.curveEaseOut, .transitionFlipFromLeft, .showHideTransitionViews])
        normalViewController.view.isHidden = true
        engineeringViewController.view.isHidden = true
        if sender.selectedSegmentIndex == 0 {
            normalViewController.view.isHidden = false
        } else {
           engineeringViewController.view.isHidden = false
        }
    }
}
