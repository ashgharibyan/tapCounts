//
//  Gameplay.swift
//  Count Taps
//
//  Created by Ashot Gharibyan on 4/22/17.
//  Copyright © 2017 Ashot Gharibyan. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds
import Firebase

class Gameplay: UIViewController{

    // TODO : befor staring the game have it say Time you are going to have to play!!!!!!!!!
    
    
    
    
    
    
    @IBOutlet var correctView: UIView!
    @IBOutlet var wrongView: UIView!
    @IBOutlet weak var darkView: UIView!
    
    
  
    
    //MARK - PAUSE VIEW
    @IBOutlet var pauseView: viewX!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var resumeBtn: UIButton!
    @IBOutlet weak var homeBtnInPause: UIButton!
    
    
    
    // MARK - CONTINUE VIEW
    @IBOutlet var continueView: viewX!
    var continueUsed = 0
    @IBOutlet var continueYesView: viewX!
    
    
    @IBOutlet weak var pauseBtn: buttonX! // add everywhere
    
    
    @IBOutlet weak var timeOutLbl: UILabel!
    @IBOutlet weak var pressCheckLbl: UILabel!
    
    
    
    
    @IBOutlet weak var topOvalImage: viewX!
    @IBOutlet weak var bottomOvalImg: viewX!
    @IBOutlet weak var scoreNumLbl: UILabel!
    @IBOutlet weak var timeNumLbl: UILabel!
    @IBOutlet weak var numBtn: CircleButton!
    @IBOutlet weak var checkBtn: CircleButton!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    // REVIEW OUTLETS
    @IBOutlet weak var earnedScoreLbl: UILabel!
    @IBOutlet weak var totalScoreLbl: UILabel!
    @IBOutlet weak var rangeLbl: UILabel!
    @IBOutlet weak var totalTimeLbl: UILabel!
    
    // WRONG OUTLETS
    @IBOutlet weak var wTotalScore: UILabel!
    @IBOutlet weak var CircleImage: UIView!
    @IBOutlet weak var readyLbl: UILabel!
// import timpe out text
    
    
    
    @IBOutlet weak var highscoreLbl: UILabel!
    @IBOutlet weak var highscoreNum: UILabel!
    
    
    
    private var countPressed = 0
    private var score = 0
    private var tempScore = 0
    private var isWin = false
    private var additionalTime = 0.0
    var timer = Timer()
    //private var highscore = 0
    
    var audioPlayer = AVAudioPlayer()
    
    private var highscore = 0
    let HighscoreDefault = UserDefaults.standard
    
    
    
    // startWith3Sec seconds
    private var secs = 3
    
    // Seconds you can play (going to add 3 every time time out),, if finished early time adds up!
    private var secsToPlay = 2.0
    private var tempSecsToPlay = 2.0

    private var secsRemained = 0.0

    
    private var numToPress = 0
    // changes also in view did load
    private var minNumToPress: UInt32 = 1
    private var maxNumToPress: UInt32 = 5
    
    
    // AD interstitial
    var interstitial: GADInterstitial!
    var forAd = 0
    
    // AD Banner
    @IBOutlet weak var bannerView: GADBannerView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // MARK - loading Ads
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-9158287114575391/3627028065")
        let request = GADRequest()
        // Request test ads on devices you specify. Your test device ID is printed to the console when
        // an ad request is made.
        
        request.testDevices = [ kGADSimulatorID, "2077ef9a63d2b398840261c8221a0c9b" ]
        interstitial.load(request)
        
        
        //bannerView.isHidden = true
        
        let request2 = GADRequest()
        
        
        // REMOVE THIS WHEN RELEASING THE APPPPPPPPPPPPPP
        request2.testDevices = [ kGADSimulatorID, "81e1b0a84db96aee0d55d6432e0db164" ]

        bannerView.adUnitID = "ca-app-pub-9158287114575391/6218627262"
        bannerView.adSize = kGADAdSizeSmartBannerPortrait
        bannerView.rootViewController = self
        bannerView.load(request2)
        
