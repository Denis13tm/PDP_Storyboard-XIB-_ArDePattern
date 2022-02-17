//
//  ViewController.swift
//  PDP_Storyboard(XIB)_ArDePattern
//
//  Created by Otabek Tuychiev
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userRootName: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var followersNumber: UILabel!
    @IBOutlet weak var followingNumber: UILabel!
    
    @IBOutlet weak var blogLabel: UILabel!
    @IBOutlet weak var editBtn_BV: UIView!
    @IBOutlet weak var editBtn: UIButton!
    


    
    
    var userAPI = UserAPI()
    var singleUser = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }

    //MARK: - Methods
    
    private func initViews() {
        
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.bounds.height / 2
        
        editBtn.layer.masksToBounds = true
        editBtn.layer.cornerRadius = 10.0
        editBtn_BV.layer.cornerRadius = 10.0
        
        
        updateUI()
        
        userAPI.getSingleUser { response in
            self.singleUser = response
            self.updateUI()
        }
        
    }
    
    private func updateUI() {
        guard let image = singleUser.avatar_url else { return }
        if let url = URL(string: image) {
            URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.profileImage.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        
        userName.text = singleUser.name
        userRootName.text = singleUser.login
        bioLabel.text = singleUser.bio
        blogLabel.text = singleUser.blog
        guard let followers = singleUser.followers else { return }
        followersNumber.text = String(followers)
        guard let following = singleUser.following else { return }
        followingNumber.text = String(following)
    }

}


extension UIImage {
        // image with rounded corners
        public func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
            let maxRadius = min(size.width, size.height) / 2
            let cornerRadius: CGFloat
            if let radius = radius, radius > 0 && radius <= maxRadius {
                cornerRadius = radius
            } else {
                cornerRadius = maxRadius
            }
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            let rect = CGRect(origin: .zero, size: size)
            UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
            draw(in: rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
    }
