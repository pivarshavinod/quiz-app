//
//  HomePageViewController.swift
//  Quiz
//
//  Created by SRV InfoTech on 10/05/20.
//

import UIKit
import Alamofire

class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var scoreCountLabel: UILabel!
    @IBOutlet weak var homeTable: UITableView!
    @IBOutlet weak var scoreView: UIView!{
        didSet{
            scoreView.layer.cornerRadius = 8
            scoreView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var questionCountStackWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var scoreCountStackWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var scoreViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var quizView: UIView!{
        didSet{
            quizView.layer.cornerRadius = 8
            quizView.layer.masksToBounds = true
        }
    }
    
    var categoryArray = [categoryData]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let screenwidth = (UIScreen.main.bounds.size.width - 85) / 2
        
        scoreCountStackWidthConstraint.constant = screenwidth
        questionCountStackWidthConstraint.constant = screenwidth
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.scoreCountLabel.text = "\(UserDefaults.standard.integer(forKey: "ScoreCount"))"
        categoryFunction()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomePageID", for: indexPath) as! HomePageTableViewCell
        cell.categoryName.text = categoryArray[indexPath.row].catname
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QuestionPageViewControllerID") as! QuestionPageViewController
        secondViewController.categoryname = categoryArray[indexPath.row].catname
        secondViewController.catid = categoryArray[indexPath.row].catid
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    
    
    
    func categoryFunction(){
        
        
        let url = QUIZ.CATEGORY_URL
        AF.request(url, method: .get).responseJSON(completionHandler: { response in
            
            if let response_data = response.value as? NSDictionary{
        
                let resultdata = response_data.value(forKey: "trivia_categories") as! [NSDictionary]
                
                for rdata in resultdata{
                    var catid = ""
                    if let cdata = rdata.value(forKey: "id") as? String{
                        catid = cdata
                    }
                    if let cdata = rdata.value(forKey: "id") as? Int{
                        catid = String(cdata)
                    }
                    if let cdata = rdata.value(forKey: "id") as? NSInteger{
                        catid = String(cdata)
                    }
                    
                    let cname = rdata.value(forKey: "name") as! String
                    
                    self.categoryArray.append(categoryData(catid: catid, catname: cname))
                    
                }
                
            }
            self.homeTable.reloadData()
        })
    }
    
}



