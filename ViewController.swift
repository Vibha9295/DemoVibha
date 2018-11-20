//
//  ViewController.swift
//  DemoVibha
//
//  Created by vibha on 20/11/18.
//  Copyright © 2018 vibha. All rights reserved.
//

import UIKit
import AudioToolbox.AudioServices

class ViewController: UIViewController{
    
    //MARK: - UIImageView Outlets
    
    @IBOutlet var imgView: UIImageView!
    
    //MARK: - Variable Declaration
    
    var i = 0
    var isStatusBarHidden: Bool = false
    var imagePicker = UIImagePickerController()
    
    // MARK: - Default Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Status Bar Methods
    
    override var prefersStatusBarHidden: Bool {
        return self.isStatusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    
    // MARK: - UIButton Action
    
    @IBAction func btnVibrateAct(_ sender: Any) {
        i += 1
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        switch i {
        case 1:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            
        case 2:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
        case 3:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
            
        case 4:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        case 5:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
        case 6:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
        default:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
            i = 0
        }
    }
    
    @IBAction func btnStatusBarAct(_ sender: Any) {
        self.isStatusBarHidden = !self.isStatusBarHidden
        
        UIView.animate(withDuration: 0.3) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
        
    }
    
    @IBAction func btnGalaryAct(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)
        {
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
}

//MARK: - UIImagePicker Delegate Methods

extension ViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        imgView.image = chosenImage
        
        dismiss(animated: true, completion: nil)
        let photo:FBSDKSharePhoto = FBSDKSharePhoto()
        
        photo.image = imgView.image
        photo.isUserGenerated = true
        
        let content:FBSDKSharePhotoContent = FBSDKSharePhotoContent()
        content.photos = [photo]
        
        let shareButton = FBSDKShareButton()
        shareButton.center = view.center
        
        shareButton.shareContent = content
        shareButton.frame = CGRect(x: (UIScreen.main.bounds.width - 150) * 0.5, y: 450, width: 150, height: 25)
        self.view.addSubview(shareButton)
        
    }
}
