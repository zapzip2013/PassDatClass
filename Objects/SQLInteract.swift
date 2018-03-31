//
//  SQLInteract.swift
//  ClassesManager
//
//  Created by Jose Carlos on 2/8/18.
//  Copyright © 2018 PassDatClass. All rights reserved.
//
//
/* Implemented by Jose Carlos & Jordan Mussman */

public typealias ResQuery = [[String: Any]]
public typealias RowQuery = [String:Any]
public typealias StatusMsg = (status: Bool, msg: String)


import Foundation
import Alamofire
import Alamofire_Synchronous


public class SQLInteract{
    //MARK: Propierties
    static let downloadURL = "https://jcquiles.com/images/"
    static var phpFile: URL! = URL(string: "https://jcquiles.com/DRDatabase.php") // e.g. http://jcquiles.com/DRDatabase.php
    static let phpUpload: URLConvertible = "https://jcquiles.com/upload.php"
    static let host = "localhost"
    /* If your database is on the same server as the php file,
    *  use 'localhost' , otherwise use the ip address of
    *  your database and configure remote access.
    */
    static let databaseName = "PassDatClass" // name of your MySQL database
    static let username = "tallafoc"
    static let password = "carlos13"
    
    static var parameters = [   /* Parameters are needed to pass into the Alamofire.request() function*/
        "h" : host,
        "d" : databaseName,
        "u" : username,
        "p" : password
    ]
    
    class func imageTobase64 (image: UIImage) -> String {
        var base64String = ""
        let  cim = CIImage(image: image)
        if (cim != nil) {
            let imageData = UIImageJPEGRepresentation(image, 1.0)! as NSData
            base64String = imageData.base64EncodedString(options: .lineLength64Characters)
        }
        return base64String
    }
    
/* Helper function for imageTobase64() */
    class func base64ToImage (base64: String?) -> UIImage? {
        var img: UIImage = UIImage()
        if base64 != nil{
            let base = base64!
            if (!base.isEmpty) {
                let decodedData = Data(base64Encoded: base , options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
                let decodedimage = UIImage(data: decodedData as Data, scale: 1.0)
                img = (decodedimage as UIImage?)!
            }
        }
        else{
            return nil
        }
        
        return img
    }
    
    
    public class func uploadPhoto(tutor: Tutor) -> Void{
        let imageData = UIImageJPEGRepresentation(tutor.photo!, 1)!
        let filename = tutor.email + ".jpg"
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "image", fileName: filename, mimeType: "file/jpeg")
        },
            to: phpUpload,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        }
        )
        
    }
    
    public class func donwloadPhoto(tutor: Tutor) -> UIImage {
        let email = tutor.email + ".jpg"
        let photoresult = Alamofire.download(downloadURL+email).responseData()
        if let photo = photoresult.value {
            return UIImage(data: photo)!
        }
        else {
            return #imageLiteral(resourceName: "images.jpg")
        }
    }
    
    //MARK: Methods
    public class func ExecuteSelect(query: String) -> ([[String:Any]], StatusMsg){
/* ***TO DO***: Figure out how to force errors; figure out when the alamofire.request() doesn't work and at what stage it failed */
        var ret = ResQuery()
        var status : StatusMsg
        
        parameters["e"] = query
        if (!checkQuery(query)){
            return (ret, (false, "Entered data not valid"))
        }
        let response = Alamofire.request(phpFile, method: .post, parameters: parameters).responseJSON()
        
        if let responserror = response.error {
            status = (false, String(describing: responserror)) /* If connection or php script failed */
        }
        else{
            let value = response.data
            do{ /* Must use "JSONSerialization.jsonObject()" */
                let json = try JSONSerialization.jsonObject(with: value!) as! [[String:Any]]
                ret = json
                status = (true, "Everything is OK")
            } catch {
                status = (false,String(describing: error)) /* If query failed */
            }
        }
        
        return (ret,status)
    }
   
/* Modify SQL queries that use ExecuteSelect() function */
    public class func ExecuteModification(query: String) -> StatusMsg {
        let resquery = ExecuteSelect(query: query)
        return (resquery.1)
    }
    
    class func checkQuery(_ query : String) -> Bool {
        let arr = ["drop","modify"]
        
        for x in arr{
            if query.lowercased().range(of: x) != nil{
                return false
            }
        }
        return true
    } /* End of checkQuery() */
}

