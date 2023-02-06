//
//  HowToVC.swift
//  Count Taps
//
//  Created by Ashot Gharibyan on 5/3/17.
//  Copyright © 2017 Ashot Gharibyan. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds

class HowToVC: UIViewController {

    
    @IBOutlet weak var gp: imageViewX!
    @IBOutlet weak var homeBtn: buttonX!
    
    // BannerView
    @IBOutlet weak var bannerView: GADBannerView!

    
    var audioPlayer = AVAudioPlayer()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // AD
       // bannerView.isHidden = true
        
        let request = GADRequest()
        
        
        // REMOVE THIS WHEN RELEASING THE APPPPPPPPPPPPPP
        request.testDevices = [ kGADSimulatorID, "81e1b0a84db96aee0d55d6432e0db164" ]
        
        bannerView.adUnitID = "ca-app-pub-9158287114575391/6218627262"
        bannerView.adSize = kGADAdSizeSmartBannerPortrait
        bannerView.rootViewController = self
        bannerView.load(request)
        //--------------------
        
    
    }
    
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.isHidden = false
    }
    
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerView.isHidden = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        homeBtn.transform = CGAffineTransform(translationX: -10, y: 0)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.homeBtn.transform = .identity
        })
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func goHome(_ sender: Any) {
        
//        UIView.animate(withDuration: 1, animations: {
//            self.assignSound(name: "off", type: "mp3")
//            self.audioPlayer.play()
//        }) { (true) in
//            self.dismiss(animated: false, completion: nil)
//        }
        
        
        self.dismiss(animated: false, completion: nil)

    }

    
    
    func assignSound(name: String, type: String)
    {
        
        do{
            
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: name, ofType: type)!))
            audioPlayer.prepareToPlay()
        }
        catch{
            print(error)
        }
        
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
