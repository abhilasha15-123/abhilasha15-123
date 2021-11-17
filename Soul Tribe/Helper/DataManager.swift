import Foundation
import UIKit
import SystemConfiguration


extension NSDictionary{
    
    private func httpStringRepresentation(value: Any) -> String {
        switch value {
        case let boolean as Bool:
            return boolean ? "true" : "false"
        default:
            return "\(value)"
        }
    }
    
    func dataFromHttpParameters() -> NSData? {
        
        var parameterArray = [String]()
        for (key, value) in self {
            let string = httpStringRepresentation(value: value)
            
            if let escapedString = string.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) {
                parameterArray.append("\(key)=\(escapedString)")
            }
        }
        
        let parameterString = parameterArray.joined(separator: "&")
        //print(parameterString)
        
        return parameterString.data(using: String.Encoding.utf8) as NSData?
    }
}



class DataManager {
  
    class func isConnectedToNetwork()->Bool{
        
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
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        return ret
        
    }
    
    class func getVal(_ param:Any!) -> AnyObject {
        
        if param == nil{
            return "" as AnyObject
        }else if param is NSNull{
            return "" as AnyObject
        }else if param is NSNumber{
            let aString:String = "\(param!)"
            return aString as AnyObject
        }else if param is Double{
            return "\(String(describing: param))" as AnyObject
        }else{
            return param as AnyObject
        }
    }
    
    class func getVal(_ param:AnyObject!,typeObj:AnyObject) -> AnyObject {
        
        if param == nil{
            return typeObj
        }else if param is NSNull{
            return typeObj
        }else if param is NSNumber{
            return typeObj
        }else if param is Double{
            return typeObj
        }else{
            return typeObj
        }
        
    }
   
    class func getValForIndex(_ arrayValues:AnyObject!,index:Int) -> AnyObject {
        
        ////print("getVal = \(arrayValues)")
        
        
        let arrayVal: AnyObject! = getVal(arrayValues)
        
        if arrayVal is NSArray || arrayVal is NSMutableArray
        {
            let arr = arrayValues as! NSArray
            if index < arr.count {
                return arr.object(at: index) as AnyObject
            }else{
                return "" as AnyObject
            }
        }
        else
        {
            return "" as AnyObject
        }
    }
    
    
    class func JSONStringify(_ value: AnyObject, prettyPrinted: Bool = false) -> String {
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : []
        if JSONSerialization.isValidJSONObject(value) {
            if let data = try? JSONSerialization.data(withJSONObject: value, options: options) {
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            }
        }
        return ""
    }
    
    class func getAPIResponseFileSingleImage(_ parameterDictionary :NSMutableDictionary,methodName:NSString, dataArray:NSArray, success: @escaping ((_ iTunesData: NSDictionary?,_ error:NSError?) -> Void)) {
        
//
//        let UUIDValue = UIDevice.current.identifierForVendor!.uuidString
//        print ("UUID: \(UUIDValue)")
        
        
        let apiPath = "\(Config().API_URL)\(methodName)"
        
        print(parameterDictionary)
        print (apiPath)
        
        let request = NSMutableURLRequest(url:NSURL(string: apiPath)! as URL);
        request.httpMethod = "POST"
        
        let boundary = self.generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue(DataManager.getVal(Config().AppUserDefaults.value(forKey:"language")) as? String ?? "en", forHTTPHeaderField: "X-localization")
        
        var imageData = Data()
        var imageName  = ""
        
        for dataDict in dataArray {
            let dataDictionary = dataDict as! NSDictionary
            
            imageName = dataDictionary.object(forKey: "image") as! String
            imageData = dataDictionary.object(forKey: "imageData") as! Data
        }
        
        var param : [String:String] = [:]
        
        for (key,val) in parameterDictionary {
            param[key as! String] = val as? String
        }
        
        request.httpBody = createBodyWithParametersSingleImage(parameters: param, filePathKey: imageName, imageDataKey: imageData as NSData, boundary: boundary) as Data
        
