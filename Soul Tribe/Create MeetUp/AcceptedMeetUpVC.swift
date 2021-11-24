//
//  AcceptedMeetUpVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
import FSCalendar



class AcceptedMeetUpVC: UIViewController {
    
    @IBOutlet weak var lbl_tableTopDate: UILabel!
    
    @IBOutlet weak var DatePickerView: UIView!
    
    //MARK:- IBOutlet
    @IBOutlet weak var lbl_calendarDateSelected: UILabel!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var viewdate: UIView!
    @IBOutlet weak var txtdate: UITextField!
    @IBOutlet weak var btndate: UIButton!
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var MeetupsTableView: UITableView!
    @IBOutlet weak var myCalendar: FSCalendar!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBAction func btn_doneDatePickerAction(_ sender: UIButton) {
        DatePickerView.isHidden = true
        btndate.isSelected = false
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        selectedDateStr = dateFormatter.string(from: selectedDate)
        selectedDateStr = (selectedDateStr.components(separatedBy: " "))[0]
        txtdate.text = selectedDateStr
        
        let df1 = DateFormatter()
        df1.dateFormat = "LLLL"
        monthString = df1.string(from: selectedDate)
        
        let df2 = DateFormatter()
        df2.dateFormat = "YYYY"
        yearString = df2.string(from: selectedDate)
        
        self.lbl_calendarDateSelected.text = "\(monthString) \(yearString)"
        self.lbl_tableTopDate.text = "\(monthString) \(yearString)"
        
        self.myCalendar.reloadData()
        getdata()
    }
    
    @IBAction func btn_jumpToDateAction(_ sender: UIButton) {
        btnDateSelected()
    }
    
    @IBAction func DatePickerValueChanged(_ sender: UIDatePicker?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
            
        if let date = sender?.date {
            print("Picked the date \(dateFormatter.string(from: date))")
            
            selectedDate = date
          
        }
    }
    
    var selectedDateStr = ""
    var selectedDate : Date = Date()
    
    var arr_data = [[String:Any]]()

    var monthString = ""
    var yearString = ""
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DatePickerView.isHidden = true
        
        
        DatePickerView.layer.cornerRadius = 5
        DatePickerView.layer.cornerRadius = 5
        DatePickerView.layer.borderWidth = 1
        DatePickerView.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        MeetupsTableView.delegate = self
        MeetupsTableView.dataSource = self
        
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM"
        selectedDateStr = df.string(from: selectedDate)
        selectedDateStr = (selectedDateStr.components(separatedBy: " "))[0]
        
        let df1 = DateFormatter()
        df1.dateFormat = "LLLL"
        monthString = df1.string(from: selectedDate)
        
        let df2 = DateFormatter()
        df2.dateFormat = "YYYY"
        yearString = df2.string(from: selectedDate)
        self.lbl_calendarDateSelected.text = "\(monthString) \(yearString)"
        self.lbl_tableTopDate.text = "\(monthString) \(yearString)"
                
        getdata()
        viewdate.layer.cornerRadius = 5
        viewdate.layer.borderWidth = 1
        viewdate.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5
        
        myCalendar.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        myCalendar.layer.shadowOpacity = 0.6
        myCalendar.layer.shadowOffset = .zero
        myCalendar.layer.shadowRadius = 6
        myCalendar.layer.cornerRadius = 8

        
        myCalendar.delegate = self
        myCalendar.dataSource = self
        
        myCalendar.allowsMultipleSelection = false
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func btnDateSelected() {
        if DatePickerView.isHidden == true{
            datePicker.datePickerMode = .date
            datePicker.isHidden = false
            DatePickerView.isHidden = false
        }
        else {
            datePicker.datePickerMode = .date
            DatePickerView.isHidden = true
        }
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }

    func getdata() {
        self.arr_data.removeAll()
        
        basicFunctions.presentLoader()
        
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        paraDict.setValue(selectedDateStr, forKey: "date")
        
        print(paraDict)
        
        let methodName = "get_accepted_or_own_meetup_list"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                print(message)
             if status == "1" {
                self.arr_data = DataManager.getVal(responseData?["data"]) as? [[String:Any]] ?? []
             }
             else {
                print(message)
             }
            self.MeetupsTableView.reloadData()
            basicFunctions.stopLoading()
        }
    }
}
extension AcceptedMeetUpVC : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AcceptedMeetUpCell", for: indexPath) as! AcceptedMeetUpCell
        cell.lbl_imgUser.layer.cornerRadius = cell.lbl_imgUser.frame.size.width/2
        cell.lbl_imgUser.contentMode = .scaleToFill
        
        let dict = arr_data[indexPath.row]
        
        cell.lbl_time.text = DataManager.getVal(dict["meetup_time"]) as? String ?? ""
        cell.lbl_date.text = DataManager.getVal(dict["meetup_date"]) as? String ?? ""
        cell.lbl_meetupName.text = DataManager.getVal(dict["meetup_topic"]) as? String ?? ""
        cell.lbl_location.text = DataManager.getVal(dict["meetup_location"]) as? String ?? ""
        cell.lbl_imgUser.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(dict["meetup_image"]) as? String ?? "")"), completed: nil)
        
        return cell
    }
}

extension AcceptedMeetUpVC : FSCalendarDelegate, FSCalendarDataSource {
    //MARK:- FSCalendarDelegate
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
        selectedDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        selectedDateStr = dateFormatter.string(from: selectedDate)
        selectedDateStr = (selectedDateStr.components(separatedBy: " "))[0]
    
        
        
        let df1 = DateFormatter()
        df1.dateFormat = "LLLL"
        monthString = df1.string(from: selectedDate)
        
        let df2 = DateFormatter()
        df2.dateFormat = "YYYY"
        yearString = df2.string(from: selectedDate)
        
        
        self.lbl_calendarDateSelected.text = "\(monthString) \(yearString)"
        self.lbl_tableTopDate.text = "\(monthString) \(yearString)"
        
        self.myCalendar.reloadData()
        getdata()
    }
    
//    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
//        let curDate = Date().addingTimeInterval(-24*60*60)
//        if date < curDate {
//            return false
//        } else {
//            return true
//        }
//    }
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("changed")
        selectedDate = myCalendar.currentPage
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        selectedDateStr = dateFormatter.string(from: selectedDate)
        selectedDateStr = (selectedDateStr.components(separatedBy: " "))[0]
      
        
        
        let df1 = DateFormatter()
        df1.dateFormat = "LLLL"
        monthString = df1.string(from: selectedDate)
        
        let df2 = DateFormatter()
        df2.dateFormat = "YYYY"
        yearString = df2.string(from: selectedDate)
        
        self.lbl_calendarDateSelected.text = "\(monthString) \(yearString)"
        self.lbl_tableTopDate.text = "\(monthString) \(yearString)"
        
        self.myCalendar.reloadData()
        getdata()
        
    }
}


