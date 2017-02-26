//
//  HTTPSRequest.swift
//  Pods
//
//  Created by Timothy Barnard on 08/02/2017.
//
//

import Foundation
#if os(iOS)
    import UIKit
    import MobileCoreServices
#else
    import CoreServices
#endif

public class HTTPSRequest {
    
    
    class func httpPostFileRequest(path : String, endPoint : String, postCompleted : @escaping (_ succeeded: Bool, _ data: String) -> ()) {
        
        let urlPath = ""//readPlistURL() + endPoint
        
        let request: URLRequest
        
        do {
            request = try createRequest(filePath: path, url: urlPath)
        } catch {
            print(error)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                // handle error here
                postCompleted(false, (error?.localizedDescription)! )
                return
            }
            
            // if response was JSON, then parse it
            
            do {
                let responseDictionary = try JSONSerialization.jsonObject(with: data!)
                print("success == \(responseDictionary)")
                postCompleted(true, "success" )
                // note, if you want to update the UI, make sure to dispatch that to the main queue, e.g.:
                //
                // DispatchQueue.main.async {
                //     // update your UI and model objects here
                // }
            } catch {
                postCompleted(false, (error.localizedDescription) )
                let responseString = String(data: data!, encoding: .utf8)
                print("responseString = \(responseString)")
            }
        }
        task.resume()
    }
    
    /// Create request
    ///
    /// - parameter userid:   The userid to be passed to web service
    /// - parameter password: The password to be passed to web service
    /// - parameter email:    The email address to be passed to web service
    ///
    /// - returns:            The NSURLRequest that was created
    
    private class func createRequest(filePath: String, url: String) throws -> URLRequest {
        let parameters = [
            "name" : "image1"
            //"user_id"  : userid,
            //"email"    : email,
            //"password" : password
        ]  // build your dictionary however appropriate
        
        let boundary = generateBoundaryString()
        
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        //let path1 = Bundle.main.path(forResource: "image1", ofType: "png")!
        request.httpBody = try createBody(with: parameters, filePathKey: "file", paths: [filePath], boundary: boundary)
        
        return request
    }
    
    /// Create body of the multipart/form-data request
    ///
    /// - parameter parameters:   The optional dictionary containing keys and values to be passed to web service
    /// - parameter filePathKey:  The optional field name to be used when uploading files. If you supply paths, you must supply filePathKey, too.
    /// - parameter paths:        The optional array of file paths of the files to be uploaded
    /// - parameter boundary:     The multipart/form-data boundary
    ///
    /// - returns:                The NSData of the body of the request
    
    private class func createBody(with parameters: [String: String]?, filePathKey: String, paths: [String], boundary: String) throws -> Data {
        var body = Data()
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.append("\(value)\r\n")
            }
        }
        
        for path in paths {
            let url = URL(fileURLWithPath: path)
            let filename = url.lastPathComponent
            let data = try Data(contentsOf: url)
            let mimetype = mimeType(for: path)
            
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(filename)\"\r\n")
            body.append("Content-Type: \(mimetype)\r\n\r\n")
            body.append(data)
            body.append("\r\n")
        }
        
        body.append("--\(boundary)--\r\n")
        return body
    }
    
    /// Create boundary string for multipart/form-data request
    ///
    /// - returns:            The boundary string that consists of "Boundary-" followed by a UUID string.
    
    class func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    /// Determine mime type on the basis of extension of a file.
    ///
    /// This requires MobileCoreServices framework.
    ///
    /// - parameter path:         The path of the file for which we are going to determine the mime type.
    ///
    /// - returns:                Returns the mime type if successful. Returns application/octet-stream if unable to determine mime type.
    
    class func mimeType(for path: String) -> String {
        let url = NSURL(fileURLWithPath: path)
        let pathExtension = url.pathExtension
        
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension! as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream";
    }
    
    
}
