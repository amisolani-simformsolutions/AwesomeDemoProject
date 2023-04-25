//
//  ViewController.swift
//  CardSwipeDemo
//
//  Created by Ami Solani on 29/03/23.
//

import UIKit
import BoltMobileSDK

class ViewController: UIViewController {
    
    var swiper: BMSSwiperController?
    
    @IBOutlet weak var lblOutput: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        swiper = BMSSwiperController(delegate: self, loggingEnabled: true)
        swiper?.findDevices()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        swiper?.releaseDevice()
        swiper = nil
    }

}

extension ViewController: BMSSwiperControllerDelegate {
    
    func swiper(_ swiper: BMSSwiperController!, foundDevices devices: [Any]!) {
        debugPrint("Found hurryyyyy")
        guard let d = devices.first as? BMSDevice else { return }
        debugPrint("\(swiper.connectionState)")
        swiper.connect(toDevice: d.uuid, mode: .swipeTap)
    }
    
    
    func swiper(_ swiper: BMSSwiperController!, displayMessage message: String!, canCancel cancelable: Bool) {
        debugPrint(message)
    }
    func swiper(_ swiper: BMSSwiper, batteryLevelStatusHasChanged status: BMSSwiperBatteryStatus) {
        debugPrint("batteryLevelStatusHasChanged" + "\(status.rawValue)")
    }
    func swiper(_ swiper: BMSSwiper, didFailWithError error: Error, completion: @escaping () -> Void) {
        debugPrint(error)
        lblOutput.text = "\(error)"
        debugPrint("\(swiper.connectionState)")
    }
    
    func swiper(_ swiper: BMSSwiper, connectionStateHasChanged state: BMSSwiperConnectionState) {
        switch state {
        case .connected:
            lblOutput.text = "connect"
            print("Did connect swiper")
        case .disconnected:
            lblOutput.text = "disconnect"
            print("Did disconnect swiper")
        case.connecting:
            print("Swiper is connecting")
        default:
            break
        }
    }
    
}

extension ViewController: BMSSwiperDelegate {
    
    func swiper(_ swiper: BMSSwiper, didGenerateTokenWith account: BMSAccount?, completion: @escaping () -> Void) {
        debugPrint("generate token")
        debugPrint("\(account?.last4)")
        debugPrint("\(account?.expirationDate)")
        debugPrint("\(account?.name)")
        debugPrint("\(account?.accountID)")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func swiperDidStartCardRead(_ swiper: BMSSwiper) {
        debugPrint("start card read")
        //debugPrint("\(swiper)")
    }
    
    
    
    
    func swiperDidStartCardRead(_ swiper: BMSSwiper) {
        debugPrint("start card read")
        //debugPrint("\(swiper)")
    }
}
