//
//  NetworkListener.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 2018/08/03.
//  Copyright © 2018 KoingDev. All rights reserved.
//
import Foundation
import Reachability
import SystemConfiguration

public protocol NetworkStatusListener: AnyObject {
    
    /// Function to handle on network status changed
    ///
    /// - Parameter status: Network status
    func networkStatusDidChange(status: Reachability.Connection)
    
}

public final class NetworkListener {
    
    public static let sharedInstance = NetworkListener()
    private weak var listener: NetworkStatusListener?
    private let reachability = Reachability()
    
    /// Triggered whenever a network status changed
    ///
    /// - Parameter notification: Reachability instance
    @objc private func networkStatusChanged(notification: Notification) {
        guard let reachability = notification.object as? Reachability else { return }
        listener?.networkStatusDidChange(status: reachability.connection)
    }
    
    /// Start monitoring the network status
    ///
    /// - Parameter listener: Instance of class which conform to NetworkStatusListener
    public func startMonitoring(listener: NetworkStatusListener) {
        self.listener = listener
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(networkStatusChanged),
                                               name: Notification.Name.reachabilityChanged,
                                               object: reachability)
        do {
            try reachability?.startNotifier()
        } catch {
            debugPrint("Could not start reachability notifier")
        }
    }
    
    /// Stop monitoring the network status and remove observer
    public func stopMonitoring() {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name.reachabilityChanged,
                                                  object: reachability)
    }
    
}

extension Reachability {
    
    static func isOnline() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
    
}
