//
//  MenuVC.swift
//  Count Taps
//
//  Created by Ashot Gharibyan on 4/22/17.
//  Copyright © 2017 Ashot Gharibyan. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds

class MenuVC: UIViewController {

    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var startBtn: buttonX!
    @IBOutlet weak var settingsBtn: buttonX!
    @IBOutlet weak var howToBtn: buttonX!
    @IBOutlet weak var creditsBtn: buttonX!
    
    @IBOutlet weak var topHSView: viewX!
    @IBOutlet weak var highscore: UILabel!
    @IBOutlet weak var removeAdsBtn: buttonX!
    
    
    @IBOutlet var creditsVC: viewX!
    @IBOutlet weak var darkView: UIView!
    
    // BannerView
    @IBOutlet weak var bannerView: GADBannerView!

    
    var audioPlayer = AVAudioPlayer()
    let HighscoreDefault = UserDefaults.standard


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // AD
        //bannerView.isHidden = true
        
        let request = GADRequest()
        
        
        // REMOVE THIS WHEN RELEASING THE APPPPPPPPPPPPPP
        request.testDevices = [ kGADSimulatorID, "81e1b0a84db96aee0d55d6432e0db164" ]
        
        bannerView.adUnitID = "ca-app-pub-9158287114575391/6218627262"
        bannerView.adSize = kGADAdSizeSmartBannerPortrait
        bannerView.rootViewController = self
        bannerView.load(request)
        //--------------------
        
        
        
        
        bgImage.alpha = 0
        startBtn.alpha = 0
        settingsBtn.alpha = 0
        howToBtn.alpha = 0
        creditsBtn.alpha = 0
        removeAdsBtn.alpha = 0
        topHSView.alpha = 0
       
    }
    
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.isHidden = false
    }
    
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerView.isHidden = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
       
        
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.bgImage.alpha = 0.2
        }) { (true) in
            self.showStartBtn()
        }
        
        
        let hs = HighscoreDefault.string(forKey: "Highscore")
        highscore.text = hs
        
        
    }
    
    func showStartBtn() {
    
        UIView.animate(withDuration: 1, animations: {
            
            self.startBtn.alpha = 1
        }) { (true) in
            self.showSettingsBtn()
        }
    
    }
    
    
    func showSettingsBtn() {
        
        settingsBtn.transform = CGAffineTransform(translationX: 75, y: -175)
        creditsBtn.transform = CGAffineTransform(translationX: -75, y: -175)
        howToBtn.transform = CGAffineTransform(translationX: 0, y: 175)
        
        UIView.animate(withDuration: 1, animations: {
            self.settingsBtn.alpha = 1
            self.creditsBtn.alpha = 1
            self.howToBtn.alpha = 1
            self.settingsBtn.transform = .identity
            self.creditsBtn.transform = .identity
            self.howToBtn.transform = .identity

        }) { (true) in
            UIView.animate(withDuration: 1, animations: {
                self.removeAdsBtn.alpha = 1
                self.topHSView.alpha = 1
            })
        }
    }
    
    
    @IBAction func startBtnPressed(_ sender: Any) {
    
        
        assignSound(name: "blop", type: "mp3")
        audioPlayer.play()
        
        
        
        startBtn.transform = CGAffineTransform(rotationAngle: 3.14)
        
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.startBtn.transform = .identity
        }) { (true) in
            self.performSegue(withIdentifier: "gameplay", sender: self)
        }
        
    
    }
    
    
    
    @IBAction func settingsPressed(_ sender: Any) {
        assignSound(name: "on", type: "mp3")
        audioPlayer.play()
        
        settingsBtn.transform = CGAffineTransform(rotationAngle: 3.14)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.settingsBtn.transform = .identity
        }) { (true) in
            self.performSegue(withIdentifier: "settings", sender: self)
        }
        
        
        
    }
    
    
    
    
    @IBAction func creditsPressed(_ sender: Any) {
        
        
        assignSound(name: "blop", type: "mp3")
        audioPlayer.play()
        
        creditsBtn.transform = CGAffineTransform(rotationAngle: 3.14)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.creditsBtn.transform = .identity
        }) { (true) in
            self.creditsVC.center = self.view.center
            self.darkView.isHidden = false
            self.creditsVC.transform = CGAffineTransform(scaleX: 1.2, y: 0.8)
            UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
                self.view.addSubview(self.creditsVC)
                self.creditsVC.transform = .identity
            })
        }
        
        
       
        
    }
    
    
    @IBAction func closeCreditsVC(_ sender: Any) {
        
        creditsVC.transform = .identity
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.creditsVC.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }){ (true) in
            UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
                self.creditsVC.removeFromSuperview()
            })
        }
        
        darkView.isHidden = true
    }
    
    
    
    @IBAction func howToPressed(_ sender: Any) {
        
        assignSound(name: "on", type: "mp3")
        audioPlayer.play()
        
        howToBtn.transform = CGAffineTransform(rotationAngle: 3.14)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.howToBtn.transform = .identity
        }) { (true) in
            self.performSegue(withIdentifier: "howTo", sender: self)
        }
        
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

