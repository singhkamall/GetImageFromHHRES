import UIKit
class SharedClass: NSObject {
    
    static let sharedInstance = SharedClass()
    
    func postRequestFunction(apiName: String , parameters: String, onCompletion: @escaping (_ success: Bool, _ error: Error?, _ result: [String: Any]?)->()) {
        
        var URL =  "http://hhres1.dev.smartlayer.ca/***?"
        
        URL = URL.replacingOccurrences(of: "***?", with: apiName)
        
        var request = URLRequest(url: URL(string: URL)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        print("shared URL : \(request)")
        request.httpBody = parameters.data(using: .utf8)
        
        var returnRes:[String:Any] = [:]
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                onCompletion(false, error, nil)
            } else {
                guard let data = data else {
                    onCompletion(false, error, nil)
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 {
                    do {
                        returnRes = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                        onCompletion(true, nil, returnRes)
                        
                    } catch let error as NSError {
                        onCompletion(false, error, nil)
                    }
                } else {
                    onCompletion(false, error, nil)
                }
            }
        }
        task.resume()
    }
    
    
    private override init() {
        
    }
}
