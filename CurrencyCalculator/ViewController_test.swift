//
//  ViewController.swift
//  SwiftSlideShow
//
//  Created by Mark on 17/10/2015.
//  Copyright (c) 2015 com.pixelstitch. All rights reserved.
//

import UIKit

class ViewController_test: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {

//    var scrollView: UIScrollView!
	var topScrollView:UIScrollView = UIScrollView()
	var markScrollView:UIScrollView = UIScrollView()
	
	var originalPosition:CGFloat = 0

	let screenSize: CGRect = UIScreen.mainScreen().bounds
//	let screenWidth = screenSize.width
//	let screenHeight = screenSize.height
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		self.view.backgroundColor = UIColor.blueColor()
//		let navHeight = self.navigationController!.navigationBar.bounds.height
		let status_height = UIApplication.sharedApplication().statusBarFrame.size.height
		self.createTextField()
//		self.setupScrollingButtons()
		
		var logoImage = UIImage(named: "logo")
		var logoImageView = UIImageView(image: logoImage)
		var logoImageSize:CGSize = CGSizeMake(logoImageView.bounds.width, logoImageView.bounds.height)
		logoImageView.frame = CGRectMake(screenSize.width/2 - logoImageSize.width/2, status_height, logoImageSize.width, logoImageSize.height)
		self.view.addSubview(logoImageView)
		var m:UILabel = UILabel(frame: CGRectMake(0, status_height + screenSize.height * 0.1, screenSize.width, 50))
		m.text = "AUS"
		m.backgroundColor = UIColor.redColor()
		m.textAlignment = .Center
		m.font = UIFont.systemFontOfSize(55)
		self.view.addSubview(m)
		
//		var masterView:UIView = UIView()
//		masterView.backgroundColor = UIColor.yellowColor()
//		masterView.frame = CGRectMake(0, 50, screenSize.width, screenSize.height*0.5)
//		
//		var indicatorDown = UIImage(named: "indicatorDown")
//		var indicatorUp = UIImage(named: "indicatorUp")
//		
//		var indicatorDownImageView = UIImageView(image: indicatorDown)
//		var indicatorDownImageSize:CGSize = CGSizeMake(indicatorDownImageView.bounds.width, indicatorDownImageView.bounds.height)
//		indicatorDownImageView.frame = CGRectMake(masterView.bounds.width/2 - indicatorDownImageSize.width/2, 50, indicatorDownImageSize.width, indicatorDownImageSize.height)
//		masterView.addSubview(indicatorDownImageView)
//		
//		
//		var indicatorUpImageView = UIImageView(image: indicatorUp)
//		var indicatorUpImageSize:CGSize = CGSizeMake(indicatorUpImageView.bounds.width, indicatorUpImageView.bounds.height)
//		indicatorUpImageView.frame = CGRectMake(masterView.bounds.width/2 - indicatorUpImageSize.width/2, 50, indicatorUpImageSize.width, indicatorUpImageSize.height)
//		masterView.addSubview(indicatorUpImageView)
//		
//		//		println("chatImageView.bounds.width \(chatImageView.bounds.width) -=- chatImageView.bounds.height: \(chatImageView.bounds.height)")
//		//		chatImageView.frame = CGRectMake(50, 50, indicatorUpImageView.bounds.width, indicatorUpImageView.bounds.height)
//		//		chatImageView.backgroundColor = UIColor.purpleColor()
//		self.view.addSubview(masterView)

		
    }

	func formatEnteredData(enteredData:String, currencySymbol:String) -> String {
		let largeNumber = NSNumberFormatter().numberFromString(enteredData)
		var numberFormatter = NSNumberFormatter()
		numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
		return currencySymbol + numberFormatter.stringFromNumber(largeNumber!)!
	}
	
	
	func createTextField(){
		let textFieldOzzieDollars:UITextField = UITextField(frame: CGRectMake(0, screenSize.height * 0.3, screenSize.width, screenSize.height * 0.1))
		textFieldOzzieDollars.clearButtonMode = UITextFieldViewMode.WhileEditing;
		textFieldOzzieDollars.backgroundColor = UIColor.greenColor()
//		textFieldOzzieDollars.borderStyle = UITextBorderStyle.Line
		textFieldOzzieDollars.font = UIFont.systemFontOfSize(35)
		textFieldOzzieDollars.contentVerticalAlignment = .Center
		textFieldOzzieDollars.contentHorizontalAlignment = .Center
		textFieldOzzieDollars.textAlignment = .Center
		textFieldOzzieDollars.autocorrectionType = UITextAutocorrectionType.No
		textFieldOzzieDollars.placeholder = "Enter $AUD amount"
//		textFieldOzzieDollars.inputAccessoryView = 
		textFieldOzzieDollars.adjustsFontSizeToFitWidth = true
		textFieldOzzieDollars.keyboardAppearance = .Dark
		textFieldOzzieDollars.delegate = self
		textFieldOzzieDollars.keyboardType = UIKeyboardType.NumbersAndPunctuation
		textFieldOzzieDollars.returnKeyType = UIReturnKeyType.Done
		self.view.addSubview(textFieldOzzieDollars)
	}
	
	func textFieldShouldReturn(textFieldOzzieDollars: UITextField) -> Bool {   //delegate method
		textFieldOzzieDollars.resignFirstResponder()
		println("Hello: " + formatEnteredData(textFieldOzzieDollars.text, currencySymbol: "$"))
		return true
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	func setupScrollingButtons(){
		//        self.scrollView.frame = CGRectMake(0, 0, 200, 200)
		//		self.scrollView.frame = CGRectMake(0, 0, self.view.frame.width, 100)
		//		self.scrollView.backgroundColor = UIColor.blackColor()
		let scrollViewWidth:CGFloat = 100 //self.scrollView.frame.width
		let scrollViewHeight:CGFloat = 100 //self.scrollView.frame.height
		
		//		self.markScrollView.frame = CGRectMake(100, 200, screenWidth, scrollViewHeight)
		//		self.markScrollView.backgroundColor = UIColor.blueColor()
		//		self.view.addSubview(self.markScrollView)
		
		self.topScrollView.frame = CGRectMake(50, 300, 100, scrollViewHeight)
		self.topScrollView.backgroundColor = UIColor.blueColor()
		self.view.addSubview(self.topScrollView)
		
		var offestNumber1:CGFloat = 0
		var offestNumber2:CGFloat = 0
		
		//		var but1:UIButton = UIButton(frame: CGRectMake(0, 0,scrollViewWidth, scrollViewHeight))
		//		but1.backgroundColor = UIColor.orangeColor()
		//		but1.setTitle("Button One", forState: UIControlState.Normal)
		//		self.scrollView.addSubview(but1)
		//
		//		var but2:UIButton = UIButton(frame: CGRectMake(scrollViewWidth, 0,scrollViewWidth, scrollViewHeight))
		//		but2.backgroundColor = UIColor.greenColor()
		//		but2.setTitle("Button Two", forState: UIControlState.Normal)
		//		self.scrollView.addSubview(but2)
		//
		//		var but3:UIButton = UIButton(frame: CGRectMake(scrollViewWidth*2, 0,scrollViewWidth, scrollViewHeight))
		//		but3.backgroundColor = UIColor.redColor()
		//		but3.setTitle("Button Three", forState: UIControlState.Normal)
		//		self.scrollView.addSubview(but3)
		//
		//		var but4:UIButton = UIButton(frame: CGRectMake(scrollViewWidth*3, 0,scrollViewWidth, scrollViewHeight))
		//		but4.backgroundColor = UIColor.yellowColor()
		//		but4.setTitle("Button Three", forState: UIControlState.Normal)
		//		self.scrollView.addSubview(but4)
		//		=========================
		var but1Top:UIButton = UIButton(frame: CGRectMake(0, 0,scrollViewWidth, scrollViewHeight))
		but1Top.backgroundColor = UIColor.orangeColor()
		but1Top.setTitle("Button One", forState: UIControlState.Normal)
		self.topScrollView.addSubview(but1Top)
		
		var but2Top:UIButton = UIButton(frame: CGRectMake(scrollViewWidth, 0,scrollViewWidth, scrollViewHeight))
		but2Top.backgroundColor = UIColor.greenColor()
		but2Top.setTitle("Button Two", forState: UIControlState.Normal)
		self.topScrollView.addSubview(but2Top)
		
		var but3Top:UIButton = UIButton(frame: CGRectMake(scrollViewWidth*2, 0,scrollViewWidth, scrollViewHeight))
		but3Top.backgroundColor = UIColor.redColor()
		but3Top.setTitle("Button Three", forState: UIControlState.Normal)
		self.topScrollView.addSubview(but3Top)
		
		var but4Top:UIButton = UIButton(frame: CGRectMake(scrollViewWidth*3, 0,scrollViewWidth, scrollViewHeight))
		but4Top.backgroundColor = UIColor.yellowColor()
		but4Top.setTitle("Button Three", forState: UIControlState.Normal)
		self.topScrollView.addSubview(but4Top)
		//		=========================
		var but1a:UIButton = UIButton(frame: CGRectMake(0, 0,scrollViewWidth, scrollViewHeight))
		but1a.backgroundColor = UIColor.orangeColor()
		but1a.setTitle("Button One", forState: UIControlState.Normal)
		self.markScrollView.addSubview(but1a)
		
		var but2a:UIButton = UIButton(frame: CGRectMake(scrollViewWidth, 0,scrollViewWidth, scrollViewHeight))
		but2a.backgroundColor = UIColor.greenColor()
		but2a.setTitle("Button Two", forState: UIControlState.Normal)
		self.markScrollView.addSubview(but2a)
		
		var but3a:UIButton = UIButton(frame: CGRectMake(scrollViewWidth*2, 0,scrollViewWidth, scrollViewHeight))
		but3a.backgroundColor = UIColor.redColor()
		but3a.setTitle("Button Three", forState: UIControlState.Normal)
		self.markScrollView.addSubview(but3a)
		
		var but4a:UIButton = UIButton(frame: CGRectMake(scrollViewWidth*3, 0,scrollViewWidth, scrollViewHeight))
		but4a.backgroundColor = UIColor.yellowColor()
		but4a.setTitle("Button Three", forState: UIControlState.Normal)
		self.markScrollView.addSubview(but4a)
		
		//4
		//		println("scrollViewWidth: \(scrollViewWidth) -=- \((scrollViewWidth) * 4)")
		////        self.scrollView.contentSize = CGSizeMake(500, self.scrollView.frame.height)
		//		self.scrollView.contentSize = CGSizeMake((scrollViewWidth) * 4, self.scrollView.frame.height)
		//        self.scrollView.delegate = self
		//		self.scrollView.pagingEnabled = true
		//		self.scrollView.scrollEnabled = true
		
		self.topScrollView.contentSize = CGSizeMake((scrollViewWidth) * 4, self.topScrollView.frame.height)
		self.topScrollView.delegate = self
		self.topScrollView.pagingEnabled = true
		self.topScrollView.scrollEnabled = true
		self.topScrollView.showsHorizontalScrollIndicator = false
		self.topScrollView.contentOffset = CGPoint(x: self.topScrollView.contentOffset.x - 100, y: self.topScrollView.contentOffset.y)
		
		self.markScrollView.contentSize = CGSizeMake((scrollViewWidth) * 4, self.topScrollView.frame.height)
		self.markScrollView.delegate = self
		self.markScrollView.alpha = 0.5
		self.markScrollView.contentOffset = CGPoint(x: self.markScrollView.contentOffset.x - 100, y: self.markScrollView.contentOffset.y)
		self.markScrollView.pagingEnabled = true
		self.markScrollView.scrollEnabled = true
	}
	
	
    //MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        var pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        var currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
		self.markScrollView.contentOffset = CGPoint(x: self.topScrollView.contentOffset.x - 100, y: self.topScrollView.contentOffset.y)

		
		var pageWidth1:CGFloat = CGRectGetWidth(self.topScrollView.frame)
		var currentPage1:CGFloat = floor((self.topScrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
		println("self.topScrollView.contentOffset.x1 \(self.topScrollView.contentOffset.x) -=- currentPage1: \(currentPage1) -=- pageWidth1: \(pageWidth1)")
//		self.topScrollView.contentOffset = CGPoint(x: self.topScrollView.contentOffset.x, y: self.topScrollView.contentOffset.y)
//		println("self.topScrollView.contentOffset.x2 \(self.topScrollView.contentOffset.x)")
		
		
        // Change the indicator
//        self.pageControl.currentPage = Int(currentPage);
        // Change the text accordingly
//        if Int(currentPage1) == 0{
////            textView.text = "Sweettutos.com is your blog of choice for Mobile tutorials"
//			println("0")
//        }else if Int(currentPage) == 1{
//			println("1")
////            textView.text = "I write mobile tutorials mainly targeting iOS"
//        }else if Int(currentPage) == 2{
//			println("2")
////            textView.text = "And sometimes I write games tutorials about Unity"
//        }else{
//			println("==")
////            textView.text = "Keep visiting sweettutos.com for new coming tutorials, and don't forget to subscribe to be notified by email :)"
//            // Show the "Let's Start" button in the last slide (with a fade in animation)
////            UIView.animateWithDuration(1.0, animations: { () -> Void in
////                self.startButton.alpha = 1.0
////            })
//        }
    }

//	func scrollViewDidScroll(topScrollView: UIScrollView){
//		println("scrollViewDidScroll")
//	}
	

	
	
	//		var but1:UIButton = UIButton(frame: CGRectMake(offestNumber1, 0,scrollViewWidth-offestNumber2, scrollViewHeight))
	//		but1.backgroundColor = UIColor.orangeColor()
	//		self.scrollView.addSubview(but1)
	//
	//		var but2:UIButton = UIButton(frame: CGRectMake(scrollViewWidth-offestNumber1, 0,scrollViewWidth-offestNumber2, scrollViewHeight))
	//		but2.backgroundColor = UIColor.greenColor()
	//		but2.alpha = 0.5
	//		self.scrollView.addSubview(but2)
	//
	//		var but3:UIButton = UIButton(frame: CGRectMake((scrollViewWidth-offestNumber1)*2, 0,scrollViewWidth-offestNumber2, scrollViewHeight))
	//		but3.backgroundColor = UIColor.redColor()
	//		but3.alpha = 0.5
	//		self.scrollView.addSubview(but3)
	//
	//		var but4:UIButton = UIButton(frame: CGRectMake((scrollViewWidth-offestNumber1)*3, 0,scrollViewWidth-offestNumber2, scrollViewHeight))
	//		but4.backgroundColor = UIColor.yellowColor()
	//		but3.alpha = 0.5
	//		self.scrollView.addSubview(but4)
	
	//
	//		var but1:UIButton = UIButton(frame: CGRectMake(0, 0,scrollViewWidth, scrollViewHeight))
	//		but1.backgroundColor = UIColor.orangeColor()
	//		self.scrollView.addSubview(but1)
	//
	//		var but2:UIButton = UIButton(frame: CGRectMake(scrollViewWidth, 0,scrollViewWidth, scrollViewHeight))
	//		but2.backgroundColor = UIColor.greenColor()
	//		self.scrollView.addSubview(but2)
	//
	//		var but3:UIButton = UIButton(frame: CGRectMake(scrollViewWidth*2, 0,scrollViewWidth, scrollViewHeight))
	//		but3.backgroundColor = UIColor.redColor()
	//		self.scrollView.addSubview(but3)
	//
	//		var but4:UIButton = UIButton(frame: CGRectMake(scrollViewWidth*3, 0,scrollViewWidth, scrollViewHeight))
	//		but4.backgroundColor = UIColor.yellowColor()
	//		self.scrollView.addSubview(but4)
	
	//        self.scrollView.addSubview(imgOne)
	//        self.scrollView.addSubview(imgTwo)
	//        self.scrollView.addSubview(imgThree)
	//        self.scrollView.addSubview(imgFour)
	
}

