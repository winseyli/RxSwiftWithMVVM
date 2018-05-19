//
//  TableViewExampleViewController.swift
//  RxSwiftWithMVVM
//
//  Created by Winsey Li on 19/5/2018.
//  Copyright © 2018 winseyli.nz. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TableViewExampleViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: UIButton!
    
    private var viewModel: TableViewExampleViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configurateView()
        configurateViewModel()
        configureBindings()
    }
    
    private func configurateView() {
        // Register cell
        tableView.register(UINib.init(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
    }
    
    private func configurateViewModel() {
        viewModel = TableViewExampleViewModel(dataService: DataService())
    }
    
    private func configureBindings() {
        viewModel.isLoading
            .drive(onNext: { loading in
                self.button.setTitle(loading ? "Loading..." : "Refresh", for: .normal) 
            })
            .disposed(by: disposeBag)
        
        viewModel.stringData
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "PostTableViewCell", cellType: PostTableViewCell.self)) { row, element, cell in
                cell.post = element
            }
            .disposed(by: disposeBag)
        
        viewModel.isError
            .drive(onNext: { isError in
                if isError {
                    self.showAlert(title: "Error", message: "Fail to fetch data")
                }
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                if let cell = self.tableView.cellForRow(at: indexPath) as? PostTableViewCell {
                    self.showAlert(title: cell.post.title, message: cell.post.body)
                }
                self.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
    }

}
