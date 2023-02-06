//
//  SettingsVC.swift
//  Count Taps
//
//  Created by Ashot Gharibyan on 4/26/17.
//  Copyright © 2017 Ashot Gharibyan. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds



class SettingsVC: UIViewController {

    let HighscoreDefault = UserDefaults.standard
    
    @IBOutlet weak var resetBtn: buttonX!
    @IBOutlet weak var goBackBtn: UIButton!
    //ays - ARE YOU SURE
    
    @IBOutlet var areYouSureView: viewX!
    
    @IBOutlet weak var aysView: viewX!
    
    @IBOutlet weak var darkView: UIView!
    
    // BannerView
    @IBOutlet weak var bannerView: GADBannerView!

    var audioPlayer = AVAudioPlayer()

    
    
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
        
        
        
        resetBtn.alpha = 1
        goBackBtn.alpha = 1
        resetBtn.setTitle("RESET HIGH SCORE", for: .normal)
    }

    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.isHidden = false
    }
    
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerView.isHidden = true
    }
    
    
    
   
    @IBAction func resetHighScorePressed(_ sender: Any) {
        assignSound(name: "blop", type: "mp3")
        audioPlayer.play()
        
        darkView.isHidden = false
        areYouSureView.center = view.center
        areYouSureView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            
            self.view.addSubview(self.areYouSureView)
            self.areYouSureView.transform = .identity
            })
        
    }
    // TODO - hide everything when go back pressed
    
    
    
    @IBAction func yesBtnPressed(_ sender: Any) {
    
        assignSound(name: "on", type: "mp3")
        audioPlayer.play()
        
        HighscoreDefault.setValue(0, forKey: "Highscore")
        resetBtn.setTitle("RESETED!", for: .normal)
        closeAYSView()
    }
    
    
    @IBAction func noBtnPressed(_ sender: Any) {
        assignSound(name: "off", type: "mp3")
        audioPlayer.play()
        closeAYSView()
    }
    
    
    
    func closeAYSView()
    {

        areYouSureView.transform = .identity

        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.areYouSureView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }){ (true) in
            UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
                self.areYouSureView.removeFromSuperview()
            })
        }
        
        darkView.isHidden = true
    }
    
    
    // COLOR CHANGE
    
    //        self.resetBtn.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
    //
    //        UIView.animate(withDuration: 0.2, animations: {
    //            self.resetBtn.backgroundColor = UIColor(red: 229/255.0, green: 19/255.0, blue: 0/255.0, alpha: 1.0)
    //
    //        }) { (true) in
    //            UIView.animate(withDuration: 0.2, animations: {
    //                self.resetBtn.backgroundColor = UIColor(red: 84/255.0, green: 84/255.0, blue: 84/255.0, alpha: 1.0)
    //            })
    //        }
    //
    
    
    //SHAKE
    
    //        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
    //            self.resetBtn.transform = .identity
    //        })
    
    
    
    
    
    
    //-324
    //-224
    
    
    
    
    @IBAction func goBackPressed(_ sender: Any) {
        
        assignSound(name: "off", type: "mp3")
        audioPlayer.play()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.resetBtn.transform = CGAffineTransform(translationX: -324, y: 0)
        }) { (true) in
            UIView.animate(withDuration: 0.3, animations: {
                self.goBackBtn.transform = CGAffineTransform(translationX: -224, y: 0)
            }) { (true) in
                self.dismiss(animated: false, completion: nil)
            }
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
