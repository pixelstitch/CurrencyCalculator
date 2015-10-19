//
//  ViewController.swift
//  CurrencyCalculator
//
//  Created by Mark on 17/10/2015.
//  Copyright (c) 2015 com.pixelstitch. All rights reserved.
//	http://ustwo.github.io/fancy-pages/ios-developer/

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
	
	var scrollMaster:UIScrollView = UIScrollView()
	let scrollViewWidth:CGFloat = 110
	let scrollViewHeight:CGFloat = 100

	var btnCurrent:UIButton = UIButton()
	var currencies:[String] = ["CAD", "EUR", "GBP", "JPY", "USD"]
	var currenciesSymbols:[String] = ["$", "€", "£", "¥", "$"]
//	currency buttons...
	var but0Top:UIButton = UIButton()
	var but1Top:UIButton = UIButton()
	var but2Top:UIButton = UIButton()
	var but3Top:UIButton = UIButton()
	var but4Top:UIButton = UIButton()
	var fontSize:CGFloat = 30
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.blueColor()
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
		self.scrollMaster.frame = CGRectMake(100, 200, 110, self.scrollViewHeight)
		self.scrollMaster.contentSize = CGSizeMake((self.scrollViewWidth) * CGFloat(self.currencies.count), self.scrollMaster.frame.height)
		self.scrollMaster.backgroundColor = UIColor.yellowColor()
		self.scrollMaster.delegate = self
		self.scrollMaster.pagingEnabled = true
		self.scrollMaster.scrollEnabled = true
		self.scrollMaster.showsHorizontalScrollIndicator = false
		self.scrollMaster.clipsToBounds = false
		self.scrollMaster.contentOffset = CGPoint(x: self.scrollMaster.contentOffset.x, y: self.scrollMaster.contentOffset.y)
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
	
	func scrollViewDidEndDecelerating(scrollView: UIScrollView){
		// Test the offset and calculate the current page after scrolling ends
		var pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
		var currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
		var pageWidth1:CGFloat = CGRectGetWidth(self.scrollMaster.frame)
		var currentPage1:CGFloat = floor((self.scrollMaster.contentOffset.x-pageWidth/2)/pageWidth)+1
		println("self.topScrollView.contentOffset.x1 \(self.scrollMaster.contentOffset.x) -=- currentPage1: \(currentPage1) -=- pageWidth1: \(pageWidth1)")
		
		switch currentPage1 {
		case 0:
			println("0 zero")
			self.but0Top.setTitleColor(UIColor.whiteColor(), forState: .Normal)
			//			reset colour
			self.btnCurrent.setTitleColor(UIColor.greenColor(), forState: .Normal)
			self.btnCurrent = self.but0Top
		case 1:
			println("1 uno")
			self.but1Top.setTitleColor(UIColor.whiteColor(), forState: .Normal)
			//			reset colour
			self.btnCurrent.setTitleColor(UIColor.greenColor(), forState: .Normal)
			self.btnCurrent = self.but1Top
		case 2:
			println("2 dos")
			self.but2Top.setTitleColor(UIColor.whiteColor(), forState: .Normal)
			//			reset colour
			self.btnCurrent.setTitleColor(UIColor.greenColor(), forState: .Normal)
			self.btnCurrent = self.but2Top
		case 3:
			println("3 tres")
			self.but3Top.setTitleColor(UIColor.whiteColor(), forState: .Normal)
			//			reset colour
			self.btnCurrent.setTitleColor(UIColor.greenColor(), forState: .Normal)
			self.btnCurrent = self.but3Top
		case 4:
			println("4")
			self.but4Top.setTitleColor(UIColor.whiteColor(), forState: .Normal)
			//			reset colour
			self.btnCurrent.setTitleColor(UIColor.greenColor(), forState: .Normal)
			self.btnCurrent = self.but4Top
		default:
			println("Something else")
		}
	}
}