//
//  GetServerComponents.swift
//  UISegmentAndUISegmentControlWithURLSerivice
//
//  Created by Vadde Narendra on 9/26/19.
//  Copyright © 2019 Vadde Narendra. All rights reserved.
//

import UIKit

class GetServerComponents: NSObject {
    
    
    var convertedData:[String:Any]!
    var axis = ""
    var changeQuantity = 0
    var componentQuantity = 0
    var maxPerRow = 0
    var component = ""
    var displayNumbers = 0
    var maxPerColumn = 0
    var alphabets: [Character]  = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    func getDataFromServer() -> [String:Any] {
    
        var urlObj = URLRequest(url: URL(string: "https://www.brninfotech.com/tws/ComponentCreation.php")!)
        urlObj.httpMethod = "Get"
        let  taskObj = URLSession.shared.dataTask(with: urlObj) { (data, response, err) in
            do{
                self.convertedData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String : Any]
                
                
                self.axis = self.convertedData["axis"] as? String ?? ""
                self.changeQuantity = self.convertedData["changeQuantity"] as? Int ?? 0
                self.component = self.convertedData["component"] as? String ?? ""
                self.maxPerRow = self.convertedData["maxPerRow"] as? Int ?? 0
                self.componentQuantity = self.convertedData["quantity"] as? Int ?? 0
                self.displayNumbers = self.convertedData["displayNumbers"] as? Int ?? 0
                self.maxPerColumn = self.convertedData["maxPerColumn"] as? Int ?? 0
                
            }catch{
                print("Something went wrong")
            }
            
            
        }
        taskObj.resume()
        
        while(convertedData == nil){
            print(1)
        }
        //taskObj.suspend()
        return convertedData
      
    }
    
        func displayData() {
    
            print(" The Axis is : \(axis)")
            print(" The componentQuantity is : \(componentQuantity)")
            print(" The display numbers is : \(displayNumbers)")
            print(" The maxPerRow is : \(maxPerRow)")
            print(" The component is : \(component)")
            print(" The changeQuantity is : \(changeQuantity)")
    
    
        }
    
}
