//
//  HomeViewController.swift
//  Thoughts_BlogApp
//
//  Created by Eslam Ali  on 23/03/2022.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    //MARK:- Outlets
    
    @IBOutlet weak var tableView: UITableView!
    var homeViewModel = HomeViewModel()
    var bag = DisposeBag()

    
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
       
        tableView.tableFooterView = UIView()
        view.addSubview(createPostButton)
        title =  "Home"
       
        
        homeViewModel.fetchAllPosts()
        bindTableView()
        
        
        createPostButton.addTarget(self, action: #selector(didTapCreatePostButton), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createPostButton.frame = CGRect(x: view.frame.width - 90, y: view.frame.height - 90 - view.safeAreaInsets.bottom, width: 70  , height: 70)
    }
    
   
    //MARK:- Configure New Post Button
    @objc func didTapCreatePostButton () {
        let newPostVC =  storyboard?.instantiateViewController(identifier: "NewPostViewController") as! NewPostViewController
        navigationController?.pushViewController(newPostVC, animated: true)
    }
    
    func bindTableView()  {
        homeViewModel.posts.bind(to: tableView.rx.items(cellIdentifier: "HomeTableViewCell",cellType: HomeTableViewCell.self))
        { row , postItem , cell in
          
            cell.configureCell(post: postItem)
//            cell.textLabel?.text = postItem.postUserName
//            cell.detailTextLabel?.text = postItem.text
//
        }.disposed(by: bag)

        
        
        
    }

}
