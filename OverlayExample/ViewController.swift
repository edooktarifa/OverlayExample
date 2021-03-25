//
//  ViewController.swift
//  OverlayExample
//
//  Created by Edo Oktarifa on 25/03/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showAgreemnt(_ sender: UIButton){
        let vc = OverlayViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }

}

