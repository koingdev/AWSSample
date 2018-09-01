//
//  ChoiceVC.swift
//  AWSSample
//
//  Created by KoingDev on 9/1/18.
//  Copyright © 2018 KoingDev. All rights reserved.
//

import UIKit

class ChoiceVC: UIViewController {
    
    @IBAction func loadFromServer(_ sender: Any) {
        selectChoice(shouldFetchfromServer: true)
    }
    
    @IBAction func loadFromCache(_ sender: Any) {
        selectChoice(shouldFetchfromServer: false)
    }
    
    private func selectChoice(shouldFetchfromServer: Bool) {
        let vc = DiaryVC.instance
        vc.shouldFetchFromServer = shouldFetchfromServer
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
