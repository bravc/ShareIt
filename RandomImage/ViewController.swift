//
//  ViewController.swift
//  RandomImage
//
//  Created by Cameron Braverman on 4/6/18.
//  Copyright © 2018 Cameron Braverman. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var textField: UITextField!
    var photos = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClick(_ sender: Any) {
        getImage()
    }
    
    struct image {
        var farm: String
        var secret: String
        var server: String
        var id: String
    }
    
    func getImage() {
        self.photos.removeAll(keepingCapacity: true)
        Alamofire.request("http://129.21.101.239:8080/photos"
                ).responseData { response in
                    if let data = response.result.value {
                        do{
                            let json = try JSON(data: data)
                            for photo in json.arrayValue {
                                print(photo.stringValue)
                                self.photos.append(photo.stringValue)
                            }
                            self.performSegue(withIdentifier: "showImages", sender: self)
                        }catch{}
                    
                }
            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destination = segue.destination as! PictureViewController
        destination.images = self.photos
    }
    
    
}

