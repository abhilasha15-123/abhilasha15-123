//
//  SetProfilestep2VC.swift
//  DemoNew
//
//  Created by mac-9 on 02/07/21.
//

import UIKit
class SetProfilestep2cell: UICollectionViewCell{
    @IBOutlet weak var intrestview: UIView!
    @IBOutlet weak var imginterest: UIImageView!
    @IBOutlet weak var lblname: UILabel!

}
class SetProfilestep2VC: UIViewController {
    @IBOutlet weak var soulview: UIView!
    @IBOutlet weak var tribeview: UIView!
    @IBOutlet weak var minitribeview: UIView!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var btnnext: UIButton!
    @IBOutlet weak var religionview: UIView!
    @IBOutlet weak var firstview: UIView!
    @IBOutlet weak var secondview: UIView!
    @IBOutlet weak var thirdview: UIView!
    @IBOutlet weak var forthview: UIView!
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var btnimg: UIButton!
    @IBOutlet weak var btnimg2: UIButton!
    @IBOutlet weak var btnimg3: UIButton!
    @IBOutlet weak var interestcollection: UICollectionView!
    
    
    @IBOutlet weak var txt_q2: UITextView!
    @IBOutlet weak var txt_q1: UITextView!
    @IBOutlet weak var txt_q3: UITextView!
    @IBOutlet weak var txt_q4: UITextView!
    @IBOutlet weak var txt_religion: UITextField!
    @IBOutlet weak var tableview_relegion: UITableView!
    
    
    var selectedIndex = Int()
    var interestImage = ["Fitness","Music","Shopping","Aliens","Art","Sport","Fitness","Music","Shopping","Aliens"]
    var interestTxt = ["Fitness","Music","Shopping","Aliens","Art","Sport","Fitness","Music","Shopping","Aliens"]
    var arr_religions = [ "Spiritual",
                          "Catholic",
                          "Christian",
                          "Hindu",
                          "Buddhist",
                          "Muslim",
                          "Atheist",
                          "Jewish",
                          "Open",
                          "Agnostic",
                          "Other"]
    
    var arr_selectedVibes : NSMutableArray = []
    var arr_selectedInterests : NSMutableArray = []
    var selectedReligion = ""
    