        // Finish loading ads--------
        
        
        
        
        
        
        //RESETING values
        minNumToPress = 1
        maxNumToPress = 5
        secsToPlay = 2.0
        additionalTime = 0.0
        score = 0
        countPressed = 0
        secs = 3
        readyLbl.font = UIFont(name: readyLbl.font.fontName, size: 75)
        readyLbl.text = "READY!"
        
        numToPress = Int((arc4random() % maxNumToPress) + minNumToPress)
        checkBtn.isHidden = true
        
        // HIDING top and bottom rects
        topOvalImage.isHidden = true
        scoreNumLbl.isHidden = true
        scoreLbl.isHidden = true
        
        bottomOvalImg.isHidden = true
        timeNumLbl.isHidden = true
        timeLbl.isHidden = true
        pauseBtn.isHidden = true
        
        //Setting default numbers
        numBtn.setTitle("\(numToPress)", for: UIControlState.normal)
        scoreNumLbl.text = "\(score)"
        
        if(HighscoreDefault.value(forKey: "Highscore") != nil)
        {
            highscore = HighscoreDefault.value(forKey: "Highscore") as! NSInteger!
            
        }
        
        startWith3Sec()
        
       
    }
    
    
    
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.isHidden = false
    }
    
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerView.isHidden = true
    }
    
 
    
    
    
    
    func startGame()
    {
        CircleImage.isHidden = true
        readyLbl.isHidden = true
        numBtn.isHidden = false
        checkBtn.isHidden = false
        
        topOvalImage.isHidden = false
        scoreNumLbl.isHidden = false
        scoreLbl.isHidden = false
        
        bottomOvalImg.isHidden = false
        timeNumLbl.isHidden = false
        timeLbl.isHidden = false
        pauseBtn.isHidden = false

        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(Gameplay.gameTime), userInfo: nil, repeats: true)

        
    }
    
    func gameTime()
    {
    
        if(secsToPlay > 0.0)
        {
            secsToPlay-=0.1
            if(secsToPlay<0.001)
            {
                secsToPlay = 0
                timeNumLbl.text = "0"
            } else{
                timeNumLbl.text = String(format:"%.1f", secsToPlay)
            }
        } else{
            timer.invalidate()
            numBtn.isHidden = true
            timeOutLbl.isHidden = false
            pressCheckLbl.isHidden = false
            
            
            checkBtn.transform = CGAffineTransform(translationX: -10, y: 0)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                self.checkBtn.transform = .identity
            })
           
            
        }
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    // Ready!...3...2...1...GO!
    func startWith3Sec()
    {
        CircleImage.isHidden = false
        readyLbl.isHidden = false
        numBtn.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Gameplay.start3Sec), userInfo: nil, repeats: true)
    }
    
    
    //Helper of startWith3Sec()
    func start3Sec()
    {
        if(secs >= 0)
        {
           
            readyLbl.transform = CGAffineTransform(rotationAngle: 3.14)
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                self.readyLbl.transform = .identity
            })
            
            if(secs == 0)
            {
                readyLbl.font = UIFont(name: readyLbl.font.fontName, size: 100)
                readyLbl.text = "GO!"
            } else{
                readyLbl.font = UIFont(name: readyLbl.font.fontName, size: 150)
                readyLbl.text = "\(secs)"
                
           }
            
            secs-=1
            
        } else{
        
            timer.invalidate()
            startGame()
        }
    
    }
    
    
    
    
    
    
    // Adding one to countPressed when button is clicked
    @IBAction func numBtnPressed(_ sender: Any) {
        countPressed+=1
        assignSound(name: "blop", type: "mp3")
        audioPlayer.play()
        
    }


    // Assigns isWin true if score = countPressed
    @IBAction func checkBtnPressed(_ sender: Any) {
        // make this function show if you got it right or nah
        // make a bool var that checks if these two are equal and use it in idk
        assignSound(name: "blop", type: "mp3")
        audioPlayer.play()
        
        isWin = (countPressed == numToPress)
        timer.invalidate()
        
        
        if(isWin)
        {
            
            // CASE When its correct
            
            view.addSubview(correctView)
            correctView.center = view.center
            darkView.isHidden = false
            
            correctView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                self.correctView.transform = .identity
            })
            //, completion:((Bool) -> Void)?
            
            
            timeOutLbl.isHidden = true
            pressCheckLbl.isHidden = true
            earnedScoreLbl.text = "+" + "\(numToPress)"
            score+=numToPress
            totalScoreLbl.text = "\(score)"
            
       
            if(score >= 0 && score < 5)
            {
                secsToPlay = 2.0
                minNumToPress = 1
                maxNumToPress = 5
            
            } else if(score >= 5 && score < 20)
            {
                minNumToPress = 5
                maxNumToPress = 10
                secsToPlay = 3.0
                tempScore = 0
                tempSecsToPlay = secsToPlay
            }else{
                //let diff = score - tempScore
                if(UInt32(score)>=(UInt32(tempScore) + maxNumToPress * 2))
                {
                    tempScore = tempScore + Int(maxNumToPress)*2
                    minNumToPress+=5
                    maxNumToPress+=5
                    secsToPlay = tempSecsToPlay + 1.0
                    tempSecsToPlay = secsToPlay
                } else
                {
                    secsToPlay = tempSecsToPlay
                }
            }
            
            
            
            rangeLbl.text = "\(minNumToPress) - \(maxNumToPress)"
            
            totalTimeLbl.text = String(format:"%.1f", secsToPlay)

            
            earnedScoreLbl.transform = CGAffineTransform(translationX: 225, y: 0)
            totalScoreLbl.transform = CGAffineTransform(translationX: 225, y: 0)
            rangeLbl.transform = CGAffineTransform(translationX: 225, y: 0)
            totalTimeLbl.transform = CGAffineTransform(translationX: 225, y: 0)

            
            UIView.animate(withDuration: 0.5, animations: {
                self.earnedScoreLbl.transform = .identity
            }, completion: { (true) in
                self.showTotalScore()
            })
            
            
            
        
            
            
            
            
            
            
            
            
            
            
        
        } else{
            
            // TODO - pop up for continue
            //
            // learn about completeion handlers in swift
            // make if go home pressed display an AD
            // put the check in user defaults
            // check what the error is when running app
                        //            2017-05-10 00:00:59.287727-0700 Count Taps[19325:5812219] [DYMTLInitPlatform] platform initialization successful
                        //            2017-05-10 00:01:03.111588-0700 Count Taps[19325:5812209] <Google> To get test ads on this device, call: request.testDevices                                                 = @[ @"81e1b0a84db96aee0d55d6432e0db164" ];
                        //            2017-05-10 00:01:03.113391-0700 Count Taps[19325:5812275] Metal GPU Frame Capture Enabled
                        //            2017-05-10 00:01:03.113831-0700 Count Taps[19325:5812275] Metal API Validation Enabled
                        //            2017-05-10 00:01:03.145487-0700 Count Taps[19325:5812275] libMobileGestalt MobileGestaltSupport.m:153: pid 19325 (Count Taps) does not have sandbox access for frZQaeyWLUvLjeuEK43hmg and IS NOT appropriately entitled
                        //            2017-05-10 00:01:03.145545-0700 Count Taps[19325:5812275] libMobileGestalt MobileGestalt.c:550: no access to InverseDeviceID (see <rdar://problem/11744455>)
                        //            2017-05-10 00:01:03.332239-0700 Count Taps[19325:5812229] <Google:HTML> You are currently using version 7.19.1 of the SDK. Please consider updating your SDK to the most recent SDK version to get the latest features and bug fixes. The latest SDK can be downloaded from http://goo.gl/iGzfsP. A full list of release notes is available at https://developers.google.com/admob/ios/rel-notes.
                        //
            
            if(score > 10 && interstitial.isReady && continueUsed == 0)
            {
                darkView.isHidden = false
                continueView.center = view.center
                continueView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
            
                UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
                
                    self.view.addSubview(self.continueView)
                    self.continueView.transform = .identity
                })
                
                continueUsed+=1
            } else {
                caseWrong()
            }
            
        
            
        }
    }
    
    
