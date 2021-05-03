//
//  QuestionPageViewController.swift
//  Quiz
//
//  Created by SRV InfoTech on 10/05/20.
//

import UIKit
import Alamofire

struct questionData {
    var question = String()
    var answer = String()
    var optionValue = [String]()
    var type = String()
}

class QuestionPageViewController: UIViewController {

    @IBOutlet weak var progressTextLabel: UILabel!
    @IBOutlet weak var questionTable: UITableView!
    
    @IBOutlet weak var progressBarLabel: UIProgressView!
    @IBOutlet weak var titleLabel: UINavigationItem!
    
    @IBOutlet weak var option3: UIButton!{
        didSet{
            option3.layer.cornerRadius = 4
            option3.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var option4: UIButton!{
        didSet{
            option4.layer.cornerRadius = 4
            option4.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var option2: UIButton!{
        didSet{
            option2.layer.cornerRadius = 4
            option2.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var option1: UIButton!{
        didSet{
            option1.layer.cornerRadius = 4
            option1.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var submitButton: UIButton!{
        didSet{
            submitButton.layer.cornerRadius = 4
            submitButton.layer.masksToBounds = true
        }
    }
    
    var categoryname = ""
    var catid = ""
    
    
    @IBOutlet weak var questionLabel: UILabel!
    var optionArray = [String]()
    var mainArray = [questionData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.categoryname
        questionFunction()
    }
    
   
   
    func questionFunction(){
        let url = QUIZ.QUESTIONBYCATEGORY_URL + catid
        
        AF.request(url, method: .get).responseJSON(completionHandler: { response in
            
            if let response_data = response.value as? NSDictionary{
        
                
                var responsevalue = ""
                if let cdata = response_data.value(forKey: "response_code") as? String{
                    responsevalue = cdata
                }
                if let cdata = response_data.value(forKey: "response_code") as? Int{
                    responsevalue = String(cdata)
                }
                if let cdata = response_data.value(forKey: "response_code") as? NSInteger{
                    responsevalue = String(cdata)
                }
                
                
                let resultdata = response_data.value(forKey: "results") as! [NSDictionary]
                
                for rdata in resultdata{
                    
                    let question1 = rdata.value(forKey: "question") as! String
                    let question = question1.removingPercentEncoding
                    let answer1 = rdata.value(forKey: "correct_answer") as! String
                    let answer = answer1.removingPercentEncoding
                    let optionvalue = rdata.value(forKey: "incorrect_answers") as! [String]
                    let qtype = rdata.value(forKey: "type") as! String
    
                    self.optionArray = optionvalue
                    self.optionArray.append(answer!)
                    self.mainArray.append(questionData(question: question!, answer: answer!, optionValue: self.optionArray, type: qtype))
                    
                    
                }
                self.currentQuestion = self.mainArray[0]
                self.setQuestions()
            }
            
        })
        
    }
    
    var currentQuestion: questionData?
    var currentQuestionPosition: Int = 0
    var noCorrect: Int = 0
    
    func setQuestions() {
        option1.layer.borderColor = UIColor.clear.cgColor
        option1.layer.borderWidth = 0.0
        option2.layer.borderColor = UIColor.clear.cgColor
        option2.layer.borderWidth = 0.0
        option3.layer.borderColor = UIColor.clear.cgColor
        option3.layer.borderWidth = 0.0
        option4.layer.borderColor = UIColor.clear.cgColor
        option4.layer.borderWidth = 0.0
        
        self.progressTextLabel.text = "Question \(currentQuestionPosition+1)/5"
        self.questionLabel.text = String(htmlEncodedString: self.currentQuestion!.question)
        if self.currentQuestion!.type == "boolean"{
            self.option1.setTitle(self.currentQuestion!.optionValue[0], for: .normal)
            self.option2.setTitle(self.currentQuestion!.optionValue[1], for: .normal)
            self.option3.isHidden = true
            self.option4.isHidden = true
        }
        else{
            self.option1.setTitle(self.currentQuestion!.optionValue[0], for: .normal)
            self.option2.setTitle(self.currentQuestion!.optionValue[1], for: .normal)
            self.option3.setTitle(self.currentQuestion!.optionValue[2], for: .normal)
            self.option4.setTitle(self.currentQuestion!.optionValue[3], for: .normal)
        }
        self.progressBarLabel.progress = self.progressBarLabel.progress + 0.20
        
    }
    
    func loadNextQuestion() {
        if (currentQuestionPosition + 1 < mainArray.count) {
            currentQuestionPosition += 1
            currentQuestion = mainArray[currentQuestionPosition]
            setQuestions()
        } else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "QuizEndViewControllerID") as! QuizEndViewController
            newViewController.correctanswer = noCorrect
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    
    func checkAnswer(answer: String) {
        if (currentQuestion!.answer == answer) {
            noCorrect += 1
        }
        loadNextQuestion()
    }
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        
        
    }
    
    
    @IBAction func option1Clicked(_ sender: Any) {
        option1.layer.borderColor = UIColor.gray.cgColor
        option1.layer.borderWidth = 1.0
        checkAnswer(answer: option1.currentTitle!)
    }
    
    
    @IBAction func option2Clicked(_ sender: Any) {
        option2.layer.borderColor = UIColor.gray.cgColor
        option2.layer.borderWidth = 1.0
        checkAnswer(answer: option2.currentTitle!)
    }
    
    
    @IBAction func option3Clicked(_ sender: Any) {
        option3.layer.borderColor = UIColor.gray.cgColor
        option3.layer.borderWidth = 1.0
        checkAnswer(answer: option3.currentTitle!)
    }
    
    
    @IBAction func option4Clicked(_ sender: Any) {
        option4.layer.borderColor = UIColor.gray.cgColor
        option4.layer.borderWidth = 1.0
        checkAnswer(answer: option4.currentTitle!)
    }
    
}