    var userId = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        religionview.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(displayList))
        self.religionview.addGestureRecognizer(tap)
        
        
        tableview_relegion.dataSource = self
        tableview_relegion.delegate = self
        tableview_relegion.reloadData()
        
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5
        
        
        soulview.layer.cornerRadius = 5
        soulview.layer.borderWidth = 1
        soulview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        tribeview.layer.cornerRadius = 5
        tribeview.layer.borderWidth = 1
        tribeview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        minitribeview.layer.cornerRadius = 5
        minitribeview.layer.borderWidth = 1
        minitribeview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        btnback.layer.cornerRadius = 5
        btnback.layer.borderWidth = 1
        btnback.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        btnnext.layer.cornerRadius = 5
        btnnext.layer.borderWidth = 1
        btnnext.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        religionview.layer.cornerRadius = 5
        religionview.layer.borderWidth = 1
        religionview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        firstview.layer.cornerRadius = 5
        firstview.layer.borderWidth = 1
        firstview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        secondview.layer.cornerRadius = 5
        secondview.layer.borderWidth = 1
        secondview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        thirdview.layer.cornerRadius = 5
        thirdview.layer.borderWidth = 1
        thirdview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        forthview.layer.cornerRadius = 5
        forthview.layer.borderWidth = 1
        forthview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        txt_q4.delegate = self
        txt_q3.delegate = self
        txt_q2.delegate = self
        txt_q1.delegate = self
        
        txt_q4.text = "Write your answer here (Optional)"
        txt_q4.text = "Write your answer here (Optional)"
        txt_q4.text = "Write your answer here (Optional)"
        txt_q4.text = "Write your answer here (Optional)"
        
        txt_q4.textColor = UIColor.lightGray
        txt_q3.textColor = UIColor.lightGray
        txt_q2.textColor = UIColor.lightGray
        txt_q1.textColor = UIColor.lightGray
        
        // Do any additional setup after loading the view.
    }
    
    @objc func displayList(){
        tableview_relegion.isHidden = !tableview_relegion.isHidden
    }
    
    @IBAction func btnnext(_ sender: Any) {

        if ValidationClass().ValidateProfileSetup2Form(self){
            
            basicFunctions.presentLoader()

            let parameterDictionary = NSMutableDictionary()
            parameterDictionary.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
            parameterDictionary.setValue(Config().api_key, forKey: "api_key")
            
            parameterDictionary.setValue(arr_selectedVibes.componentsJoined(by:","), forKey: "vibe")
            parameterDictionary.setValue(arr_selectedInterests.componentsJoined(by:","), forKey: "hobbies")
            parameterDictionary.setValue(selectedReligion, forKey: "religious")
            parameterDictionary.setValue(txt_q1.textColor == UIColor.lightGray ? txt_q1.text ?? "" : "", forKey: "QA_1")
            parameterDictionary.setValue(txt_q2.textColor == UIColor.lightGray ? txt_q2.text ?? "" : "", forKey: "QA_2")
            parameterDictionary.setValue(txt_q3.textColor == UIColor.lightGray ? txt_q3.text ?? "" : "", forKey: "QA_3")
            parameterDictionary.setValue(txt_q4.textColor == UIColor.lightGray ? txt_q4.text ?? "" : "", forKey: "QA_4")
            parameterDictionary.setValue("add", forKey: "type")
            
            print(parameterDictionary)

            let methodName = "update_form_two"

            DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                let status  = DataManager.getVal(responseData?["status"]) as! String
                let message  = DataManager.getVal(responseData?["message"]) as! String

                if status == "1" {
                    self.view.makeToast(message)

                    let data = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
                    
                    let str = DataManager.getVal(data["vibe"]) as? String ?? ""
                    let arr = str.components(separatedBy: ",")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
                        
                        if arr.contains("Soul Love") || arr.contains("Tribe"){
                            let vc = self.storyboard?.instantiateViewController(identifier: "SetProfilestep3VC") as! SetProfilestep3VC
                            vc.vibe = str
                            self.navigationController?.pushViewController(vc, animated: true)
                        }else{
                            let vc = self.storyboard?.instantiateViewController(identifier: "SetProfilefinalVC") as! SetProfilefinalVC
                            vc.vibe = str
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        
                       
                    })
                }
                else {
                    self.view.makeToast(message, duration: 2.0, position: .bottom, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
                }
//                self.removeSpinner()
                basicFunctions.stopLoading()
            }
        }
    }
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }

    @IBAction func btnsoullove(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            soulview.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            soulview.layer.borderWidth = 1
            btnimg.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_selectedVibes.add("Soul Love")
        }
        else{
            soulview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            soulview.layer.borderWidth = 1
            btnimg.setImage(UIImage(named: "black circle"), for: .normal)
            arr_selectedVibes.remove("Soul Love")
        }
    }
    @IBAction func btntribe(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            tribeview.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            tribeview.layer.borderWidth = 1
            btnimg2.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_selectedVibes.add("Tribe")
        }
        
        else{
            tribeview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            tribeview.layer.borderWidth = 1
            btnimg2.setImage(UIImage(named: "black circle"), for: .normal)
            arr_selectedVibes.remove("Tribe")
        }
    }
    @IBAction func btnminitribe(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            minitribeview.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            minitribeview.layer.borderWidth = 1
            btnimg3.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_selectedVibes.add("Mini Tribes")
        }
        else{
            minitribeview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            minitribeview.layer.borderWidth = 1
            btnimg3.setImage(UIImage(named: "black circle"), for: .normal)
            arr_selectedVibes.remove("Mini Tribes")
        }
    }
    
}
extension SetProfilestep2VC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interestImage.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SetProfilestep2cell", for: indexPath) as! SetProfilestep2cell
        
        if arr_selectedInterests.contains(indexPath.row)
            {
            cell.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 0.3977995614)
            cell.layer.borderWidth = 1
            cell.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            cell.layer.cornerRadius = 8
            }
            else 
            {
                cell.backgroundColor = UIColor.white
//              cell.layer.borderWidth = 0.8
                cell.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
            }

        cell.imginterest.image = UIImage(named: interestImage[indexPath.item])
        cell.lblname.text = interestTxt[indexPath.item]
        cell.intrestview.layer.cornerRadius = 6
        cell.intrestview.layer.borderWidth = 0.6
        cell.intrestview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if arr_selectedInterests.contains(indexPath.row){
            arr_selectedInterests.remove(indexPath.row)

        }
        else{
            if arr_selectedInterests.count <= 5{
                arr_selectedInterests.add(indexPath.row)
            }else{
                self.view.makeToast("Maximum 6 interests can be selected.")
            }
        }
        
        selectedIndex = indexPath.row

        self.interestcollection.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/2.1 , height: collectionView.frame.height/7);

       }
   
}

extension SetProfilestep2VC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_religions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! DistanceFormatTableViewCell
        cell.lbl_title.text = arr_religions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedReligion = arr_religions[indexPath.row]
        self.txt_religion.text = self.selectedReligion
        
        tableView.isHidden = true
    }
    
}



extension SetProfilestep2VC : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text == "" {
            textView.text = "Write your answer here (Optional)"
            textView.textColor = UIColor.lightGray
        }
    }
}
