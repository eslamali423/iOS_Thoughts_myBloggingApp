//
//  HomeViewController.swift
//  Thoughts_BlogApp
//
//  Created by Eslam Ali  on 23/03/2022.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK:- Outlets
    
    private let createPostButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "orangeApp")
        button.tintColor = .white
        button.setImage(UIImage(systemName: "square.and.pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium)),for: .normal)
        button.layer.cornerRadius = 35
        button.layer.shadowColor = UIColor.label.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 10
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(createPostButton)
        title =  "Home"
        
        
        createPostButton.addTarget(self, action: #selector(didTapCreatePostButton), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createPostButton.frame = CGRect(x: view.frame.width - 90, y: view.frame.height - 90 - view.safeAreaInsets.bottom, width: 70  , height: 70)
    }
    
    @IBAction func logoutButton(_ sender: Any) {
       
 
    }
    
    @objc func didTapCreatePostButton () {
        let newPostVC =  storyboard?.instantiateViewController(identifier: "NewPostViewController") as! NewPostViewController
        navigationController?.pushViewController(newPostVC, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
