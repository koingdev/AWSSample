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
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    fileprivate var allDiaries: [AllDiariesQuery.Data.AllDiary?] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    fileprivate var author = CognitoUserPoolManager.sharedInstance.author
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        setUpTableView()
//        loadAllDiaries(cachePolicy: .returnCacheDataElseFetch)
        // from cache
//        loadAllDiaries(cachePolicy: .returnCacheDataDontFetch)
        // from server
        loadAllDiaries(cachePolicy: .fetchIgnoringCacheData)
//        startSubscription()
    }
    
    fileprivate func setUpTableView() {
        tableViewX = TableViewX(tableView: tableView)
            .numberOfRow { _ in
                self.diaries.count
//                self.allDiaries.count
            }.cellForRow { indexPath in
                self.tableView.dequeueReusableCell(of: DiaryCell.self, for: indexPath) { cell in
                    if let diary = self.diaries[indexPath.row] {
//                    if let diaries = self.allDiaries[indexPath.row] {
                        cell.updateCell(title: diary.title ?? "", author: diary.author ?? "")
                    }
                }
            }.didSelectRow { indexPath in
                let index = indexPath.row
                self.updateDiary(id: self.diaries[index]?.id ?? "", index: index)
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
    
    fileprivate func updateDiary(id: GraphQLID, index: Int) {
        UIAlertController.alertTextField(title: "Update your diary") { texts in
            let title = texts[0]
            self.diaries[index]?.title = title
            let mutation = UpdateDiaryMutation(id: id, title: title)
            AppSyncManager.sharedInstance?.perform(mutation: mutation)
        }
    }
    
    fileprivate func insertDiary(title: String) {
        let uniqueId = UUID().uuidString
        // Offline
        let diary = DiariesQuery.Data.Diary.init(id: uniqueId, title: title, author: author)
        diaries.insert(diary, at: 0)
//        let diary = AllDiariesQuery.Data.AllDiary.init(id: uniqueId, title: title, author: author)
//        allDiaries.insert(diary, at: 0)
        // Online
        let mutation = InsertDiaryMutation(id: uniqueId, title: title, author: author)
        AppSyncManager.sharedInstance?.perform(mutation: mutation, optimisticUpdate: { transaction in
            do {
                try transaction?.update(query: DiariesQuery(author: self.author)) { (data: inout DiariesQuery.Data) in
                    data.diaries?.append(diary)
                }
//                try transaction?.update(query: AllDiariesQuery()) { (data: inout AllDiariesQuery.Data) in
//                    data.allDiaries?.append(diary)
//                }
            } catch {
                print("\n-------- [ Error updating the cache with optimistic response ] --------\n")
            }
        })
    }
    
    fileprivate func loadAllDiaries(cachePolicy: CachePolicy) {
        AppSyncManager.sharedInstance?.fetch(query: DiariesQuery(author: author), cachePolicy: cachePolicy) { (res, err) in
            if let diaries = res?.data?.diaries {
                self.diaries = diaries
            } else {
                print("\n---------- [ \(err?.localizedDescription ?? "") ] ----------\n")
            }
        }
//        AppSyncManager.sharedInstance?.fetch(query: AllDiariesQuery(), cachePolicy: cachePolicy) { (res, err) in
//            if let diaries = (res?.data?.allDiaries?.filter { $0?.author == self.author }) {
//                self.allDiaries = diaries
//            } else {
//                print("\n---------- [ \(err?.localizedDescription ?? "") ] ----------\n")
//            }
//        }
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
                        self.diaries.append(diaryToAdd)
                    }
                }
            }
        } catch {
            print("Error starting subscription")
        }
    }

}
