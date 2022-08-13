//
//  WelcomeViewController.swift
//  RecipesApp
//
//  Created by Yuriko Uchida on 2022-07-26.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var getstartedButton: UIButton!
    @IBOutlet weak var appDescriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        //CAGradientLayer object
        let gradientColor = CAGradientLayer();
        //Gradient color
        gradientColor.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor, UIColor.black.cgColor];
        //Gradient location
        gradientColor.startPoint = CGPoint(x:0.0, y:0.5);
        gradientColor.endPoint = CGPoint(x:0.0, y:1.0);
        gradientColor.frame = view.frame;
        //Apply the gradient color layer
        view.layer.addSublayer(gradientColor);
        
        //Bold font
        titleLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(36));
        getstartedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(24));
                
        //Rounded button
        getstartedButton.layer.cornerRadius = 30;
        getstartedButton.layer.masksToBounds = true;
        
        //Bring the objs on the top
        appDescriptionTextView.layer.zPosition = 4;
        getstartedButton.layer.zPosition = 4;
        titleLabel.layer.zPosition = 5;
    }


}
