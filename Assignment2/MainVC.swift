//
//  MainVC.swift
//  Assignment2
//
//  Created by abdrahman on 31/05/2022.
//

import UIKit

class MainVC: UIViewController {

    var imagePicker = UIImagePickerController()
    
    let myView = CustomContainerView()
    var tag = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        myView.delegate = self
        myView.frame = CGRect(x: view.frame.size.width / 2 - 150, y: view.frame.size.height / 2 - 150, width: (view.frame.size.width * 3) / 4 , height: (view.frame.size.width * 3) / 4)
        myView.center = view.center
        myView.backgroundColor = .yellow
        view.addSubview(myView)
        print((view.frame.size.width * 3) / 4)
    }

}

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
