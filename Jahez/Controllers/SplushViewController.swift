//
//  SplushViewController.swift
//  Jahez
//
//  Created by iOS Developer on 04/03/2022.
//

import UIKit
import AVKit

class SplushViewController: UIViewController {
    
    var player: AVPlayer? = AVPlayer()
    
    weak var timer: Timer?
    
    func stopTimer() {
        timer?.invalidate()
    }
    
}

//MARK: - LifeCycle
extension SplushViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        initializeVideoPlayerWithVideo()
        
        DispatchQueue.main.async {
            self.player?.play()
        }
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 4.5, repeats: true) { [weak self] _ in
            self?.timer?.invalidate()
            let vc = RestaurantsViewController()
            (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(vc)
        }
        
    }

}

extension SplushViewController {
    
    func initializeVideoPlayerWithVideo() {
        
        // get the path string for the video from assets
        let videoString:String? = Bundle.main.path(forResource: "jahez", ofType: "mp4")
        
        guard let unwrappedVideoPath = videoString else {return}
        
        // convert the path string to a url
        let videoUrl = URL(fileURLWithPath: unwrappedVideoPath)
        
        // initialize the video player with the url
        self.player = AVPlayer(url: videoUrl)
        
        // create a video layer for the player
        let layer: AVPlayerLayer = AVPlayerLayer(player: player)
        
        // make the layer the same size as the container view
        layer.frame = view.frame
        
        // make the video fill the layer as much as possible while keeping its aspect size
        layer.videoGravity = AVLayerVideoGravity.resizeAspect
        
        // add the layer to the container view
        self.view.layer.addSublayer(layer)

    }

}
