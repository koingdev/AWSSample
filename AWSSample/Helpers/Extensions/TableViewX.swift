
//  TableViewX.swift
//  KoingX
//
//  Created by KoingDev on 4/5/18.
//  Copyright © 2018 KoingDev. All rights reserved.
//

import UIKit

public extension UITableViewCell {
    
    public static var identifier: String {
        return String(describing: self)
    }
    
}

public extension UITableView {
    
    public func dequeueReusableCell<CellClass: UITableViewCell> (
        of class: CellClass.Type,
        for indexPath: IndexPath,
        configure: (CellClass) -> Void) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: CellClass.identifier, for: indexPath)
        if let typedCell = cell as? CellClass {
            configure(typedCell)
            return typedCell
        }
        return cell
    }
    
}

public class TableViewX: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    public typealias NumberOfRow = ((_ section: Int) -> Int)?
    public typealias CellForRow = ((_ indexPath: IndexPath) -> UITableViewCell)?
    public typealias DidSelectRow = ((_ indexPath: IndexPath) -> Void)?
    
    fileprivate var numberOfRow: NumberOfRow
    fileprivate var cellForRow: CellForRow
    fileprivate var didSelectRow: DidSelectRow
    fileprivate var tableView: UITableView
    
    public init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    @discardableResult
    public func numberOfRow(handler: NumberOfRow) -> Self {
        numberOfRow = handler
        return self
    }
    
    @discardableResult
    public func cellForRow(handler: CellForRow) -> Self {
        cellForRow = handler
        return self
    }
    
    @discardableResult
    public func didSelectRow(handler: DidSelectRow) -> Self {
        didSelectRow = handler
        return self
    }
    
    @discardableResult
    public func build() -> Self {
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.delegate = self
        tableView.dataSource = self
        return self
    }
    
    // MARK: - Override Delegate & Datasource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRow?(section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForRow?(indexPath) ??  UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let didSelectRow = didSelectRow else { return }
        return didSelectRow(indexPath)
    }
    
    deinit {
        print("\(TableViewX.self) is gone! :D")
    }
    
}
