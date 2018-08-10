# TwilioTest

Since Twilio doesn't provide an official iOS SDK, us engineers have to use the Rest API. This is how to use Twilio with the much loved Alamofire library.

**Store the SID and Auth key in a constants file**

```
struct K {
  struct Twilio {
    static let SID = "TWILIO_SID"
    static let authToken = "TWILIO_AUTH_TOKEN" 
  }
}
```

**Sending an SMS**

```
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
                password: K.Twilio.authToken)
  .responseJSON { response in
    
    switch response.result {
    case .success:
      print("success \(response)")
    case .failure(let error):
      print(error)
    }
}

```

