//
//  Task1Animation3ViewController.swift
//  Lesson29
//
//  Created by Anton Havrylenko on 03.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import UIKit

class Task1Animation3ViewController: UIViewController {
    
    // MARK: - Properties
    
    private(set) var originSize = CGFloat()
    private(set) var lineViewCurrentSize = CGFloat()
    private var threshold: CGFloat {
        return view.frame.size.width / 2.0
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var lineView: UIView!
    
    // MARK: - IBActions
    
    @IBAction private func panGesture(sender: UIPanGestureRecognizer) {
        let  viewTranslation = sender.translationInView(view)
        let state = sender.state
        
        switch state {
        case .Began:
            lineViewCurrentSize = sender.view!.frame.width
        case .Changed:
            sender.view!.frame.size.width = lineViewCurrentSize + viewTranslation.x
        case .Ended:
            lineViewCurrentSize = sender.view!.frame.width
            
            if  lineViewCurrentSize >= threshold {
                UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseOut, animations: {
                    sender.view!.frame.size.width = self.view.frame.width
                    }, completion: nil)
            } else {
                UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseOut, animations: {
                    sender.view!.frame.size.width = self.originSize
                    }, completion: nil)
            }
        default:
            break
        }
    }
    
    // MARK: - Override functions
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        originSize = lineView.frame.width
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if navigationController!.respondsToSelector(Selector("interactivePopGestureRecognizer")) {
            navigationController!.view.removeGestureRecognizer(navigationController!.interactivePopGestureRecognizer!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