        loadDataFromURL(request, completion:{(data, error) -> Void in
            if let urlData = data {
                success(urlData,error)
            }
            else
            {
                print(error!)
            }
        })
        
    }
    class func createBodyWithParametersSingleImage(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.append(("--\(boundary)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
                body.append(("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
                body.append(("\(value)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
            }
        }
    
        let filename = "user-profile.jpg"
        
        let mimetype = "image/jpg"
        
        body.append(("--\(boundary)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(("Content-Type: \(mimetype)\r\n\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(imageDataKey as Data)
        body.append(("\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        
        body.append(("--\(boundary)--\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        
        return body
    }

    class func getAPIResponse(_ parameterDictionary :NSMutableDictionary,methodName:String,methodType:String, success: @escaping ((_ iTunesData: NSDictionary?,_ error:NSError?) -> Void)) {
               
        var request: NSMutableURLRequest!
        
        let apiPath = "\(Config().API_URL)\(methodName)"
        print(apiPath)
        
        request = NSMutableURLRequest(url: NSURL(string: apiPath)! as URL)
    
        request.setValue(DataManager.getVal(Config().AppUserDefaults.value(forKey:"language")) as? String ?? "en", forHTTPHeaderField: "X-localization")
        
        request.httpMethod = methodType
        if methodType == "POST" {
            request.httpBody = parameterDictionary.dataFromHttpParameters() as Data?
        }
        loadDataFromURL(request, completion:{(data, error) -> Void in
            if let urlData = data {
                success(urlData,error)
            }
        })
    }
    class func getNotificationCountAPIResponse(_ parameterDictionary :NSMutableDictionary,methodName:String,methodType:String, success: @escaping ((_ iTunesData: NSDictionary?,_ error:NSError?) -> Void)) {
        
        var request: NSMutableURLRequest!
        
        let apiPath = "\(Config().API_URL)\(methodName)"
        //print(apiPath)
        
        request = NSMutableURLRequest(url: NSURL(string: apiPath)! as URL)
        
        request.httpMethod = methodType
        if methodType == "POST" {
            request.httpBody = parameterDictionary.dataFromHttpParameters() as Data?
        }
        notificationCountloadDataFromURL(request, completion:{(data, error) -> Void in
           
            if let urlData = data {
                success(urlData,error)
            }
        })
    }
    
    class func getAPIResponse(_ parameterDictionary :NSMutableDictionary,methodType: String,methodName:String, success: @escaping ((_ iTunesData: NSDictionary?,_ error:NSError?) -> Void)) {
    
        let UUIDValue = UIDevice.current.identifierForVendor!.uuidString
        print ("UUID: \(UUIDValue)")
        
        print (parameterDictionary)

        var request: NSMutableURLRequest!
        
        let apiPath = "\(Config().API_URL)\(methodName)"
        print(apiPath)
        
        request = NSMutableURLRequest(url: NSURL(string: apiPath)! as URL)
        request.setValue(DataManager.getVal(Config().AppUserDefaults.value(forKey:"language")) as? String ?? "en", forHTTPHeaderField: "X-localization")
        
        
       
        request.httpMethod = methodType
    
       // request.httpMethod = "POST"
        request.httpBody = parameterDictionary.dataFromHttpParameters() as Data?
        
        loadDataFromURL(request!, completion:{(data, error) -> Void in
           
            if let urlData = data {
                success(urlData,error)
            }
        })
    }
    class func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.append(("--\(boundary)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
                body.append(("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
                body.append(("\(value)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
            }
        }
        
        let filename = "user-profile.jpg"
        
        let mimetype = "image/jpg"
        
        body.append(("--\(boundary)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(("Content-Type: \(mimetype)\r\n\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(imageDataKey as Data)
        body.append(("\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        
        body.append(("--\(boundary)--\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        
        return body
    }
    
    class func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    class func getAPIResponseFile(_ parameterDictionary :NSMutableDictionary,methodName:NSString, dataArray:NSArray, success: @escaping ((_ iTunesData: NSDictionary?,_ error:NSError?) -> Void)) {
        
        let UUIDValue = UIDevice.current.identifierForVendor!.uuidString
        print ("UUID: \(UUIDValue)")
        
        let apiPath = "\(Config().API_URL)\(methodName)"
        
        let request = NSMutableURLRequest(url:NSURL(string: apiPath)! as URL);
        request.httpMethod = "POST"
        
        let boundary = self.generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        var param : [String:String] = [:]
        
        for (key,val) in parameterDictionary {
            param[key as! String] = val as? String
        }
        
        
        request.httpBody = createBodyWithParameters(parameters: param, imageArray: dataArray, boundary: boundary) as Data
        
        loadDataFromURL(request, completion:{(data, error) -> Void in
            //2
            if let urlData = data {
                success(urlData,error)
            }
            else
            {
                print(error!)
            }
        })
        
    }
    class func createBodyWithParameters(parameters: [String: String]?, imageArray: NSArray, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.append(("--\(boundary)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
                body.append(("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
                body.append(("\(value)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
            }
        }
        
//        var imageData = Data()
//        var imageName  = ""
        // print(imageArray)
        for index in 0..<imageArray.count {
            
            let dataDictionary = imageArray[index] as! NSDictionary
            
//            imageName = dataDictionary.object(forKey: "image") as! String
//            imageData = dataDictionary.object(forKey: "imageData") as! Data
            
            let mimetype = "application/octet-stream"
            
            let imageName = dataDictionary.object(forKey: "image") as! NSString
            let imageExt = dataDictionary.object(forKey: "ext") as! NSString
            let imageData = dataDictionary.object(forKey: "imageData") as! Data
            //  let imageType = dataDictionary.object(forKey: "imagetype") as! NSString
            
            let randmstr = self.randomStringWithLength(8)
            
            body.append(("--\(boundary)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
            body.append(("Content-Disposition: form-data; name=\"\(imageName)[\(index)]\"; filename=\"\(randmstr).\(imageExt)\"\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
            body.append(("Content-Type: \(mimetype)\r\n\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
            body.append(imageData as Data)
            body.append(("\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
            body.append(("--\(boundary)--\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
            
        }
        return body
    }
    
    class func randomStringWithLength (_ len : Int) -> NSString {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for _ in 0 ..< len{
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        
        return randomString
    }
    class func getOtherAPI(_ str:NSString,success:( (_ itunesdata:Data,_ error:NSError ) -> Void )){
        //println(str)
        
    }
    
//    class func getSubmitAPIResponse(_ parameterDictionary :NSDictionary,MethodName: String, success: @escaping ((_ iTunesData: NSDictionary?,_ error:NSError?) -> Void)) {
//        let MethodURL = Config().API_URL+MethodName
//        print(MethodURL)
//        let deviceToken = DataManager.getVal(Config().AppUserDefaults.object(forKey: "deviceToken")) as! String
//        _  =  ["data":parameterDictionary,"device_type":"iPhone","deviceId":deviceToken ,"device_token":deviceToken] as [String : Any];
//        
//        var request: NSMutableURLRequest!
//        request = NSMutableURLRequest(url: URL(string: MethodURL)!)
//        request.httpBody = parameterDictionary.dataFromHttpParameters() as Data?
//        request.httpMethod = "POST"
//        
//        loadDataFromURL(request, completion:{(data, error) -> Void in
//            print(request)
//            print(data!)
//            if let urlData = data {
//                success(urlData,error)
//            }
//        })
//    }
    
    class func loadDataFromURL(_ request: NSMutableURLRequest, completion:@escaping (_ data: NSDictionary?, _ error: NSError?) -> Void) {
        // Use NSURLSession to get data from an NSURL
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main)
        {(response, data, error) in
            //print(error)
            if let responseError = error {
                print(responseError as NSObject)
                var jsonResult  = NSDictionary()
                jsonResult = ["status":"error","message":responseError.localizedDescription]
                //  jsonResult = ["status":"error","message":"Make sure your device is connected to the internet."]
                completion(jsonResult, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode as NSObject)
                if httpResponse.statusCode != 200 {
                    let base64String = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print(base64String!)
                    var jsonResult  = NSDictionary()
                    jsonResult = ["status":"error","message":base64String!]
                    //  jsonResult = ["status":"error","message":"There is a problem with server, kindly try again."]
                    completion(jsonResult, nil)
                } else {
                    let base64String = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print(base64String!)
                    
                    var jsonResult  = NSDictionary()
                    
                    let decodedString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    if((try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) != nil){
                        
                        jsonResult  = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as? NSDictionary ?? [:]
                    } else {
                        print(decodedString!)
                        jsonResult = ["status":"error","message":decodedString!]
                        //  jsonResult = ["status":"error","message":"There is a problem with server, kindly try again."]
                    }
                    
                    print(jsonResult)
                    completion(jsonResult, nil)
                }
            }
        }
        //loadDataTask.resume()
    }
    class func notificationCountloadDataFromURL(_ request: NSMutableURLRequest, completion:@escaping (_ data: NSDictionary?, _ error: NSError?) -> Void) {
        // Use NSURLSession to get data from an NSURL
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main)
        {(response, data, error) in
            //print(error)
            if let responseError = error {
                //Config().printData(responseError as NSObject)
                var jsonResult  = NSDictionary()
                jsonResult = ["status":"error","message":responseError.localizedDescription]
                  jsonResult = ["status":"error","message":"Make sure your device is connected to the internet."]
                completion(jsonResult, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                //Config().printData(httpResponse.statusCode as NSObject)
                if httpResponse.statusCode != 200 {
                    let base64String = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    //Config().printData(base64String!)
                    var jsonResult  = NSDictionary()
                    jsonResult = ["status":"error","message":base64String!]
                      jsonResult = ["status":"error","message":"There is a problem with server, kindly try again."]
                    completion(jsonResult, nil)
                } else {
//                    _ = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//                    //Config().printData(base64String!)
                    
                    var jsonResult  = NSDictionary()
                    
                    let decodedString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    if((try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) != nil){
                        
                        jsonResult  = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                    } else {
                        //Config().printData(decodedString!)
                        jsonResult = ["status":"error","message":decodedString!]
                          jsonResult = ["status":"error","message":"There is a problem with server, kindly try again."]
                    }
                    
                    //Config().printData(jsonResult)
                    completion(jsonResult, nil)
                }
            }
        }
        //loadDataTask.resume()
    }
    
    
    
    class func getAPIResponseFileMultipleImageArray( parameterDictionary :NSDictionary,methodName:String, DocimageArray:NSArray, success: @escaping (( _ iTunesData: NSDictionary?, _ error:NSError?) -> Void)) {

    let apiPath = "\(Config().API_URL)\(methodName)"

    let request = NSMutableURLRequest(url:NSURL(string: apiPath)! as URL);
    request.httpMethod = "POST"

    let boundary = self.generateBoundaryString()

    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    request.setValue(DataManager.getVal(Config().AppUserDefaults.value(forKey:"language")) as? String ?? "en", forHTTPHeaderField: "X-localization")
        
    var param : [String:String] = [:]

    let sessionConfig = URLSessionConfiguration.default
    sessionConfig.timeoutIntervalForRequest = 30.0
    sessionConfig.timeoutIntervalForResource = 30.0

    for (key,val) in parameterDictionary {
    param[key as! String] = val as? String
    }

    request.httpBody = MultipleImageArraycreateBodyWithParameters(parameters: param, DocumentimageArray: DocimageArray, filePathKey: "image", boundary: boundary) as Data

    loadDataFromURL(request, completion:{(data, error) -> Void in
    //2
    if let urlData = data {

    success(urlData,error)
    }
    else
    {
    //SwAlert.showNoActionAlert(SwAlert().AppAlertTitle, message:error?.domain ?? "Server not responding" , buttonTitle: "OK")
    }
    })
    }
    
    class func MultipleImageArraycreateBodyWithParameters(parameters: [String: String]?, DocumentimageArray: NSArray, filePathKey: String?, boundary: String) -> NSData {
    let body = NSMutableData();
        
    if parameters != nil {
    for (key, value) in parameters! {
    body.append(("--\(boundary)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
    body.append(("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
    body.append(("\(value)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
    }
    }

//
//    var imageData = Data()
//    var imageName = ""

    let filename2 = "image.png"

    let mimetype = "image/png"

    body.append(("--\(boundary)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
    body.append(("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename2)\"\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
    body.append(("Content-Type: \(mimetype)\r\n\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
    body.append(("\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)


    for index in 0..<DocumentimageArray.count {

    let dataDictionary = DocumentimageArray[index] as! NSDictionary

//    imageName = dataDictionary.object(forKey: "keyName") as! String
//    imageData = dataDictionary.object(forKey: "MyData") as! Data

    let mimetype = "application/octet-stream"

    let imageName = dataDictionary.object(forKey: "keyName") as! NSString
    let imageExt = dataDictionary.object(forKey: "ext") as! NSString
    let imageData = dataDictionary.object(forKey: "MyData") as! Data

    let randmstr = self.randomStringWithLength(8)

    body.append(("--\(boundary)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(("Content-Disposition: form-data; name=\"\(imageName)[\(index)]\"; filename=\"\(randmstr).\(imageExt)\"\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
    body.append(("Content-Type: \(mimetype)\r\n\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
    body.append(imageData as Data)
    body.append(("\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
    body.append(("--\(boundary)--\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)

        print (parameters as Any)
    }
    return body
    }
    
    class func UploadTwoDocumentsFileAndSingleImage(_ parameterDictionary :NSMutableDictionary,methodName:String, DocumentArray1:NSArray,DocumentArray2:NSArray,ImgArray:NSArray, success: @escaping ((_ iTunesData: NSDictionary?,_ error:NSError?) -> Void)) {
        
        
        let apiPath = "\(Config().API_URL)\(methodName)"
        print(apiPath)
        let request = NSMutableURLRequest(url:NSURL(string: apiPath)! as URL);
        request.httpMethod = "POST"
        
        let boundary = self.generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue(DataManager.getVal(Config().AppUserDefaults.value(forKey:"language")) as? String ?? "en", forHTTPHeaderField: "X-localization")
        
        
        var documentData1 = Data()
        var documentName1  = ""
        var documenttype1 = String()
        
        var documentData2 = Data()
        var documentName2  = ""
        var documenttype2 = String()

        var imageData = Data()
        var imageName  = ""
        var mimetype = String()
        
        if DocumentArray1.count > 0 {
            for dataDict in DocumentArray1 {
                let dataDictionary = dataDict as! NSDictionary
                
                documentName1 = dataDictionary.object(forKey: "document") as! String
                documentData1 = dataDictionary.object(forKey: "documentData") as! Data
                documenttype1 = dataDictionary.object(forKey: "documenttype") as! String
            }
        }
       
        if DocumentArray2.count > 0 {
            for dataDict in DocumentArray2 {
                let dataDictionary = dataDict as! NSDictionary
                
                documentName2 = dataDictionary.object(forKey: "document") as! String
                documentData2 = dataDictionary.object(forKey: "documentData") as! Data
                documenttype2 = dataDictionary.object(forKey: "documenttype") as! String
            }
        }
        
        
        if ImgArray.count > 0 {
            for dataDict in ImgArray {
                let dataDictionary = dataDict as! NSDictionary
                
                imageName = dataDictionary.object(forKey: "image") as! String
                imageData = dataDictionary.object(forKey: "imageData") as! Data
                mimetype = dataDictionary.object(forKey: "imagetype") as! String
            }
        }
        

        var param : [String:String] = [:]
        
        for (key,val) in parameterDictionary {
            param[key as! String] = val as? String
        }
        
        //param["deviceId"] = deviceToken
        //param["device_type"] = "iphone"
        
        request.httpBody = createBodyWithParametersTwoDocumentsSingleImage(parameters: param, filePathKey: imageName, mimetype: mimetype, imageDataKey: imageData as NSData, documentfilePathKey1: documentName1, documentmimetype1: documenttype1, documentDataKey1: documentData1 as NSData,documentfilePathKey2: documentName2, documentmimetype2: documenttype2, documentDataKey2: documentData2 as NSData, boundary: boundary) as Data
        
        loadDataFromURL(request, completion:{(data, error) -> Void in
            //2
            if let urlData = data {
                success(urlData,error)
            }else{
                print(error!)
            }
        })
        
    }
    
    
    class func createBodyWithParametersTwoDocumentsSingleImage(parameters: [String: String]?, filePathKey: String?,mimetype: String, imageDataKey: NSData,documentfilePathKey1: String?,documentmimetype1: String,documentDataKey1: NSData,documentfilePathKey2: String?,documentmimetype2: String,documentDataKey2: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.append(("--\(boundary)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
                body.append(("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
                body.append(("\(value)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
            }
        }
        //MARK:-Image Array
        body.append(("--\(boundary)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"myImg.\(mimetype)\"\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(("Content-Type: \(mimetype)\r\n\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(imageDataKey as Data)
        body.append(("\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        
        body.append(("--\(boundary)--\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        
        
        //MARK:- Document Array1
        body.append(("--\(boundary)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(("Content-Disposition: form-data; name=\"\(documentfilePathKey1!)\"; filename=\"myDoc.\(documentmimetype1)\"\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        
        body.append(("Content-Type: \(documentmimetype1)\r\n\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(documentDataKey1 as Data)
        body.append(("\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        
        body.append(("--\(boundary)--\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        
        //MARK:- Document Array2
        body.append(("--\(boundary)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(("Content-Disposition: form-data; name=\"\(documentfilePathKey2!)\"; filename=\"myDoc.\(documentmimetype2)\"\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        
        body.append(("Content-Type: \(documentmimetype2)\r\n\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(documentDataKey2 as Data)
        body.append(("\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        
        body.append(("--\(boundary)--\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)

        return body
    }
    
    
    class func UploadSingleDocumentFileAndSingleImage(_ parameterDictionary :NSMutableDictionary,methodName:String, DocumentArray:NSArray,ImgArray:NSArray, success: @escaping ((_ iTunesData: NSDictionary?,_ error:NSError?) -> Void)) {
        
        
        print(parameterDictionary)
        
        let apiPath = "\(Config().API_URL)\(methodName)"
        print(apiPath)
        let request = NSMutableURLRequest(url:NSURL(string: apiPath)! as URL);
        request.httpMethod = "POST"
        
        let boundary = self.generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue(DataManager.getVal(Config().AppUserDefaults.value(forKey:"language")) as? String ?? "en", forHTTPHeaderField: "X-localization")
        
        var documentData = Data()
        var documentName  = ""
        var documenttype = String()

        var imageData = Data()
        var imageName  = ""
        var mimetype = String()
        
        if DocumentArray.count > 0 {
            for dataDict in DocumentArray {
                let dataDictionary = dataDict as! NSDictionary
                
                documentName = dataDictionary.object(forKey: "document") as! String
                documentData = dataDictionary.object(forKey: "documentData") as! Data
                documenttype = dataDictionary.object(forKey: "documenttype") as! String
            }
        }
       
        if ImgArray.count > 0 {
            for dataDict in ImgArray {
                let dataDictionary = dataDict as! NSDictionary
                
                imageName = dataDictionary.object(forKey: "image") as! String
                imageData = dataDictionary.object(forKey: "imageData") as! Data
                mimetype = dataDictionary.object(forKey: "imagetype") as! String
            }
        }
        

        var param : [String:String] = [:]
        
        for (key,val) in parameterDictionary {
            param[key as! String] = val as? String
        }
        
        //param["deviceId"] = deviceToken
        //param["device_type"] = "iphone"
        
        request.httpBody = createBodyWithParametersSingleDocument(parameters: param, filePathKey: imageName, mimetype: mimetype, imageDataKey: imageData as NSData, documentfilePathKey: documentName, documentmimetype: documenttype, documentDataKey: documentData as NSData, boundary: boundary) as Data
        
        loadDataFromURL(request, completion:{(data, error) -> Void in
            //2
            if let urlData = data {
                success(urlData,error)
            }else{
                print(error!)
            }
        })
        
    }
    
    class func createBodyWithParametersSingleDocument(parameters: [String: String]?, filePathKey: String?,mimetype: String, imageDataKey: NSData,documentfilePathKey: String?,documentmimetype: String,documentDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.append(("--\(boundary)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
                body.append(("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
                body.append(("\(value)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
            }
        }
        //MARK:-Image Array
        body.append(("--\(boundary)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"myImg.\(mimetype)\"\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(("Content-Type: \(mimetype)\r\n\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(imageDataKey as Data)
        body.append(("\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        
        body.append(("--\(boundary)--\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        //MARK:- Document Array

        body.append(("--\(boundary)\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(("Content-Disposition: form-data; name=\"\(documentfilePathKey!)\"; filename=\"myDoc.\(documentmimetype)\"\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        
        body.append(("Content-Type: \(documentmimetype)\r\n\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(documentDataKey as Data)
        body.append(("\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        
        body.append(("--\(boundary)--\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)

        return body
    }
}


