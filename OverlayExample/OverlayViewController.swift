//
//  OverlayViewController.swift
//  OverlayExample
//
//  Created by Edo Oktarifa on 25/03/21.
//

import UIKit

class OverlayViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    
    var viewTranslation = CGPoint(x: 0, y: 0)
    let swipeThreshold: CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    //MARK: setupUI
    func setupUI(){
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleDismiss(recognizer:)))
        contentView.addGestureRecognizer(panGestureRecognizer)
        tableDataSource()
    }
    
    @objc func handleDismiss(recognizer: UIPanGestureRecognizer){
        switch recognizer.state {
        case .changed:
            viewTranslation = recognizer.translation(in: view)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) {
                self.contentView.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
            }
        case .ended:
            if viewTranslation.y < swipeThreshold{
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) {
                    self.contentView.transform = .identity
                }
            }else{
                dismiss(animated: true, completion: nil)
            }

        default:
            break
        }
    }
    
    //MARK: tableview data source
    func tableDataSource(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "AgreementCell", bundle: nil), forCellReuseIdentifier: "AgreementCell")
    }

}

extension OverlayViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgreementCell", for: indexPath) as! AgreementCell
        cell.contentAgreement.text = dataOverlay
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

