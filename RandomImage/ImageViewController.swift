//
//  ImageViewController.swift
//  RandomImage
//
//  Created by Cameron Braverman on 4/7/18.
//  Copyright © 2018 Cameron Braverman. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    


    @IBOutlet var imageRequested: UIImageView!
    var image: UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageRequested.image = image
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didClick(_ sender: Any) {
        let alert = UIAlertController(title: "Save?", message: "Do you want to save image?", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Save", style: .default) { (AlertAction) in
            UIImageWriteToSavedPhotosAlbum(self.image, self, nil, nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
