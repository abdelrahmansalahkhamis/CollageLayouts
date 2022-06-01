//
//  MainVC.swift
//  Assignment2
//
//  Created by abdrahman on 31/05/2022.
//

import UIKit

class MainVC: UIViewController {

    // create a picker controller instance to enable access to gallery
    var imagePicker = UIImagePickerController()
    
    // create my custom view instance to draw in the main vc
    let myView = CustomContainerView()
    
    // variable to indicate the image tag
    var tag = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setUpCustomView()
    }
    
    // configure our custom view on the main vc
    func setUpCustomView(){
        myView.delegate = self
        myView.frame.size.width = (view.frame.size.width * 3) / 4
        myView.frame.size.height = (view.frame.size.width * 3) / 4
        myView.center = view.center
        myView.backgroundColor = .yellow
        view.addSubview(myView)
    }

}

// confirming to CustomContainerView protocol and the picker controller protocols
extension MainVC: CustomContainerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func didSelectImg(_ tag: Int) {
        self.tag = tag
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // assign chosen image to the image view section based on image tag
            switch tag{
            case 1:
                myView.imageView1.image = image
            case 2:
                myView.imageView2.image = image
            case 3:
                myView.imageView3.image = image
            default:
                break
            }
                
        }
    }
}
