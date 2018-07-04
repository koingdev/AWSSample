//
//  DiaryVC.swift
//  AWSSample
//
//  Created by KoingDev on 6/20/18.
//  Copyright © 2018 KoingDev. All rights reserved.
//

import UIKit
import AWSAppSync

final class DiaryCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    
    func updateCell(title: String, author: String) {
        self.title.text = title
        self.author.text = author
    }
    
}

final class DiaryVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate var tableViewX: TableViewX!
    fileprivate var onSubscribe: AWSAppSyncSubscriptionWatcher<OnSubscribeSubscription>?
    fileprivate var diaries: [DiariesQuery.Data.Diary?] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    fileprivate var author = CognitoUserPoolManager.sharedInstance.author
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        setUpTableView()
        loadAllDiaries()
        startSubscription()
    }
    
    fileprivate func setUpTableView() {
        tableViewX = TableViewX(tableView: tableView)
            .numberOfRow { _ in
                self.diaries.count
            }.cellForRow { indexPath in
                self.tableView.dequeueReusableCell(of: DiaryCell.self, for: indexPath) { cell in
                    if let diaries = self.diaries[indexPath.row] {
                        cell.updateCell(title: diaries.title ?? "", author: diaries.author ?? "")
                    }
                }
            }.build()
    }
    
    fileprivate func setUpNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addTapped))
    }
    
    @objc fileprivate func addTapped() {
        UIAlertController.alertTextField(title: "Enter your diary") { [weak self] texts in
            guard let `self` = self else { return }
            let title = texts[0]
            self.insertDiary(title: title)
        }
    }
    
    fileprivate func insertDiary(title: String) {
        let uniqueId = UUID().uuidString
        // Offline
        let diary = DiariesQuery.Data.Diary.init(id: uniqueId, title: title, author: author)
        self.diaries.insert(diary, at: 0)
        // Online
        let mutation = InsertDiaryMutation(id: uniqueId, title: title, author: author)
        AppSyncManager.sharedInstance?.perform(mutation: mutation)
    }
    
    fileprivate func loadAllDiaries() {
        AppSyncManager.sharedInstance?.fetch(query: DiariesQuery(author: author), cachePolicy: .fetchIgnoringCacheData) { (res, err) in
            if let diaries = res?.data?.diaries {
                self.diaries = diaries
            } else {
                print("\n---------- [ \(err?.localizedDescription ?? "") ] ----------\n")
            }
        }
    }
    
    fileprivate func startSubscription() {
        let subscription = OnSubscribeSubscription(author: author)
        print("Starting subscription...")
        do {
            onSubscribe = try AppSyncManager.sharedInstance?.subscribe(subscription: subscription) { (result, transaction, error) in
                if let result = result {
                    print("Received new data")
                    // Store a reference to the new object
                    let newDiary = result.data!.onSubscribe!
                    // Create a new object for the desired query where the new object content should reside
                    let diaryToAdd = DiariesQuery.Data.Diary.init(id: newDiary.id, title: newDiary.title, author: newDiary.author)
                    // Update the local store with the newly received data
                    try? transaction?.update(query: DiariesQuery(author: self.author)) { (data: inout DiariesQuery.Data) in
                        data.diaries?.append(diaryToAdd)
                    }
                }
            }
        } catch {
            print("Error starting subscription")
        }
    }

}
