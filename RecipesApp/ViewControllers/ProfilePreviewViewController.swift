//
//  ProfilePreviewViewController.swift
//  RecipesApp
//
//  Created by Yuriko Uchida on 2022-07-26.
//

import UIKit

class ProfilePreviewViewController: UIViewController {

    //Variable to store data from the previous page
    var user = User();

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var birthdayButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pageTitleLabel: UILabel!
    
/*
    //Go back to the profile setting page
    @IBAction func editProfile(_ sender: Any) {
        let settingVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileSettingViewController") as! ProfileSettingViewController
        settingVC.user = user
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //self.user = appDelegate.getUser()

        //Assign the values from the previous page
        if (user.isPhoto){
            photoImageView.image = user.photo;
        } else {
            //If the photo is not selected show the default icon
            changeIconColor();
        }
        nameLabel.text = user.name;
        nameLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(20));//Bold font
        fromButton.setTitle("\(user.country)", for: .normal);
        let dateFormatter = DateFormatter();
        dateFormatter.dateStyle = DateFormatter.Style.medium;
        birthdayButton.setTitle("\(dateFormatter.string(from: user.dateOfBirth as Date))", for: .normal);
        
        //Rounded buttons with border only
        fromButton.layer.masksToBounds = true;
        fromButton.layer.cornerRadius = 22;
        fromButton.layer.borderWidth = 2;
        fromButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        fromButton.isUserInteractionEnabled = false; //Unclickable
        
        birthdayButton.layer.masksToBounds = true;
        birthdayButton.layer.cornerRadius = 22;
        birthdayButton.layer.borderWidth = 2;
        birthdayButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        birthdayButton.isUserInteractionEnabled = false //Unclickable
    }
    

    //Pass the user obj
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingVC = segue.destination as! ProfileSettingViewController;
        settingVC.user = user
        settingVC.delegate = self
    }


    //Change the default icon color based on the gender
    public func changeIconColor() {
        if (!user.isFemale) {
            photoImageView.tintColor = UIColor(
                red: CGFloat(170)/CGFloat(255),
                green: CGFloat(240)/CGFloat(255),
                blue: CGFloat(193)/CGFloat(255),
                alpha: 1);
            photoImageView.backgroundColor = UIColor(
                red: CGFloat(234)/CGFloat(255),
                green: CGFloat(251)/CGFloat(255),
                blue: CGFloat(240)/CGFloat(255),
                alpha: 1);
        } else {
            photoImageView.tintColor = UIColor(
                red: CGFloat(221)/CGFloat(255),
                green: CGFloat(170)/CGFloat(255),
                blue: CGFloat(240)/CGFloat(255),
                alpha: 1);
            photoImageView!.backgroundColor = UIColor(
                red: CGFloat(247)/CGFloat(255),
                green: CGFloat(234)/CGFloat(255),
                blue: CGFloat(251)/CGFloat(255),
                alpha: 1);
        }

    }

}

// implement the SetUserDelegate protocol
extension ProfilePreviewViewController: SetUserDelegate{
    func setUser(user: User) {
        self.user = user
        //Assign the values from the previous page
        if (user.isPhoto){
            self.photoImageView.image = user.photo;
        } else {
            //If the photo is not selected show the default icon
            self.changeIconColor();
        }
        self.nameLabel.text = user.name;
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(20));//Bold font
        self.fromButton.setTitle("\(user.country)", for: .normal);
        let dateFormatter = DateFormatter();
        dateFormatter.dateStyle = DateFormatter.Style.medium;
        self.birthdayButton.setTitle("\(dateFormatter.string(from: user.dateOfBirth as Date))", for: .normal);
    }
}
