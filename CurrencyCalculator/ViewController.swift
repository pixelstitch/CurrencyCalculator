//
//  ViewController.swift
//  CurrencyCalculator
//
//  Created by Mark on 17/10/2015.
//  Copyright (c) 2015 com.pixelstitch. All rights reserved.
//	http://ustwo.github.io/fancy-pages/ios-developer/

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate, NSURLConnectionDelegate {
	
	var scrollMaster:UIScrollView = UIScrollView()
	let scrollViewWidth:CGFloat = 110
	let scrollViewHeight:CGFloat = 100
	var status_height:CGFloat = 0
	let screenSize: CGRect = UIScreen.mainScreen().bounds
	var btnCurrent:UIButton = UIButton()
	var currencies:[String] = ["CAD", "EUR", "GBP", "JPY", "USD"]
	var currenciesSymbols:[String] = ["$", "€", "£", "¥", "$"]
//	currency buttons...
	var but0Top:UIButton = UIButton()
	var but1Top:UIButton = UIButton()
	var but2Top:UIButton = UIButton()
	var but3Top:UIButton = UIButton()
	var but4Top:UIButton = UIButton()
	var fontSize:CGFloat = 40
	var textFieldOzzieDollars:UITextField = UITextField()
	var result:UILabel = UILabel()
	var exchangeRates:[Cashola] = []
//	colours
	var masterGreen:UIColor = UIColor(red: 52/255, green: 200/255, blue: 109/255, alpha: 1.0)
	var selectionGreen:UIColor = UIColor(red: 52/255, green: 182/255, blue: 101/255, alpha: 1.0)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = masterGreen
//		setup initial valuse...
		self.setupInitialValues()
//		initially - get the current currency information....
		self.parseCurrencyInformation()
//		get the height of the status bar
		self.status_height = UIApplication.sharedApplication().statusBarFrame.size.height
//		add the logo
		self.addLogo()
//		add the currency entry field...
		self.createTextField()
//		add results field.
		self.organiseResultTextField()
		
		
//		set up a current button so that we know what 
		self.btnCurrent = self.but0Top
		for i in 0..<currencies.count{
			switch i {
			case 0:
				println("0 Zero")
				self.buttonSetup(CGFloat(i), but: self.but0Top, currencyTicker: currencies[i])
			case 1:
				println("1 uno")
				self.buttonSetup(CGFloat(i), but: self.but1Top, currencyTicker: currencies[i])
			case 2:
				println("2 dos")
				self.buttonSetup(CGFloat(i), but: self.but2Top, currencyTicker: currencies[i])
			case 3:
				println("3 tres")
				self.buttonSetup(CGFloat(i), but: self.but3Top, currencyTicker: currencies[i])
			case 4:
				println("4")
				self.buttonSetup(CGFloat(i), but: self.but4Top, currencyTicker: currencies[i])
			default:
				println("Something else")
			}
		}
		
		var m:UIView = UIView(frame: CGRectMake(0, screenSize.height * 0.45, screenSize.width, screenSize.height * 0.2))
		m.backgroundColor = self.selectionGreen
		
		self.scrollMaster.frame = CGRectMake(100, screenSize.height * 0.45, 110, self.scrollViewHeight)
		self.scrollMaster.contentSize = CGSizeMake((self.scrollViewWidth) * CGFloat(self.currencies.count), self.scrollMaster.frame.height)
//		self.scrollMaster.backgroundColor = masterGreen //UIColor.yellowColor()
		self.scrollMaster.delegate = self
		self.scrollMaster.pagingEnabled = true
		self.scrollMaster.scrollEnabled = true
		self.scrollMaster.showsHorizontalScrollIndicator = false
		self.scrollMaster.clipsToBounds = false
		self.scrollMaster.contentOffset = CGPoint(x: self.scrollMaster.contentOffset.x, y: self.scrollMaster.contentOffset.y)
//		m.addSubview(self.scrollMaster)
		self.view.addSubview(m)
		self.view.addSubview(self.scrollMaster)
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	func buttonSetup(i:CGFloat, but:UIButton, currencyTicker:String){
		but.frame = CGRectMake(self.scrollViewWidth*i, 0,scrollViewWidth, scrollViewHeight)
		but.tag = Int(i)
		but.setTitle(currencyTicker, forState: UIControlState.Normal)
		but.titleLabel!.font =  UIFont(name: "Arial", size: self.fontSize)
//		initial button selection colour is white
		if(i == 0){
			but.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		} else {
			but.setTitleColor(UIColor.greenColor(), forState: .Normal)
		}
		but.addTarget(self, action: "selectCurrency:", forControlEvents: .TouchUpInside)
		self.scrollMaster.addSubview(but)
	}

	func selectCurrency(sender:UIButton){
		println(sender.tag)
	}
	
	func textFieldShouldReturn(t:UITextField) -> Bool {   //delegate method
		t.resignFirstResponder()
		if(t.text.isEmpty){
			self.textFieldOzzieDollars.text = "0"
		} else {
			var currentButtonNumber = self.btnCurrent.tag
			self.result.text = self.determintExchangeRateValue(
				CGFloat(NSNumberFormatter().numberFromString(
					self.textFieldOzzieDollars.text)!),
				currencySymbol: self.currenciesSymbols[Int(currentButtonNumber)],
				cashInfo: self.exchangeRates[Int(currentButtonNumber)])
		}
		println("Hello: " + formatEnteredData(t.text, currencySymbol: "$"))
		return true
	}
	
	func setupInitialValues() {
		self.result.text = self.formatEnteredData("0", currencySymbol: "$")
	}
	
	func formatEnteredData(enteredData:String, currencySymbol:String) -> String {
//		the user can enter what ever kind of data they wan. So they can have 4 decimal places if they want.
		let largeNumber = NSNumberFormatter().numberFromString(enteredData)
		var numberFormatter = NSNumberFormatter()
		numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
		return currencySymbol + numberFormatter.stringFromNumber(largeNumber!)!
	}
	
	func organiseResultTextField(){
		self.result.frame = CGRectMake(0, screenSize.height * 0.7, screenSize.width, screenSize.height * 0.1)
		self.result.textAlignment = .Center
		self.result.backgroundColor = self.masterGreen //UIColor.brownColor()
		self.result.font = UIFont.systemFontOfSize(50)
		self.result.textColor = UIColor.whiteColor()
		self.result.adjustsFontSizeToFitWidth = true
		self.view.addSubview(self.result)
	}
	
	func determintExchangeRateValue(enteredData:CGFloat, currencySymbol:String, cashInfo:Cashola) -> String {
//		want to return only correctly formatted currency values, so two decimal places.
//		println("enteredData: \(enteredData) -=- currencySymbol: \(currencySymbol) -=- cashInfo -currencyName: \(cashInfo.currencyName) -=- cashInfo -currencyName: \(cashInfo.exchangeRate)")
		var exchangeAmount_asCGFloat = enteredData * cashInfo.exchangeRate
		let numberOfPlaces:CGFloat = 2.0
		let multiplier = pow(10.0, numberOfPlaces)
		exchangeAmount_asCGFloat = round(exchangeAmount_asCGFloat * multiplier) / multiplier
		var numberFormatter = NSNumberFormatter()
		numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
		return currencySymbol + numberFormatter.stringFromNumber(exchangeAmount_asCGFloat)!
	}
	
	func scrollViewDidEndDecelerating(scrollView: UIScrollView){
		// Test the offset and calculate the current page after scrolling ends
		var pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
		var currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
		var pageWidth1:CGFloat = CGRectGetWidth(self.scrollMaster.frame)
		var currentPage1:CGFloat = floor((self.scrollMaster.contentOffset.x-pageWidth/2)/pageWidth)+1
		var currentValue:String = ""
		if(self.textFieldOzzieDollars.text.isEmpty){
			self.textFieldOzzieDollars.text = "0"
		}
		switch currentPage1 {
		case 0:
			println("0 zero")
			self.but0Top.setTitleColor(UIColor.whiteColor(), forState: .Normal)
			//			reset colour
			self.btnCurrent.setTitleColor(UIColor.greenColor(), forState: .Normal)
			self.btnCurrent = self.but0Top
//			println(self.currencies[Int(currentPage1)] + " " + self.currenciesSymbols[Int(currentPage1)])
			currentValue = self.determintExchangeRateValue(
				CGFloat(NSNumberFormatter().numberFromString(self.textFieldOzzieDollars.text)!),
				currencySymbol: self.currenciesSymbols[Int(currentPage1)],
				cashInfo: self.getCasholaInfo(self.exchangeRates, currencyName: self.currencies[0]))
		case 1:
			println("1 uno")
			self.but1Top.setTitleColor(UIColor.whiteColor(), forState: .Normal)
			//			reset colour
			self.btnCurrent.setTitleColor(UIColor.greenColor(), forState: .Normal)
			self.btnCurrent = self.but1Top
//			println(self.currencies[Int(currentPage1)] + " " + self.currenciesSymbols[Int(currentPage1)])
			
			currentValue = self.determintExchangeRateValue(
				CGFloat(NSNumberFormatter().numberFromString(self.textFieldOzzieDollars.text)!),
				currencySymbol: self.currenciesSymbols[Int(currentPage1)],
				cashInfo: self.getCasholaInfo(self.exchangeRates, currencyName: self.currencies[1]))
		case 2:
			println("2 dos")
			self.but2Top.setTitleColor(UIColor.whiteColor(), forState: .Normal)
			//			reset colour
			self.btnCurrent.setTitleColor(UIColor.greenColor(), forState: .Normal)
			self.btnCurrent = self.but2Top
//			println(self.currencies[Int(currentPage1)] + " " + self.currenciesSymbols[Int(currentPage1)])
			
			currentValue = self.determintExchangeRateValue(
				CGFloat(NSNumberFormatter().numberFromString(self.textFieldOzzieDollars.text)!),
				currencySymbol: self.currenciesSymbols[Int(currentPage1)],
				cashInfo: self.getCasholaInfo(self.exchangeRates, currencyName: self.currencies[2]))
		case 3:
			println("3 tres")
			self.but3Top.setTitleColor(UIColor.whiteColor(), forState: .Normal)
			//			reset colour
			self.btnCurrent.setTitleColor(UIColor.greenColor(), forState: .Normal)
			self.btnCurrent = self.but3Top
//			println(self.currencies[Int(currentPage1)] + " " + self.currenciesSymbols[Int(currentPage1)])
			
			currentValue = self.determintExchangeRateValue(
				CGFloat(NSNumberFormatter().numberFromString(self.textFieldOzzieDollars.text)!),
				currencySymbol: self.currenciesSymbols[Int(currentPage1)],
				cashInfo: self.getCasholaInfo(self.exchangeRates, currencyName: self.currencies[3]))
		case 4:
			println("4")
			self.but4Top.setTitleColor(UIColor.whiteColor(), forState: .Normal)
			//			reset colour
			self.btnCurrent.setTitleColor(UIColor.greenColor(), forState: .Normal)
			self.btnCurrent = self.but4Top
//			println(self.currencies[Int(currentPage1)] + " " + self.currenciesSymbols[Int(currentPage1)])
			
			currentValue = self.determintExchangeRateValue(
				CGFloat(NSNumberFormatter().numberFromString(self.textFieldOzzieDollars.text)!),
				currencySymbol: self.currenciesSymbols[Int(currentPage1)],
				cashInfo: self.getCasholaInfo(self.exchangeRates, currencyName: self.currencies[4]))
		default:
			println("Something else")
		}
		println("currentValue = \(currentValue)")
		self.result.text = currentValue
	}
	
	func parseCurrencyInformation(){
		var postEndpoint: String = "http://api.fixer.io/latest?base=AUD&symbols=CAD,EUR,GBP,JPY,USD"
		var urlRequest = NSURLRequest(URL: NSURL(string: postEndpoint)!)
		NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue(), completionHandler:{
			(response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
			if let anError = error {
				// got an error in getting the data, need to handle it
				println("error calling GET on /posts/1")
			} else {
				// parse the result as json, since that's what the API provides
				var jsonError: NSError?
				let post = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as! NSDictionary
				if let aJSONError = jsonError {
					// got an error while parsing the data, need to handle it
					println("error parsing /posts/1")
				} else {
					if let items = post["rates"] as? NSDictionary {
						for item in items {
							println("key: \(item.key)")
							println("value: \(item.value)")
							var c:Cashola = Cashola(currencyName: item.key as! String, exchangeRate: CGFloat(item.value as! NSNumber))
							self.exchangeRates.append(c)
						}
					}
				}
			}
		})
	}
	
	func createTextField(){
		self.textFieldOzzieDollars.frame = CGRectMake(0, screenSize.height * 0.3, screenSize.width, screenSize.height * 0.1)
		self.textFieldOzzieDollars.clearButtonMode = UITextFieldViewMode.WhileEditing;
		self.textFieldOzzieDollars.backgroundColor = self.masterGreen //UIColor.greenColor()
		self.textFieldOzzieDollars.font = UIFont.systemFontOfSize(50)
		self.textFieldOzzieDollars.textColor = UIColor.whiteColor()
		self.textFieldOzzieDollars.contentVerticalAlignment = .Center
		self.textFieldOzzieDollars.contentHorizontalAlignment = .Center
		self.textFieldOzzieDollars.textAlignment = .Center
		self.textFieldOzzieDollars.text = "0"
		self.textFieldOzzieDollars.autocorrectionType = UITextAutocorrectionType.No
//		self.textFieldOzzieDollars.placeholder = "Enter $AUD amount"
		self.textFieldOzzieDollars.adjustsFontSizeToFitWidth = true
		self.textFieldOzzieDollars.keyboardAppearance = .Dark
		self.textFieldOzzieDollars.delegate = self
		self.textFieldOzzieDollars.keyboardType = UIKeyboardType.NumbersAndPunctuation
		self.textFieldOzzieDollars.returnKeyType = UIReturnKeyType.Done
		self.view.addSubview(self.textFieldOzzieDollars)
	}
	
	func addLogo(){
		var logoImage = UIImage(named: "logo")
		var logoImageView = UIImageView(image: logoImage)
		var logoImageSize:CGSize = CGSizeMake(logoImageView.bounds.width, logoImageView.bounds.height)
		logoImageView.frame = CGRectMake(screenSize.width/2 - logoImageSize.width/2, self.status_height, logoImageSize.width, logoImageSize.height)
		self.view.addSubview(logoImageView)
		var m:UILabel = UILabel(frame: CGRectMake(0, self.status_height + screenSize.height * 0.1, screenSize.width, 50))
		m.text = "AUD"
		m.textColor = UIColor.whiteColor()
		m.backgroundColor = self.masterGreen //UIColor.redColor()
		m.textAlignment = .Center
		m.font = UIFont.systemFontOfSize(55)
		self.view.addSubview(m)
	}

	func getCasholaInfo(exchangeRates:[Cashola], currencyName:String) -> Cashola {
		var returnValue:Cashola = Cashola(currencyName: "", exchangeRate: -1)
		for i in 0..<exchangeRates.count {
			if(currencyName == exchangeRates[i].currencyName){
				println("curencyName \(exchangeRates[i].currencyName)")
				returnValue.currencyName = exchangeRates[i].currencyName
				returnValue.exchangeRate = exchangeRates[i].exchangeRate
			}
		}
		return returnValue
	}
}
struct Cashola {
	var currencyName:String = ""
	var exchangeRate:CGFloat = 0
	init(currencyName:String, exchangeRate:CGFloat){
		self.currencyName = currencyName
		self.exchangeRate = exchangeRate
	}
}