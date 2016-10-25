//
//  Date + Extensions.swift
//  Extensions
//
//  Created by Christopher Erdos on 10/21/16.
//  Copyright © 2016 Erdos. All rights reserved.
//

import Foundation

extension Date {
	/**
	Adds seconds to a certain date.
	
	- Parameter seconds: Seconds you want to add.
	- Returns: Date advanced by number of `seconds`.
	*/
	func addSeconds(seconds: Int) -> Date {
		return addingTimeInterval(TimeInterval(seconds))
	}
	
	/**
	Subtracts seconds to a certain date.
	
	- Parameter seconds: Seconds you want to subtract.
	- Returns: Date subtracted by number of `seconds`.
	*/
	func subtractSeconds(seconds: Int) -> Date {
		return addSeconds(seconds: -seconds)
	}
	
	/**
	Adds minutes to a certain date.
	
	- Parameter minutes: Minutes you want to add.
	- Returns: Date advanced by number of `minutes`.
	*/
	func addMinutes(minutes: Int) -> Date {
		return addSeconds(seconds: minutes*60)
	}
	
	/**
	Subtracts minutes to a certain date.
	
	- Parameter minutes: Minutes you want to subtract.
	- Returns: Date subtracted by number of `minutes`.
	*/
	func subtractMinutes(minutes: Int) -> Date {
		return addSeconds(seconds: -60*minutes)
	}
	
	/**
	Adds hours to a certain date.
	
	- Parameter hours: Hours you want to add.
	- Returns: Date advanced by number of `hours`.
	*/
	func addHours(hours: Int) -> Date {
		return addMinutes(minutes: hours*60)
	}
	
	/**
	Subtracts hours to a certain date.
	
	- Parameter hours: Hours you want to subtract.
	- Returns: Date subtract by number of `hours`.
	*/
	func subtractHours(hours: Int) -> Date {
		return addMinutes(minutes: -60*hours)
	}
	
	/**
	Adds days to a certain date.
	
	- Parameter days: Days you want to add.
	- Returns: Date advanced by number of `days`.
	*/
	func addDays(days: Int) -> Date {
		return addHours(hours: 24*days)
	}
	
	/**
	Subtracts days to a certain date.
	
	- Parameter days: Days you want to subtract.
	- Returns: Date subtract by number of `days`.
	*/
	func subtractDays(days: Int) -> Date {
		return addHours(hours: -24*days)
	}
	
	/**
	Adds weeks to a certain date.
	
	- Parameter weeks: weeks you want to add.
	- Returns: Date advanced by number of `weeks`.
	*/
	func addWeeks(weeks: Int) -> Date {
		return addDays(days: 7*weeks)
	}
	
	/**
	Subtracts weeks to a certain date.
	
	- Parameter weeks: Days you want to subtract.
	- Returns: Date subtract by number of `weeks`.
	*/
	func subtractWeeks(weeks: Int) -> Date {
		return addDays(days: -7*weeks)
	}
	
	/**
	The MM/DD/YY format of a date.
	
	- Returns: String, ex. 08/14/16
	*/
	func MMDDYY() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .short
		
		return dateFormatter.string(from: self)
	}
	
	/**
	The DD/MM/YY format of a date.
	
	- Returns: String, ex. 14/08/16
	*/
	func DDMMYY() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .short
		dateFormatter.dateFormat = "dd/MM/YY"
		
		return dateFormatter.string(from: self)
	}
	
	
	/**
	The timestamp format of a date, no spaces.
	
	- Returns: String, ex. 2016-08-14_01:01:01
	*/
	func timestamp() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .short
		dateFormatter.dateFormat = "yyyy-mm-dd_hh:mm:ss"
		
		
		
		return dateFormatter.string(from: self)
	}
	
	/**
	The time of a date.
	
	- Returns: String, ex. 1:15 PM
	*/
	func time() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "h:mm a"
		
		return dateFormatter.string(from: self)
	}
	
	/**
	Slightly abbreviated format of a date.
	
	- Returns: e.g. Aug 14, 2016
	*/
	func mediumString() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		
		return dateFormatter.string(from: self)
	}
	
	/**
	Date written out.
	
	- Returns: e.g. August 14, 2016
	*/
	func string() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .long
		
		return dateFormatter.string(from: self)
	}
	
	/**
	Returns a string representing the time between a date and an `endDate`.
	
	- Returns: e.g. 1405 days, 7 hours, and 43 minutes
	*/
	func timeUntil(endDate: Date) -> String {
		let cal = NSCalendar.current
		let mins: Set = [Calendar.Component.minute]
		
		let minutesFromDateToEndDate = cal.dateComponents(mins, from: self, to: endDate)
		
		
		let leftOverHours = minutesFromDateToEndDate.value(for: Calendar.Component.minute)! % 1440
		let daysLeft = minutesFromDateToEndDate.value(for: Calendar.Component.minute)! / 1440
		let hoursLeft = leftOverHours / 60
		let minutesLeft = leftOverHours % 60
		var daysString: String!
		var hoursString: String!
		var minutesString: String!
		
		
		if daysLeft == 1 {
			daysString = "1 day,"
		} else if daysLeft == 0 {
			daysString = ""
		} else {
			daysString = "\(daysLeft) days"
		}
		
		
		if minutesLeft == 1 {
			minutesString = ", 1 minute"
		} else if minutesLeft == 0 {
			minutesString = ""
		} else {
			minutesString = ", \(minutesLeft) minutes"
		}
		
		if hoursLeft == 1 {
			hoursString = ", 1 hour"
		} else if hoursLeft == 0 {
			hoursString = ""
		} else {
			hoursString = ", \(hoursLeft) hours"
		}
		
		return ("\(daysString!)\(hoursString!)\(minutesString!)")
	}
	
	/**
	Compares two dates.
	
	- Parameter endDate: The date to compare.
	- Returns: `true` if date is before the `endDate`, `false` if it is afterwards.
	*/
	func isBefore(endDate: Date) -> Bool {
		if self.compare(endDate) == ComparisonResult.orderedAscending {
			return true
		} else {
			return false
		}
	}
}
