//
//  RoundedAvatar.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Igor on 9/16/19.
//  Copyright © 2019 Igor. All rights reserved.
//

import UIKit


class RoundedAvatar : UIControl{
    @IBInspectable var nameImage : String?
    {
        didSet {
             setupView()
        }
    }
    private var stackView : UIStackView!


//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder : aDecoder)
//    }
    @objc private func clickAvatar(_ sender : UIButton){
         UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1.5,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }){(finished) in UIView.animate(withDuration: 1, animations: {self.transform = CGAffineTransform.identity})}
    }
    private func setupView(){
        if nameImage == nil {return}
        let imageView = UIButton()//UIImageView(image: UIImage(named: nameImage!))
        let views: [UIView] = [imageView]
        //imageView.setImage(UIImage(named: nameImage!), for: .normal)
        
        imageView.loadImageFromUrl(url_: nameImage!)
        imageView.addTarget(self, action: #selector(clickAvatar(_ :)), for: .touchUpInside)

        self.backgroundColor = .clear
        imageView.layer.borderWidth = 1//2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = bounds.width/2
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 6//8
        self.layer.shadowOffset = CGSize.init(width: 2, height: 2)//4
        
        stackView = UIStackView(arrangedSubviews: views)
        self.addSubview(stackView)
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        //guard let aa = bounds else {return}
        stackView.frame = bounds
    }
    
}


extension UIButton {
    func loadImageFromUrl(url_: String) {
        guard let url = URL(string: url_) else {return}
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.setImage(image, for: .normal)
                    }
                }
            }
        }
    }
}


