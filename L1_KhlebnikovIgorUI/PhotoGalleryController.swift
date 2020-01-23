//
//  PhotoGalleryController.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Igor on 10/9/19.
//  Copyright © 2019 Igor. All rights reserved.
//

import UIKit

enum MoveTo{
    case left
    case right
}

class PhotoGalleryController : UIViewController{
    var vkApi = VKApi()
    
    @IBOutlet weak var image: UIImageView!
    var imageIndex = 0
    //let imageList = ["2","3","1","4"]
    var imageList = [String]()
    var maxImages = 0
    let panGestureRecognizer = UIPanGestureRecognizer()
    var began: Float!
    var interactiveAnimator: UIViewPropertyAnimator!
    var start: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vkApi.getPhotos(token: Session.shared.token) { result in
           switch result {
              case  .success(let photos):
                    for photo in photos {
                        self.imageList.append(photo.sizes[3].url)
                    }
                    self.maxImages = self.imageList.count
              case .failure(let error):
                print(error.localizedDescription)
              }
            }
        
        image.image = UIImage(named: "2")
        panGestureRecognizer.addTarget(self, action: #selector(handlePanGesture(_:)))
        panGestureRecognizer.maximumNumberOfTouches = 1
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func handlePanGesture (_ recognizer : UIPanGestureRecognizer){
        guard panGestureRecognizer === recognizer else {assert(false); return}
        
        switch recognizer.state {
        case .began:
            began = Float(recognizer.translation(in: view).x)
            start = true
            
        case .changed:
          let translation = recognizer.translation(in: self.view)
            if began-Float(translation.x) > 0 {
                //left swipe
                if start {
                    startBegan(moveTo: .left)
                }
                interactiveAnimator.fractionComplete = -translation.x / 100
            }else{
                //right swipe
                if start {
                    startBegan(moveTo: .right)
                }
                interactiveAnimator.fractionComplete = translation.x / 100
            }
            
        case .cancelled, .ended:
            start = false
            let gesturePoint = recognizer.translation(in: view)
            if abs(began - Float(gesturePoint.x)) > 100 {
                if began - Float(gesturePoint.x) > 0 {
                //left
                changePhoto(moveTo: .left)
                }else{
                //right
                changePhoto(moveTo: .right)
                }
            }
            interactiveAnimator.stopAnimation(true)
            interactiveAnimator.addAnimations {
                self.image.transform = .identity
            }
            interactiveAnimator.startAnimation()
            
        case .failed, .possible:
            start = false
        @unknown default:
                    break
        }
    }
    
    func startBegan(moveTo: MoveTo){
        interactiveAnimator?.startAnimation()
        interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                     dampingRatio: 0.5,
                                                     animations: {
                                                        self.image.transform = CGAffineTransform(translationX: moveTo == .left ? -150 : 150,
                                                                                                 y: 0)
        })
        interactiveAnimator.pauseAnimation()
        start = false
    }
    
    func changePhoto(moveTo: MoveTo) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 1.5,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {
                        self.view.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        })
        {(finished) in UIView.animate(withDuration: 1, animations: {self.view.transform = CGAffineTransform.identity})}
        
        switch moveTo {
        case .left:
            imageIndex+=1
            if imageIndex >= maxImages {
                imageIndex = maxImages - 1
            }
            print("left")
            print(imageIndex)
            image.image = UIImage(named: imageList[imageIndex])
        case .right:
            imageIndex-=1
            if imageIndex < 0 {
                imageIndex = 0
            }
            print(imageIndex)
            print("right")
            image.image = UIImage(named: imageList[imageIndex])
        }
    }
}
