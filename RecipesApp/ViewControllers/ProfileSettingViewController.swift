//
//  ProfileSettingViewController.swift
//  RecipesApp
//
//  Created by Yuriko Uchida on 2022-07-26.
//

import UIKit

// Create a protocol
protocol SetUserDelegate {
    func setUser(user: User)
}

class ProfileSettingViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    //Variables to store data from the previous page
    var user = User();
    //var isUser = false;
    
    // delegate variable
    var delegate: SetUserDelegate?
    
    //Button and text objects
    @IBOutlet weak var selectPhotoButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var yourNameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var dateOfBirthDatePicker: UIDatePicker!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    
    //Label objects
    @IBOutlet weak var nameRequiredLabel: UILabel!
    @IBOutlet weak var maleLabel: UILabel!
    @IBOutlet weak var femaleLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var yourNameLabel: UILabel!
    @IBOutlet weak var personalSettingsTitleLabel: UILabel!

    
    //Highlight the selected gender
    @IBAction func selectGender(_ sender: Any) {
        if (maleButton.isHighlighted || !femaleButton.isHighlighted) {
            user.isFemale = false;
            maleButton.setImage(UIImage(systemName: "circle.inset.filled")?.withRenderingMode(.alwaysOriginal), for: .normal);
            femaleButton.setImage(UIImage(systemName: "circle")?.withRenderingMode(.alwaysOriginal), for: .normal);
        } else {
            user.isFemale = true;
            maleButton.setImage(UIImage(systemName: "circle")?.withRenderingMode(.alwaysOriginal), for: .normal);
            femaleButton.setImage(UIImage(systemName: "circle.inset.filled")?.withRenderingMode(.alwaysOriginal), for: .normal);
        }
    }
    
    
    //Allow photo selection, once a user clicks the button
    @IBAction func selectPhoto(_ sender: Any) {
        let imageVC = UIImagePickerController();
        imageVC.sourceType = .photoLibrary;
        imageVC.delegate = self;
        imageVC.allowsEditing = true;
        present(imageVC, animated: true);
    }
    
    //Once a user changes the date, update the text field
    @IBAction func changeDate(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
    }
    
    
    
    //Save setting and preview it on the next page
    @IBAction func saveSettings(_ sender: Any) {

        var isValid = shouldPerformSegue(withIdentifier: "ProfilePreviewViewController", sender: nil);
        if (!isValid){
            yourNameTextField.backgroundColor = .red;
        }else {
            yourNameTextField.backgroundColor = .white
            
            let previewVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePreviewViewController") as! ProfilePreviewViewController
            user.name = yourNameTextField.text!
            user.country = countryTextField.text!
            user.dateOfBirth = dateOfBirthDatePicker.date
            if (user.isPhoto){
                user.photo = profileImageView.image!
            }
            previewVC.user = user
            
            // use delegate variabke to call setUser function
            delegate?.setUser(user: user)
            
//            self.navigationController?.pushViewController(previewVC, animated: true)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        //Value from the previous page
        yourNameTextField.text = user.name;
        countryTextField.text = user.country;
        dateOfBirthDatePicker.date = user.dateOfBirth;
        if (user.isPhoto){
            profileImageView.image = user.photo;
        }
        
        //Bold font
        personalSettingsTitleLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(24));
        
        //Rounded buttons
        profileImageView.layer.cornerRadius = 10;
        profileImageView.layer.masksToBounds = true;
        selectPhotoButton.layer.cornerRadius = 10;
        selectPhotoButton.layer.masksToBounds = true;
        saveButton.layer.cornerRadius = 22;
        saveButton.layer.masksToBounds = true;

        //Border of the photo button
        selectPhotoButton.layer.borderColor = UIColor(red: 5, green: 5, blue: 5, alpha: 1.0).cgColor;
        selectPhotoButton.contentMode = .scaleToFill;
        selectPhotoButton.layer.borderWidth = 3;

        //Initial setting of the radio button
        if (user.isFemale == false) {
            maleButton.setImage(UIImage(systemName: "circle.inset.filled")?.withRenderingMode(.alwaysOriginal), for: .normal);
            femaleButton.setImage(UIImage(systemName: "circle")?.withRenderingMode(.alwaysOriginal), for: .normal);
        } else if (user.isFemale == true) {
            maleButton.setImage(UIImage(systemName: "circle")?.withRenderingMode(.alwaysOriginal), for: .normal);
            femaleButton.setImage(UIImage(systemName: "circle.inset.filled")?.withRenderingMode(.alwaysOriginal), for: .normal);
        }
    }
   
/*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let previewVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePreviewViewController") as! ProfilePreviewViewController
        //let previewVC = segue.destination as! ProfilePreviewViewController;
        user.name = yourNameTextField.text!
        user.country = countryTextField.text!
        user.dateOfBirth = dateOfBirthDatePicker.date
        if (user.isPhoto){
            user.photo = profileImageView.image!
        }
        previewVC.user = user
    }
*/
    
    //Validate the required fields
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var isValid = true;
        let nameRange = NSRange(location: 0, length: yourNameTextField.text!.count)
        let nameRegex = try! NSRegularExpression(pattern: "^[a-zA-Z]{1}[a-zA-Z ]*$")
        isValid = (nameRegex.firstMatch(in: yourNameTextField.text!, options: [], range: nameRange) != nil)
        return isValid;
    }
         
    //Access the user's camera library and allow users to select the icon photo
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imgSelected = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")]as? UIImage {
            profileImageView.image = imgSelected;
            user.isPhoto = true;
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
