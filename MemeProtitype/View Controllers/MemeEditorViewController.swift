//
//  ViewController.swift
//  MemeProtitype
//
//  Created by Hao Wu on 28.01.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    // MARK: Properties
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        .strokeWidth:  -4.0
    ]
    
    var meme: Meme?
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField(textField: topTextField, with: "TOP")
        setupTextField(textField: bottomTextField, with: "BOTTOM")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configView()
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: Actions

    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        presentPickerViewController(from: .photoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        presentPickerViewController(from: .camera)
    }
    
    func presentPickerViewController(from source: UIImagePickerController.SourceType) {
        let pickController = UIImagePickerController()
        pickController.delegate = self
        pickController.sourceType = source
        present(pickController, animated: true, completion: nil)
    }
    
    @IBAction func cancelMeme(_ sender: Any) {
        imagePickerView.image = nil
        shareButton.isEnabled = false
        setupTextField(textField: topTextField, with: "TOP")
        setupTextField(textField: bottomTextField, with: "BOTTOM")
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        let meme = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.sourceView = view
        
        activityViewController.completionWithItemsHandler = { activityType, completed, returnedItems, activityError in
            if completed {
                self.saveMemeImage()
                self.navigationController?.popToRootViewController(animated: true)
            }
            
        }
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    // MARK: Set up top bottom text field
    
    func setupTextField(textField: UITextField, with text: String) {
        textField.delegate = self
        textField.text = text
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
    }
    
    // MARK: Keyboard Notification
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Resize View
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        print(keyboardSize.cgRectValue.height)
        return keyboardSize.cgRectValue.height
    }
    
    // MARK: Config View
    
    private func configView() {
        if let meme = meme {
            imagePickerView.image = meme.originalImage
            topTextField.text = meme.topText
            bottomTextField.text = meme.bottomText
        }
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareButton.isEnabled = !(imagePickerView.image == nil)
        tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: Save memeImage
    
    func saveMemeImage() {
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        MemesManager.shared.memes.append(meme)
        
    }
    
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navigationbar
        toolbar.isHidden = true
        navigationController?.isNavigationBarHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // display toolbar and navigationbar
        toolbar.isHidden = false
        navigationController?.isNavigationBarHidden = false
        
        return memedImage
    }
    
}

// MARK: UITextFieldDelegate

extension MemeEditorViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: UIImagePickerControllerDelegate

extension MemeEditorViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
            meme = nil
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

