//
//  HomeVC.swift
//  testJobOne
//
//  Created by Tauã on 19/03/20.
//  Copyright © 2020 Tauã. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var arrayList = [ListModel.Item]()
    private var arrayListFilter = [ListModel.Item]()
    private let disposeBag = DisposeBag()
    private var picker = UIPickerView()
    private var searchBar: UISearchBar? = nil
    private var resultSearchController = UISearchController()
    private var pickerData: [String] =  ["name", "number", "stars"]
    private var sort = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Github"
        
        configTable()
        configSearch()
        setupList()
    }
    
    private func configSearch() {
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
            
        })()
    }
    
    @IBAction func actionSort(_ sender: Any) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 130)
        picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
        picker.delegate = self
        picker.dataSource = self
        vc.view.addSubview(picker)
        
        let editRadiusAlert = UIAlertController(title: "Choose distance", message: "", preferredStyle: UIAlertController.Style.alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Done", style: .default, handler: { action in
            self.actionSort()
        }))
        
        editRadiusAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(editRadiusAlert, animated: true)
    }
    
    private func configTable() {
        tableView.register(UINib(nibName: ListCell.nameCell, bundle: nil), forCellReuseIdentifier: ListCell.idCell)
        tableView.rowHeight = 174.0
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupList() {
        NetWork.getList().subscribe(
            onNext: { [weak self] response in
                guard response.count > 0 else {
                    return
                }
                self?.arrayList = response
                self?.arrayListFilter = response
                self?.tableView.reloadData()
            },
            onError: { [weak self] error in
                print(self?.arrayList ?? error)
        }).disposed(by: disposeBag)
    }
    
    func sortFunc(num1: Int, num2: Int) -> Bool {
        return num1 < num2
    }
    
    private func actionSort() {
        switch (sort){
        case "name":
            arrayListFilter = arrayList.sorted { $0.name!.lowercased() < $1.name!.lowercased() }
        case "starts":
            arrayListFilter = arrayList.sorted(by: { $0.stargazers_count! < $1.stargazers_count! })
        case "number":
            arrayListFilter = arrayList.sorted { $0.open_issues! < $1.open_issues! }
        default:
            arrayListFilter = arrayList.sorted { $0.name!.lowercased() < $1.name!.lowercased() }
        }
        tableView.reloadData()
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayListFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.idCell, for: indexPath) as! ListCell
        
        cell.setup(data: self.arrayListFilter[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell number \(indexPath.row).")
    }
}


extension HomeVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        arrayListFilter.removeAll()
        
        let searchText = searchController.searchBar.text ?? ""
        
        if (searchText.isEmpty) {
            arrayListFilter = arrayList
            self.tableView.reloadData()
            return
        }
        
        let array = arrayList.filter { $0.name!.contains(searchText) }
        arrayListFilter = array
        self.tableView.reloadData()
    }
}

extension HomeVC: UIPickerViewDataSource,
UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component:
        Int) -> String? {
        self.sort = pickerData[row]
        return pickerData[row]
    }
    
}
