//
//  ViewController.swift
//  UISegmentAndUISegmentControlWithURLSerivice
//
//  Created by Vadde Narendra on 9/25/19.
//  Copyright © 2019 Vadde Narendra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var modeOfSegView = UISegmentedControl()
    var componentSegView = UISegmentedControl()
    var axisSegView = UISegmentedControl()
    var countSlider = UISlider()
    var countStepper = UIStepper()
    var countViewLbl = UILabel()
    var createBtnTapped = UIButton()
    var scrollView = UIScrollView()
    var getServerInfoBtnTapped = UIButton()
    var xPos = 10.0
    var yPos = 20.0
    var loopCount = 1
    var allBtns = [UILabel(),UISwitch(),UIButton()]
    var URLReqObj:URLRequest!
    var dataTaskObj:URLSessionDataTask!
    
    let serverComponents = GetServerComponents()
    
    var onlineStepper = UIStepper()
    var convertedData:[String:Any] = [:]
    var componentNumber = 0
    var executionCount = 0
    var componentQuantity = 0
    var maxPerRow =  10
    var visitedOnline = 0
    var displayNumber = 1
    var alphabetNumber = 0
    var component = ""
    var axis = ""
    var addStepper = 0
    var segmentCount = 0
    var componentCount = 0
   
    @IBOutlet weak var viewLbls:UIView!
    
    @IBOutlet weak var compntLbl: UILabel!
    
    @IBOutlet weak var rowLbl: UILabel!
    @IBOutlet weak var colomnLbl: UILabel!
    @IBOutlet weak var axisLbl: UILabel!
    @IBOutlet weak var quntityLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Creating UISegmentControlView for Off/Online
        
        modeOfSegView = UISegmentedControl(items: ["Off-Line","Online"])
        modeOfSegView.frame = CGRect(x: 10, y: 45, width: 400, height: 30)
        modeOfSegView.layer.cornerRadius = 5.0
        modeOfSegView.backgroundColor = UIColor.white
        modeOfSegView.tintColor = UIColor.blue
        view.addSubview(modeOfSegView)

        modeOfSegView.addTarget(self, action: #selector(onChangingSegModeView(modeView:)), for: .valueChanged)

        componentSegView.addTarget(self, action: #selector(onSelectionOfComponent(componentSC:)), for: .valueChanged)

        axisSegView.addTarget(self, action: #selector(onViewChange(viewSC:)), for: .valueChanged)

        countSlider = UISlider(frame: CGRect(x: 10, y: 135, width: 250, height: 30))
        countSlider.minimumValue = 1
        countSlider.maximumValue = 1000
        countSlider.thumbTintColor = UIColor.blue
        countSlider.minimumTrackTintColor = UIColor.black
        countSlider.maximumTrackTintColor = UIColor.red

        countViewLbl = UILabel(frame: CGRect(x: 280, y: 135, width: 200, height: 30))
        countViewLbl.textAlignment = .center
        countViewLbl.text = "Count"

        countStepper = UIStepper(frame: CGRect(x: 280, y: 180, width: 200, height: 30))
        countStepper.minimumValue = 1
        countStepper.maximumValue = 1000
        countStepper.backgroundColor = UIColor.yellow
        countStepper.addTarget(self, action: #selector(stepperFunction), for: UIControl.Event.valueChanged)
        onlineStepper.addTarget(self, action: #selector(stepperFunction), for: UIControl.Event.valueChanged)

        countSlider.isContinuous = false
        countSlider.addTarget(self, action: #selector(sliderValues), for: UIControl.Event.valueChanged)
        countSlider.value = Float(countStepper.value)

        scrollView.frame = CGRect(x: 10, y: 350, width: 420, height: 650)
        scrollView.backgroundColor = UIColor.purple

        createBtnTapped = UIButton(frame: CGRect(x: 10, y: 180, width: 200, height: 30))
        createBtnTapped.backgroundColor = UIColor.blue
        createBtnTapped.setTitle("Create Component", for: UIControl.State.normal)
        createBtnTapped.addTarget(self, action: #selector(createComponentsBtnTapped), for: UIControl.Event.touchUpInside)

        getServerInfoBtnTapped = UIButton(frame: CGRect(x: 175, y: 90, width: 60, height: 30))
        getServerInfoBtnTapped.setTitle("GET", for: UIControl.State.normal)
        getServerInfoBtnTapped.backgroundColor = UIColor.black

        getServerInfoBtnTapped.addTarget(self, action: #selector(getComponentsFromServerConnection), for: UIControl.Event.touchUpInside)

        
        // Do any additional setup after loading the view, typically from a nib.
    }

        // Creating Function for off/online view
        
      @objc func onChangingSegModeView(modeView:UISegmentedControl){
            
            switch modeView.selectedSegmentIndex {
                
            case 0:
                
                 scrollView.subviews.forEach({ $0.removeFromSuperview() })
                 onlineStepper.removeFromSuperview()
                 
                componentSegView = UISegmentedControl(items: ["Label","Button","Switch"])
                componentSegView.frame = CGRect(x: 10, y: 90, width: 210, height: 30)
                componentSegView.layer.cornerRadius = 5.0
                componentSegView.backgroundColor = UIColor.white
                componentSegView.tintColor = UIColor.blue
                
                view.addSubview(componentSegView)
                
                axisSegView = UISegmentedControl(items: ["Horizotal","Vertical"])
                axisSegView.frame = CGRect(x: 230, y: 90, width: 180, height: 30)
                axisSegView.layer.cornerRadius = 5.0
                axisSegView.backgroundColor = UIColor.white
                axisSegView.tintColor = UIColor.blue
                
                view.addSubview(axisSegView)
                view.addSubview(countSlider)
                view.addSubview(countStepper)
                view.addSubview(countViewLbl)
                view.addSubview(scrollView)
                view.addSubview(createBtnTapped)
                viewLbls.isHidden = true
                
                getServerInfoBtnTapped.removeFromSuperview()
               
            case 1:
                
                componentSegView.removeFromSuperview()
                axisSegView.removeFromSuperview()
                countViewLbl.removeFromSuperview()
                countStepper.removeFromSuperview()
                countSlider.removeFromSuperview()
                scrollView.removeFromSuperview()
                createBtnTapped.removeFromSuperview()
                viewLbls.isHidden = false
                
                view.addSubview(getServerInfoBtnTapped)
              
                
            default:
                break

            }
            
        }
    
    // creating function for on changing of slider
    
    @objc func sliderValues(){
        
        countStepper.value = Double(countSlider.value)
        countViewLbl.text = "\(Int(countSlider.value))"
        
    }
    
    // creating function for creating components

    @objc func onSelectionOfComponent(componentSC:UISegmentedControl){
        
        DispatchQueue.main.async {
            var contentRect = CGRect.zero
            
            for view in self.scrollView.subviews {
                contentRect = contentRect.union(view.frame)
            }
            
            self.scrollView.contentSize = contentRect.size
        }
        
        switch componentSC.selectedSegmentIndex {
            
        case 0:
            
            let myLabel = UILabel(frame: CGRect(x: xPos, y: yPos, width: 40, height: 20))
            myLabel.text = "\(loopCount)"
            myLabel.textColor = UIColor.black
            myLabel.textAlignment = .center
            myLabel.backgroundColor = UIColor.green
            
            scrollView.addSubview(myLabel)
            
            allBtns.append(myLabel)
            
        case 1:
            
            let myBtn = UIButton(frame: CGRect(x: xPos, y: yPos, width: 40, height: 20))
            myBtn.backgroundColor = UIColor.blue
            myBtn.setTitle("B.\(loopCount)", for: UIControl.State.normal)
            
            scrollView.addSubview(myBtn)
            
            allBtns.append(myBtn)
            
        case 2:
            
            let mySwitch = UISwitch(frame: CGRect(x: xPos, y: yPos, width: 40, height: 20))
            scrollView.addSubview(mySwitch)
            allBtns.append(mySwitch)

            
        default:
            break
        }
        
    }
    
     // creating function for creating components
    
    @objc func onViewChange(viewSC:UISegmentedControl){
        
        switch viewSC.selectedSegmentIndex {
            
        case 0:
            
            for val in allBtns{
                val.removeFromSuperview()
            }

            
            for _ in 1...(Int(countSlider.value)){
                for _ in 1...100 {
                    if (loopCount <= (Int(countSlider.value))){
                        onSelectionOfComponent(componentSC: componentSegView)
                        loopCount += 1
                        xPos += 50
                    }
                }
                    xPos = 10
                    yPos += 30
            }
            loopCount = 1
            xPos = 10.0
            yPos = 20.0
            
            
            
        case 1:
            
            for val in allBtns{
                val.removeFromSuperview()
            }

            for _ in 1...(Int(countSlider.value)){
                for _ in 1...100 {
                    if (loopCount <= (Int(countSlider.value))){
                        onSelectionOfComponent(componentSC: componentSegView)
                        loopCount += 1
                        yPos += 40
                    }
                }
                    yPos = 20
                    xPos += 50
            }
            loopCount = 1
            xPos = 10.0
            yPos = 20.0
        default:
            break
        }

    }
    
    // creating function for button tapped
    
    @objc func createComponentsBtnTapped(){
        onViewChange(viewSC: axisSegView)
    }
    
    // creating function for server button tapped
    
    @objc func getComponentsFromServerConnection(){
        
        getDataFromServer()
        
    }

    // creating function for getting data from server
    
    @objc func getDataFromServer(){
        
        onlineStepper.removeFromSuperview()
        convertedData = serverComponents.getDataFromServer()
        print(convertedData)
        axis = serverComponents.axis
        if(axis == "Horizontal") {
            maxPerRow = serverComponents.maxPerRow
        }else {
            maxPerRow = serverComponents.maxPerColumn
        }
        
        self.compntLbl.text = "\(convertedData["component"]as? String ?? "")"
        self.axisLbl.text = "\(convertedData["axis"]as? String ?? "")"
        self.quntityLbl.text = "\(convertedData["quantity"]as? Int ?? 0)"
        self.colomnLbl.text = "\(convertedData["maxPerColumn"]as? Int ?? 0)"
        self.rowLbl.text = "\(convertedData["maxPerRow"]as? Int ?? 0)"
        
        component = serverComponents.component
        componentQuantity = serverComponents.componentQuantity
        displayNumber = serverComponents.displayNumbers
        addStepper = serverComponents.changeQuantity
        
        alphabetNumber = 0
        createComponents()
        
        if(addStepper == 1){
            onlineStepper.frame =  CGRect(x: 240, y: 95, width: 30, height: 30)
            onlineStepper.backgroundColor = .red
            view.addSubview(onlineStepper)
        }
                
    }
    
    // creating function for Axis control for server based creations
    
    @objc func createComponents() {
        
        scrollView.isScrollEnabled = true
        super.viewDidLayoutSubviews()
        
        
        DispatchQueue.main.async {
            var contentRect = CGRect.zero
            
            for view in self.scrollView.subviews {
                contentRect = contentRect.union(view.frame)
            }
            
            self.scrollView.contentSize = contentRect.size
        }
        
        
        view.addSubview(scrollView)
        
        
        
        scrollView.subviews.forEach({ $0.removeFromSuperview() })
        
        
        if(componentQuantity > 0 && maxPerRow > 0){
            
            for  _ in 1...componentQuantity {
                
                
                for _ in 1...maxPerRow{
                    
                    if(componentCount < componentQuantity){
                        
                        componentNumber += 1
                        
                        selectedComponents(selectedValue: component)
                        
                        if(axis == "Horizontal"){
                            xPos += 60
                        }
                        if(axis == "Vertical"){
                            yPos += 50
                        }
                        componentNumber += 1
                        
                    }
                    
                }
                
                if(axis == "Horizontal"){
                    xPos = 10
                    yPos += 40
                }
                if(axis == "Vertical"){
                    yPos = 20
                    xPos += 60
                }
                
            }
            
            xPos = 10
            yPos = 20
            //componentCount = 0
            componentNumber = 0
            
        }
        
        countStepper.value = Double(componentQuantity)
        onlineStepper.value = Double(componentQuantity)
    }
    
    // creating function for creating components using server
    
    func selectedComponents(selectedValue: String) {
        
        switch selectedValue{
        case "Label":
            let label = UILabel()
            label.frame = CGRect(x: xPos, y: yPos, width: 35, height: 38)
            label.backgroundColor = UIColor.green
            label.textAlignment = .center
            if(displayNumber == 1){
                label.text = "\(componentNumber)"
            }
            else {
                if(alphabetNumber == 26){
                    alphabetNumber = 0
                }
                
                label.text = "\(serverComponents.alphabets[alphabetNumber])"
                alphabetNumber += 1
            }
            label.textColor = UIColor.black
            scrollView.addSubview(label)
            
        case "Button":
            let button = UIButton()
            button.frame = CGRect(x: xPos, y: yPos, width: 50, height: 30)
            button.backgroundColor = UIColor.red
            if(displayNumber == 1){
                button.setTitle("B.\(componentNumber)", for: UIControl.State.normal)
            }
            else {
                
                if(alphabetNumber == 26){
                    alphabetNumber = 0
                }
                
                button.setTitle("\(serverComponents.alphabets[alphabetNumber])", for: UIControl.State.normal)
                alphabetNumber += 1
            }
            
            button.setTitleColor(UIColor.black, for: UIControl.State.normal)
            scrollView.addSubview(button)
            
        case "Switch":
            let switchView = UISwitch()
            switchView.frame = CGRect(x: xPos, y: yPos, width: 35, height: 38)
            scrollView.addSubview(switchView)
            
            
        default:
            print("Somethiong's not right")
            
        }
    }
    
    // creating function for stepper
    
    @objc func stepperFunction(stepper: UIStepper) {
        alphabetNumber = 0
        if(stepper == countStepper){
            componentQuantity = Int(countStepper.value)
            
            countSlider.setValue(Float(countStepper.value), animated: true)
            countViewLbl.text = "\(Int(countSlider.value))"
            
             onViewChange(viewSC: axisSegView)
        }
        if(stepper == onlineStepper){
            componentQuantity = Int(onlineStepper.value)
            
            createComponents()
        }
    
    }
    
}
