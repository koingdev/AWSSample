//
//  DiaryVC.swift
//  AWSSample
//
//  Created by KoingDev on 6/20/18.
//  Copyright © 2018 KoingDev. All rights reserved.
//

import UIKit
import Apollo
import RealmSwift

class DiaryModel: Object {
    
    @objc dynamic var id: String!
    @objc dynamic var title: String!
    @objc dynamic var author: String!
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: String, title: String, author: String) {
        self.init()
        self.id = id
        self.title = title
        self.author = author
    }

    convenience init(diary: DiariesQuery.Data.Diary) {
        self.init()
        id = diary.id
        title = diary.title ?? ""
        author = diary.author ?? ""
    }
    
}

final class DiaryCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    
    func updateCell(diary: DiaryModel) {
        title.text = diary.title
        author.text = diary.author
    }
    
}

final class DiaryVC: UIViewController {

    static var instance: DiaryVC {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let diaryVC = sb.instantiateViewController(withIdentifier: "DiaryVC") as! DiaryVC
        return diaryVC
    }
    var shouldFetchFromServer = true
    @IBOutlet weak var tableView: UITableView!
    private var diaries = [DiaryModel]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
//    fileprivate var onSubscribe: AWSAppSyncSubscriptionWatcher<OnSubscribeSubscription>?
    private var author = CognitoUserPool.instance.author
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        tableView.dataSource = self
        setUpNavBar()
        if shouldFetchFromServer {
            loadAllDiaries()
        } else {
//            loadAllDiaries()
        }
    }
    
    fileprivate func setUpNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addTapped))
    }

    @objc fileprivate func addTapped() {
        UIAlertController.alertTextField(title: "Enter your diary") { [unowned self] texts in
            let title = texts[0]
            self.insertDiary(title: title)
        }
    }
    
    fileprivate func insertDiary(title: String) {
        let uniqueId = UUID().uuidString
        let diary = DiaryModel(id: uniqueId, title: title, author: author)
        diaries.append(diary)
        let mutation = InsertDiaryMutation(id: uniqueId, title: title, author: author)
        Apollo.instance.perform(mutation: mutation, realmCaching: diary) {
            print("INSERT SUCCEED...!")
        }
    }
    
    // TODO: Cache Policy
    fileprivate func loadAllDiaries() {
        Apollo.instance.fetch(query: DiariesQuery(author: author)) { result in
            if let diaries = result.diaries?.compactMap({$0}) {
                self.diaries = diaries.map(DiaryModel.init)
            }
        }
    }
//
//    fileprivate func startSubscription() {
//        let subscription = OnSubscribeSubscription(author: author)
//        print("Starting subscription...")
//        do {
//            onSubscribe = try AppSyncManager.instance().subscribe(subscription: subscription) { (result, transaction, error) in
//                if let result = result {
//                    print("Received new data")
//                    // Store a reference to the new object
//                    let newDiary = result.data!.onSubscribe!
//                    // Create a new object for the desired query where the new object content should reside
//                    let diaryToAdd = DiariesQuery.Data.AllDiary.init(id: newDiary.id, title: newDiary.title, author: newDiary.author)
//                    // Update the local store with the newly received data
//                    try? transaction?.update(query: DiariesQuery()) { (data: inout DiariesQuery.Data) in
//                        data.allDiaries?.append(diaryToAdd)
//                    }
//                }
//            }
//        } catch {
//            print("Error starting subscription")
//        }
//    }

}

extension DiaryVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(of: DiaryCell.self, for: indexPath) { cell in
            cell.updateCell(diary: diaries[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaries.count
    }
    
}
