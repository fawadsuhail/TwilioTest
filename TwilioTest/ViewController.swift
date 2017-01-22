//
//  ViewController.swift
//  TwilioTest
//
//  Created by fawad on 22/01/2017.
//  Copyright © 2017 fawad. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let url = "https://api.twilio.com/2010-04-01/Accounts/\(K.Twilio.SID)/Messages.json"
    
    // credentials
    let credentialData = "\(K.Twilio.SID):\(K.Twilio.authToken)".utf8
    let base64Credentials = Data(credentialData).base64EncodedString()
    let headers = ["Authorization": "Basic \(base64Credentials)"]
    
    // params
    let params: [String: String] = ["From": "FROM_NUMBER",
                                    "To": "TO_NUMBER",
                                    "Body": "Hello from Twilio"]
    
    Alamofire.request(url, method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: headers)
      .authenticate(user: K.Twilio.SID,
                    password: K.Twilio.authToken).responseJSON { response in
                      
                      switch response.result {
                      case .success:
                        print("success \(response)")
                      case .failure(let error):
                        print(error)
                      }
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