//Showing correct view numbers - functions
    func showTotalScore(){
        UIView.animate(withDuration: 0.5, animations: {
            self.totalScoreLbl.transform = .identity
        }) { (true) in
            self.showRange()
        }
    }
    
    func showRange(){
        UIView.animate(withDuration: 0.5, animations: {
            self.rangeLbl.transform = .identity
        }) { (true) in
            self.showTotalTime()
        }
    }
    
    func showTotalTime(){
        UIView.animate(withDuration: 0.5, animations: {
            self.totalTimeLbl.transform = .identity
        })
    }
    
    
    @IBAction func nextBtnPressed(_ sender: Any) {
    
        assignSound(name: "blop", type: "mp3")
        audioPlayer.play()

        correctView.removeFromSuperview()
        darkView.isHidden = true

        topOvalImage.isHidden = false
        scoreNumLbl.isHidden = false
        scoreLbl.isHidden = false
        
        numBtn.isHidden = false
        checkBtn.isHidden = false // make a ready go!!! ??
        
        bottomOvalImg.isHidden = false
        timeNumLbl.isHidden = false
        timeLbl.isHidden = false
        pauseBtn.isHidden = false

        
                // make score and timer for game
        
        
        numToPress = (Int(arc4random_uniform(maxNumToPress-minNumToPress+1) + minNumToPress))
        scoreNumLbl.text = "\(score)"
        timeNumLbl.text = "\(secsToPlay)"
        numBtn.setTitle("\(numToPress)", for: UIControlState.normal)
        countPressed = 0
        continueGame(secsToPlay)
       
        
    }
    
    func continueGame(_ secsRem: Double)
    {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(Gameplay.gameTime), userInfo: nil, repeats: true)
    }
    
    
    
    //229 19 0
    
    @IBAction func restartBtnPressed(_ sender: Any) {
        
        //self.view.backgroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 205/255.0, alpha: 1.0)
        assignSound(name: "blop", type: "mp3")
        audioPlayer.play()
        
        wrongView.removeFromSuperview()
        darkView.isHidden = true

        topOvalImage.isHidden = false
        scoreNumLbl.isHidden = false
        scoreLbl.isHidden = false
        
        numBtn.isHidden = false
        checkBtn.isHidden = false
        
        bottomOvalImg.isHidden = false
        timeNumLbl.isHidden = false
        timeLbl.isHidden = false
        pauseBtn.isHidden = false
        
        
        highscoreLbl.textColor = UIColor(red: 229/255.0, green: 19/255.0, blue: 0/255.0, alpha: 1.0)
        highscoreLbl.text = "High Score"
        highscoreNum.textColor = UIColor(red: 229/255.0, green: 19/255.0, blue: 0/255.0, alpha: 1.0)
        
        continueUsed = 0
        
        viewDidLoad()
        
        
        
    }
    
    
    @IBAction func homeBtnPressed(_ sender: Any) {
        assignSound(name: "off", type: "mp3")
        audioPlayer.play()
        dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func pauseBtnPressed(_ sender: Any) {
        assignSound(name: "off", type: "mp3")
        audioPlayer.play()
        view.addSubview(pauseView)
        pauseView.center = view.center
        
        timer.invalidate()
        secsRemained = secsToPlay
        darkView.isHidden = false
        
        logoImg.alpha = 0
        resumeBtn.alpha = 0
        homeBtnInPause.alpha = 0
        
        resumeBtn.transform = CGAffineTransform(translationX: 50, y: -120)
        homeBtnInPause.transform = CGAffineTransform(translationX: -50, y: -120)
        
        
        UIView.animate(withDuration: 1, animations: {
            self.logoImg.alpha = 1
        }) { (true) in
            UIView.animate(withDuration: 0.5, animations: {
                self.resumeBtn.alpha = 1
                self.homeBtnInPause.alpha = 1
                self.resumeBtn.transform = .identity
                self.homeBtnInPause.transform = .identity
            }, completion: { (true) in
                self.resumeBtn.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
                self.homeBtnInPause.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
                UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
                    self.resumeBtn.transform = .identity
                    self.homeBtnInPause.transform = .identity
                })
            })
        }

    }
    
    
    @IBAction func resumePressed(_ sender: Any) {
        assignSound(name: "on", type: "mp3")
        audioPlayer.play()
        darkView.isHidden = true
        pauseView.removeFromSuperview()
        continueGame(secsRemained)
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
    
    
    // CONTINUE VIEW BUTTON METHODS
    
    @IBAction func continueYesPressed(_ sender: Any) {
        
        contYesHelper { 
            self.continueView.removeFromSuperview()
            self.darkView.isHidden = false
            self.continueYesView.center = self.view.center
            self.view.addSubview(self.continueYesView)
        }
        
        
    }
    
    func contYesHelper(completion: (() -> ())?)
    {
        interstitial.present(fromRootViewController: self)
        completion!()
    }
    
    
    @IBAction func continueGameBtnPressed(_ sender: Any) {
        
        
        continueYesView.removeFromSuperview()
        darkView.isHidden = true
        timeOutLbl.isHidden = true
        pressCheckLbl.isHidden = true
        
        topOvalImage.isHidden = false
        scoreNumLbl.isHidden = false
        scoreLbl.isHidden = false
        
        numBtn.isHidden = false
        checkBtn.isHidden = false // make a ready go!!! ??
        
        bottomOvalImg.isHidden = false
        timeNumLbl.isHidden = false
        timeLbl.isHidden = false
        pauseBtn.isHidden = false
        
        
        
        secsToPlay = tempSecsToPlay
        numToPress = (Int(arc4random_uniform(maxNumToPress-minNumToPress+1) + minNumToPress))
        scoreNumLbl.text = "\(score)"
        timeNumLbl.text = "\(secsToPlay)"
        numBtn.setTitle("\(numToPress)", for: UIControlState.normal)
        countPressed = 0
        continueGame(secsToPlay)

        
        
    }
    
    
    
    
    @IBAction func continueNoPressed(_ sender: Any) {
        
        
        continueView.removeFromSuperview()
        caseWrong()
        
        
        
    }
    
    
    
    
    
    func caseWrong()
    {
        
        // CASE When its wrong
        if(forAd >= 2)
        {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
                forAd = 0
                
            } else {
                
            }
            
        }
        else{
            forAd+=1
        }
        
        
        // AD FINISH -------
        
        
        
        timeOutLbl.isHidden = true
        pressCheckLbl.isHidden = true
        
        wTotalScore.text = "\(score)"
        
        
        view.addSubview(wrongView)
        wrongView.center = view.center
        darkView.isHidden = false
        
        wrongView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.wrongView.transform = .identity
        })
        
        if(score > highscore)
        {
            highscore = score
            HighscoreDefault.setValue(score, forKey: "Highscore")
            HighscoreDefault.synchronize()
            
            highscoreLbl.textColor = UIColor(red: 0/255.0, green: 250/255.0, blue: 146/255.0, alpha: 1.0)
            highscoreLbl.text = "New High Score!"
            highscoreNum.textColor = UIColor(red: 0/255.0, green: 250/255.0, blue: 146/255.0, alpha: 1.0)
        }
        highscoreNum.text = "\(highscore)"
        
        
        
        wTotalScore.transform = CGAffineTransform(translationX: 225, y: 0)
        highscoreNum.transform = CGAffineTransform(translationX: 225, y: 0)
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.wTotalScore.transform = .identity
        }, completion: { (true) in
            UIView.animate(withDuration: 0.5, animations: {
                self.highscoreNum.transform = .identity
            })
        })
        
        

    }
    
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    

}
