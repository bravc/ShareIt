//
//  UploadImageViewController.swift
//  RandomImage
//
//  Created by Cameron Braverman on 4/8/18.
//  Copyright © 2018 Cameron Braverman. All rights reserved.
//

import UIKit
import Alamofire

class UploadImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker: UIImagePickerController!
    @IBOutlet var uploadResponse: UILabel!
    @IBOutlet var imageTake: UIImageView!
    var imageString: String!
    var imageData: Data!
    var count = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        imageTake.contentMode = .scaleAspectFit

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func chooseImage(_ sender: Any) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image_data = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.imageData = UIImagePNGRepresentation(image_data!)!
        imageString = imageData.base64EncodedString()
        imageTake.image = UIImage(data: imageData)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        let url = "http://129.21.101.239:8080/upload"
        
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        
        let parameters = Dictionary<String, String>()
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            multipartFormData.append(self.imageData, withName: "image" , fileName: "\(self.count).png", mimeType: "image/png")
            
            
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    print(String(data: response.data!, encoding: String.Encoding.utf8))
                    self.uploadResponse.text = String(data: response.data!, encoding: String.Encoding.utf8)
                    self.count += 1
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
            }
        }
    }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


