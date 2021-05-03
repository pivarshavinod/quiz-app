//
//  QuizEndViewController.swift
//  Quiz
//
//  Created by SRV InfoTech on 10/05/20.
//

import UIKit
import Lottie

class QuizEndViewController: UIViewController {
    
    let animationview  = AnimationView()

    @IBOutlet weak var quizStatusLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!{
        didSet{
            backButton.layer.cornerRadius = 6
            backButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var viewColor: UIView!{
        didSet{
            viewColor.layer.cornerRadius = 6
            viewColor.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var mainView: UIView!
    
    var correctanswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if correctanswer == 0{
            setupAnimation1()
            quizStatusLabel.text = "Failed!"
        }
        else{
            setupAnimation()
            quizStatusLabel.text = "Congrats!"
        }
    
        var count = UserDefaults.standard.integer(forKey: "ScoreCount")
        count = count + correctanswer
        UserDefaults.standard.set(count, forKey: "ScoreCount")
        let percentage = (correctanswer * 100 ) / 5
        scoreLabel.text = "\(percentage)% Score"
        commentLabel.text = "You attempted 5 questions and from that \(correctanswer) answers are correct."
        
    }
    

    func setupAnimation(){
        animationview.animation = Animation.named("14995-roger")
        animationview.frame = mainView.bounds
        animationview.contentMode = .scaleAspectFit
        animationview.loopMode = .loop
        animationview.play()
        mainView.addSubview(animationview)
    }
    
    func setupAnimation1(){
        animationview.animation = Animation.named("12821-failed-attempt")
        animationview.frame = mainView.bounds
        animationview.contentMode = .scaleAspectFit
        animationview.loopMode = .loop
        animationview.play()
        mainView.addSubview(animationview)
    }
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
    
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    

}
