//
//  ValidationClass.swift
//  Samksa
//
//  Created by Mac Mini on 17/12/14.
//  Copyright (c) 2014 Fullestop. All rights reserved.
//

import UIKit

/*fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l <= r
    default:
        return !(rhs < lhs)
    }
}
*/

class ValidationClass: NSObject {
    
    let correctColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0).cgColor

//    func validateUrl (_ stringURL : NSString) -> Bool {
//        
//        let urlRegEx = "((https|http):)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
//        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[urlRegEx])
//        let urlTest = NSPredicate.withSubstitutionVariables(predicate)
//        
//        return predicate.evaluate(with: stringURL)
//    }
    
    func isBlank (_ textfield:UITextField) -> Bool {
        
        let thetext = textfield.text
        let trimmedString = thetext!.trimmingCharacters(in: CharacterSet.whitespaces)
        
        
        if trimmedString.isEmpty {
            return true
        }
        return false
    }
    
    func isBlankTextView (_ textview:UITextView) -> Bool {
           
        let thetext = textview.text
        let trimmedString = thetext!.trimmingCharacters(in: CharacterSet.whitespaces)
           
    
       
        if trimmedString.isEmpty {
               return true
        }
        
       
        else  if (thetext == ("Write your answer here (Optional)")) || (thetext == ("About Business*")) || (thetext == ("A Share something that is unique and stands out. Something that makes users want to stop swiping and explore more about you!")) || (thetext == ("Description*")) || (thetext == ("Message")) || (thetext == ("Enter Description")) || (thetext == ("Bio")) || (thetext == ("Additional Information")) || (thetext == ("Your Speciality")) || (thetext == ("Write a message...")) || (thetext == ("Post your review here")) || (thetext == ("Write a message...")) || (thetext == ("Please write a comment first.")) || (thetext == ("رسالة")) || (thetext == ("السيرة الذاتية")) || (thetext == ("معلومات إضافية")) || (thetext == ("تخصصك")) || (thetext == ("...كتابة رسالة")) || (thetext == ("قم بنشر رأيك هنا")) || (thetext == ("...كتابة رسالة")) || (thetext == ("الرجاء كتابة تعليق أولاً") || (thetext == Bundle.main.localizedString(forKey: "describeYourItem", value: nil, table: "Localizable")) || (thetext == Bundle.main.localizedString(forKey: "describeYourService", value: nil, table: "Localizable")))
        {
            return true
        }
           return false
    }
       
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    
    
    func isValidEmail(_ EmailStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = EmailStr.range(of: emailRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        return !result
    }
    
    func isValidPWD(_ PwdStr:String) -> Bool {
        
        let PwdRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{10,}"
        let range = PwdStr.range(of: PwdRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        return !result
    }
    
    func isValidPassword(_ PasswordStr:String) -> Bool {
        // least one uppercase,
        // least one digit
        // least one lowercase
        //  min 6 characters total
        let password = PasswordStr.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: password)
    }
    
    
    public func isValidUsername(name: String) ->Bool {
        // Length be 15 characters max and 3 characters minimum, can contain charcaters, digits , underscore, hyphen, dot, and first charcter will be only alphabet.
        let nameRegex = "^(?![0-9_.-])[a-zA-Z-0-9_.-]{3,15}$"
       
        //"^(?=.{3})(?=.*?[A-Za-z])[a-z0-9](?:[a-zA-Z0-9]*[a-zA-Z0-9])*([-_.][a-z0-9](?:[a-zA-Z0-9]*[a-zA-Z0-9])*)?$"
       
        let trimmedString = name.trimmingCharacters(in: .whitespaces)
        let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        let isValidateName = validateName.evaluate(with: trimmedString)
        return isValidateName
     }
    
//    func ValidationChangePasswordForm(_ changePasswordObj: ChangePasswordViewController) -> {
//        if isBlank(changePasswordObj.newpassTxt){
//            changePasswordObj.fullname.layer.borderColor = correctColor
//            changePasswordObj.emailview.layer.borderColor = correctColor
//            changePasswordObj.mobileview.layer.borderColor = correctColor
//
//            let titleTxt = "Please enter password."
//
//            changePasswordObj.view.endEditing(true)
//
//            changePasswordObj.passwordview.layer.borderColor = UIColor.red.cgColor
//            changePasswordObj.view.makeToast(titleTxt)
//            return false
//        }
//        else if changePasswordObj.PasswordTxt.text?.count ?? 0 < 7{
//            changePasswordObj.fullname.layer.borderColor = correctColor
//            changePasswordObj.emailview.layer.borderColor = correctColor
//            changePasswordObj.mobileview.layer.borderColor = correctColor
//            changePasswordObj.passwordview.layer.borderColor = correctColor
//
//            let titleTxt = "Password must contain at least 7 characters."
//
//            changePasswordObj.view.endEditing(true)
//            changePasswordObj.passwordview.layer.borderColor  = UIColor.red.cgColor
//            changePasswordObj.view.makeToast(titleTxt)
//            return false
//        }
//        else if isBlank(changePasswordObj.ConfirmPasswordTxt) {
//            changePasswordObj.fullname.layer.borderColor = correctColor
//            changePasswordObj.emailview.layer.borderColor = correctColor
//            changePasswordObj.mobileview.layer.borderColor = correctColor
//            changePasswordObj.passwordview.layer.borderColor = correctColor
//
//            let titleTxt = "Please enter confirm password."
//
//            changePasswordObj.view.endEditing(true)
//
//            changePasswordObj.confirmpasswordview.layer.borderColor  = UIColor.red.cgColor
//            changePasswordObj.view.makeToast(titleTxt)
//
//            return false
//        }
//    }

    
    func ValidateSignUpForm(_ signupVCValidateObj:SignUpViewController) -> Bool {

        if isBlank(signupVCValidateObj.fullnameTxt) {
           
            let titleTxt = "Please enter fullname."
           
            signupVCValidateObj.view.endEditing(true)
            
         
            signupVCValidateObj.fullname.layer.borderColor = UIColor.red.cgColor
            signupVCValidateObj.view.makeToast(titleTxt)

            return false
        }
        else if isBlank(signupVCValidateObj.emailTxt) {
            signupVCValidateObj.fullname.layer.borderColor = correctColor
           
            let titleTxt = "Please enter email."
            
            signupVCValidateObj.view.endEditing(true)
          
            signupVCValidateObj.emailview.layer.borderColor = UIColor.red.cgColor
            signupVCValidateObj.view.makeToast(titleTxt)
            return false
         }
        else if isValidEmail(signupVCValidateObj.emailTxt.text ?? ""){
            signupVCValidateObj.fullname.layer.borderColor = correctColor
            signupVCValidateObj.emailview.layer.borderColor = correctColor
            
            let titleTxt = "Please enter valid email id."
            
            signupVCValidateObj.view.endEditing(true)
          
            signupVCValidateObj.emailview.layer.borderColor = UIColor.red.cgColor
            signupVCValidateObj.view.makeToast(titleTxt)
            return false
        }
        
        else if isBlank(signupVCValidateObj.MobileTxt) {
            signupVCValidateObj.fullname.layer.borderColor = correctColor
            signupVCValidateObj.emailview.layer.borderColor = correctColor

            let titleTxt = "Please enter mobile number."
            
            signupVCValidateObj.view.endEditing(true)
            signupVCValidateObj.mobileview.layer.borderColor = UIColor.red.cgColor
            signupVCValidateObj.view.makeToast(titleTxt)
            return false
        }else if signupVCValidateObj.MobileTxt.text!.count > 15 || signupVCValidateObj.MobileTxt.text!.count < 7{
            signupVCValidateObj.fullname.layer.borderColor = correctColor
            signupVCValidateObj.emailview.layer.borderColor = correctColor
            signupVCValidateObj.mobileview.layer.borderColor = correctColor
            
            let titleTxt = "Mobile number must be 7 - 15 digits."
            
            signupVCValidateObj.view.endEditing(true)
            
            signupVCValidateObj.mobileview.layer.borderColor = UIColor.red.cgColor
            signupVCValidateObj.view.makeToast(titleTxt)
            return false
        }
        
        else if isBlank(signupVCValidateObj.PasswordTxt){
            signupVCValidateObj.fullname.layer.borderColor = correctColor
            signupVCValidateObj.emailview.layer.borderColor = correctColor
            signupVCValidateObj.mobileview.layer.borderColor = correctColor
            
            let titleTxt = "Please enter password."
            
            signupVCValidateObj.view.endEditing(true)
          
            signupVCValidateObj.passwordview.layer.borderColor = UIColor.red.cgColor
            signupVCValidateObj.view.makeToast(titleTxt)
            return false
        }
        else if signupVCValidateObj.PasswordTxt.text?.count ?? 0 < 7{
            signupVCValidateObj.fullname.layer.borderColor = correctColor
            signupVCValidateObj.emailview.layer.borderColor = correctColor
            signupVCValidateObj.mobileview.layer.borderColor = correctColor
            signupVCValidateObj.passwordview.layer.borderColor = correctColor

            let titleTxt = "Password must contain at least 7 characters."
            
            signupVCValidateObj.view.endEditing(true)
            signupVCValidateObj.passwordview.layer.borderColor  = UIColor.red.cgColor
            signupVCValidateObj.view.makeToast(titleTxt)
            return false
        }
        else if isBlank(signupVCValidateObj.ConfirmPasswordTxt) {
            signupVCValidateObj.fullname.layer.borderColor = correctColor
            signupVCValidateObj.emailview.layer.borderColor = correctColor
            signupVCValidateObj.mobileview.layer.borderColor = correctColor
            signupVCValidateObj.passwordview.layer.borderColor = correctColor
            
            let titleTxt = "Please enter confirm password."
                   
            signupVCValidateObj.view.endEditing(true)
         
            signupVCValidateObj.confirmpasswordview.layer.borderColor  = UIColor.red.cgColor
            signupVCValidateObj.view.makeToast(titleTxt)
            
            return false
        } else if signupVCValidateObj.PasswordTxt.text! != signupVCValidateObj.ConfirmPasswordTxt.text!{
            signupVCValidateObj.fullname.layer.borderColor = correctColor
            signupVCValidateObj.emailview.layer.borderColor = correctColor
            signupVCValidateObj.mobileview.layer.borderColor = correctColor
            signupVCValidateObj.passwordview.layer.borderColor = correctColor
            
            let titleTxt = "Password Mismatch! Please enter the same password."
              
            signupVCValidateObj.view.endEditing(true)
            signupVCValidateObj.confirmpasswordview.layer.borderColor  = UIColor.red.cgColor
            signupVCValidateObj.view.makeToast(titleTxt)
            return false
        }
        
        else{
            signupVCValidateObj.fullname.layer.borderColor = correctColor
            signupVCValidateObj.emailview.layer.borderColor = correctColor
            signupVCValidateObj.mobileview.layer.borderColor = correctColor
            signupVCValidateObj.passwordview.layer.borderColor = correctColor
            signupVCValidateObj.confirmpasswordview.layer.borderColor = correctColor

            return true
        }
    }
     
    func ValidateCreateMeetup(_ createMeetUpVCValidateObj:CreateMeetUpVC) -> Bool {
        if isBlank(createMeetUpVCValidateObj.txtMeetupTopic) {
           
            let titleTxt = "Please Select a Meetup Topic."
           
            createMeetUpVCValidateObj.view.endEditing(true)
            
         
            createMeetUpVCValidateObj.viewtopic.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            createMeetUpVCValidateObj.view.makeToast(titleTxt)

            return false
        }
        else if isBlank(createMeetUpVCValidateObj.txtdate) {
           
            let titleTxt = "Please Select a Date For Meetup."
           
            createMeetUpVCValidateObj.view.endEditing(true)
            
         
            createMeetUpVCValidateObj.viewdate.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            createMeetUpVCValidateObj.view.makeToast(titleTxt)

            return false
        }
        else if isBlank(createMeetUpVCValidateObj.txttime) {
            
            let titleTxt = "Please Select a Time for Meetup."
           
            createMeetUpVCValidateObj.view.endEditing(true)
            
         
            createMeetUpVCValidateObj.viewtime.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            createMeetUpVCValidateObj.view.makeToast(titleTxt)

            return false
        }
        else if isBlank(createMeetUpVCValidateObj.txtlocation) {
           
            let titleTxt = "Please select location of meetup."
           
            createMeetUpVCValidateObj.view.endEditing(true)
            
         
            createMeetUpVCValidateObj.viewlocation.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            createMeetUpVCValidateObj.view.makeToast(titleTxt)

            return false
        }
//        else if isBlank((createMeetUpVCValidateObj.txtviewdiscription as? UITextField?)!!) {
//            
//            let titleTxt = "Please enter description of meetup."
//           
//            createMeetUpVCValidateObj.view.endEditing(true)
//            
//         
////            createMeetUpVCValidateObj..layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
//            createMeetUpVCValidateObj.view.makeToast(titleTxt)
//
//            return false
//        }
        else{
            return true
        }
    }

    func ValidateLoginForm (_ loginVCValidateObj:LoginViewController) -> Bool {

        if isBlank(loginVCValidateObj.emailTxt) {

           let titleTxt = "Please enter the Email Id."
            
            loginVCValidateObj.view.endEditing(true)
            loginVCValidateObj.emailview.layer.borderColor = UIColor.red.cgColor
            loginVCValidateObj.view.makeToast(titleTxt)

            return false
        }

        else if isBlank(loginVCValidateObj.passwordTxt) {
            loginVCValidateObj.emailview.layer.borderColor = correctColor

            let titleTxt = "Please enter password."
            
            loginVCValidateObj.view.endEditing(true)
            loginVCValidateObj.passwordview.layer.borderColor = UIColor.red.cgColor
            loginVCValidateObj.view.makeToast(titleTxt)
            return false
        }
        
        else{
            loginVCValidateObj.emailview.layer.borderColor = correctColor
            loginVCValidateObj.passwordview.layer.borderColor = correctColor
            return true
        }
        
    }

    
    func ValidateProfileSetup1Form (_ SetprofileVCValidateObj:SetprofileVC) -> Bool {

        if SetprofileVCValidateObj.profilePicAdded == false{
            let titleTxt = "Please add your profile picture."
            
            SetprofileVCValidateObj.view.endEditing(true)
            SetprofileVCValidateObj.view.makeToast(titleTxt)

            return false
        }
        else if isBlank(SetprofileVCValidateObj.txtname) {

            let titleTxt = "Please enter your name."
            
            SetprofileVCValidateObj.view.endEditing(true)
            SetprofileVCValidateObj.txtname.layer.borderColor = UIColor.red.cgColor
            SetprofileVCValidateObj.view.makeToast(titleTxt)

            return false
        }
        
        else if SetprofileVCValidateObj.arr_assets.count == 0 && SetprofileVCValidateObj.comesFrom != "Edit"{
            SetprofileVCValidateObj.txtname.layer.borderColor = correctColor
            SetprofileVCValidateObj.viewdob.layer.borderColor = correctColor
            
            let titleTxt = "Please upload minimum 1 picture to the collection."
            
            SetprofileVCValidateObj.view.endEditing(true)
            SetprofileVCValidateObj.view.makeToast(titleTxt)

            return false
        }
        else if SetprofileVCValidateObj.arr_editAsset.count == 0 && SetprofileVCValidateObj.comesFrom == "Edit"{
            SetprofileVCValidateObj.txtname.layer.borderColor = correctColor
            SetprofileVCValidateObj.viewdob.layer.borderColor = correctColor
            
            let titleTxt = "Please upload minimum 1 picture to the collection."
            
            SetprofileVCValidateObj.view.endEditing(true)
            SetprofileVCValidateObj.view.makeToast(titleTxt)

            return false
        }
        
        else if SetprofileVCValidateObj.genderVal == "" {

            let titleTxt = "Please select your gender."
            
            SetprofileVCValidateObj.view.endEditing(true)
            SetprofileVCValidateObj.view.makeToast(titleTxt)

            return false
        }
        
        else if SetprofileVCValidateObj.selectedDate == ""{
            SetprofileVCValidateObj.txtname.layer.borderColor = correctColor
            
            let titleTxt = "Please select your Date of Birth."
            
            SetprofileVCValidateObj.view.endEditing(true)
            SetprofileVCValidateObj.viewdob.layer.borderColor = UIColor.red.cgColor
            SetprofileVCValidateObj.view.makeToast(titleTxt)

            return false
        }
       
        else{
            SetprofileVCValidateObj.txtname.layer.borderColor = correctColor
            SetprofileVCValidateObj.viewdob.layer.borderColor = correctColor
            
            return true
        }
        
    }

    
    
    func ValidateProfileSetup2Form (_ SetprofileVCValidateObj:SetProfilestep2VC) -> Bool {

        if SetprofileVCValidateObj.arr_selectedVibes.count == 0 {

            let titleTxt = "Please select the vibe."
            
            SetprofileVCValidateObj.view.endEditing(true)
            SetprofileVCValidateObj.view.makeToast(titleTxt)

            return false
        }
        
        else if SetprofileVCValidateObj.arr_selectedInterests.count == 0 {
            
            let titleTxt = "Please select your interests."
            
            SetprofileVCValidateObj.view.endEditing(true)
            SetprofileVCValidateObj.view.makeToast(titleTxt)

            return false
        }
     
        else{
           
            return true
        }
        
    }

    
    func ValidateProfileSetup3Form (_ SetprofileVCValidateObj:SetProfilestep3VC) -> Bool {

        if SetprofileVCValidateObj.arr_my_sexuality.count == 0 && SetprofileVCValidateObj.arr_vibes.contains("Soul Love"){

            let titleTxt = "Please select your sexuality."
            
            SetprofileVCValidateObj.view.endEditing(true)
            SetprofileVCValidateObj.view.makeToast(titleTxt)

            return false
        }
        
        else if SetprofileVCValidateObj.arr_my_relationshipStatus.count == 0 && SetprofileVCValidateObj.arr_vibes.contains("Soul Love"){
            
            let titleTxt = "Please select your relationship status."
            
            SetprofileVCValidateObj.view.endEditing(true)
            SetprofileVCValidateObj.view.makeToast(titleTxt)

            return false
        }
     
        else if SetprofileVCValidateObj.arr_soul_gender.count == 0 && SetprofileVCValidateObj.arr_vibes.contains("Soul Love"){
            
            let titleTxt = "Please select gender preference."
            
            SetprofileVCValidateObj.view.endEditing(true)
            SetprofileVCValidateObj.view.makeToast(titleTxt)

            return false
        }
        
        else if SetprofileVCValidateObj.arr_soul_sexuality.count == 0 && SetprofileVCValidateObj.arr_vibes.contains("Soul Love"){
            
            let titleTxt = "Please select sexuality preference."
            
            SetprofileVCValidateObj.view.endEditing(true)
            SetprofileVCValidateObj.view.makeToast(titleTxt)

            return false
        }
        
        else if SetprofileVCValidateObj.arr_soul_relationshipGoal.count == 0 && SetprofileVCValidateObj.arr_vibes.contains("Soul Love"){
            
            let titleTxt = "Please select type of relationship your are looking for."
            
            SetprofileVCValidateObj.view.endEditing(true)
            SetprofileVCValidateObj.view.makeToast(titleTxt)

            return false
        }
        
        else if SetprofileVCValidateObj.arr_tribe_gender.count == 0 && SetprofileVCValidateObj.arr_vibes.contains("Tribe"){
            
            let titleTxt = "Please select type of tribe gender preference your are looking for."
            
            SetprofileVCValidateObj.view.endEditing(true)
            SetprofileVCValidateObj.view.makeToast(titleTxt)

            return false
        }
        else if SetprofileVCValidateObj.arr_tribe_sexuality.count == 0  &&  SetprofileVCValidateObj.arr_vibes.contains("Tribe"){
            
            let titleTxt = "Please select type of tribe sexuality preference your are looking for."
            
            SetprofileVCValidateObj.view.endEditing(true)
            SetprofileVCValidateObj.view.makeToast(titleTxt)

            return false
        }
        else{
            return true
        }
    }
    
    
    func ValidateProfileSetup4Form (_ SetprofileVCValidateObj:SetProfilefinalVC) -> Bool {

        if SetprofileVCValidateObj.arr_mini_tribe_sexuality.count == 0 {

            let titleTxt = "Please select your sexuality preferences."

            SetprofileVCValidateObj.view.endEditing(true)
            SetprofileVCValidateObj.view.makeToast(titleTxt)

            return false
        }

        else if SetprofileVCValidateObj.arr_mini_tribe_relationshipStatus.count == 0 {

            let titleTxt = "Please select your relationship status prefernces."

            SetprofileVCValidateObj.view.endEditing(true)
            SetprofileVCValidateObj.view.makeToast(titleTxt)

            return false
        }
        else{
            return true
        }
        
    }
    
    
    
//    func ValidateForgotForm(_ ForgotPasswordVCValidateObj:ForgotPasswordViewController) -> Bool {
//
//        let language = DataManager.getVal(Config().AppUserDefaults.value(forKey:"language")) as? String ?? "en"
//
//        if isBlank(ForgotPasswordVCValidateObj.txt_emailAddress) {
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "الرجاء إدخال بريدك الإلكتروني المسجل."
//            }
//            else {
//                titleTxt = "Please enter your registered Email."
//            }
//            ForgotPasswordVCValidateObj.view.endEditing(true)
//            ForgotPasswordVCValidateObj.vw_lineEmail.backgroundColor = UIColor.red
//            ForgotPasswordVCValidateObj.view.makeToast(titleTxt, duration: 2.0, position: .bottom, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
//
//            return false
//        }
//        else if isValidEmail(ForgotPasswordVCValidateObj.txt_emailAddress.text ?? ""){
//            ForgotPasswordVCValidateObj.vw_lineEmail.backgroundColor = correctColor
//
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "الرجاء إدخال البريد الإلكتروني الصحيح."
//            }
//            else {
//                titleTxt = "Please enter valid email id."
//            }
//
//            ForgotPasswordVCValidateObj.view.endEditing(true)
//            ForgotPasswordVCValidateObj.vw_lineEmail.backgroundColor = UIColor.red
//            ForgotPasswordVCValidateObj.view.makeToast(titleTxt, duration: 2.0, position: .bottom, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
//
//            return false
//        }
//        else{
//            ForgotPasswordVCValidateObj.vw_lineEmail.backgroundColor = correctColor
//            return true
//        }
//    }
//

    func ValidateResetPasswordForm(_ resetPasswordVCValidateObj:ResetPasswordViewController) -> Bool {

        if isBlank(resetPasswordVCValidateObj.enternewpasaTxt) {
            let titleTxt = "Please enter new password."
        
            resetPasswordVCValidateObj.view.endEditing(true)
            resetPasswordVCValidateObj.newPassView.layer.borderColor  = UIColor.red.cgColor
            resetPasswordVCValidateObj.view.makeToast(titleTxt)
            return false
        }
        else if resetPasswordVCValidateObj.enternewpasaTxt.text?.count ?? 0 < 7 {
            resetPasswordVCValidateObj.newPassView.layer.borderColor  = correctColor

            let titleTxt = "Password must contain at least 7 characters."
            
            resetPasswordVCValidateObj.view.endEditing(true)
            resetPasswordVCValidateObj.newPassView.layer.borderColor  = UIColor.red.cgColor
            resetPasswordVCValidateObj.view.makeToast(titleTxt)
            return false
        }
        else if isBlank(resetPasswordVCValidateObj.reenterpassTxt) {
            resetPasswordVCValidateObj.newPassView.layer.borderColor  = correctColor
            
            let titleTxt = "Please enter confirm password."
            
            resetPasswordVCValidateObj.view.endEditing(true)
            resetPasswordVCValidateObj.ReNewPassView.layer.borderColor = UIColor.red.cgColor
            resetPasswordVCValidateObj.view.makeToast(titleTxt)
            return false
        }else if resetPasswordVCValidateObj.enternewpasaTxt.text! != resetPasswordVCValidateObj.reenterpassTxt.text!{

            resetPasswordVCValidateObj.newPassView.layer.borderColor = correctColor
            resetPasswordVCValidateObj.ReNewPassView.layer.borderColor = correctColor
            
            let titleTxt = "Password Mismatch! Please enter the same password in both the fields."
            
            resetPasswordVCValidateObj.view.endEditing(true)
            resetPasswordVCValidateObj.ReNewPassView.layer.borderColor = UIColor.red.cgColor
            resetPasswordVCValidateObj.view.makeToast(titleTxt)

            return false
        }
        else{
            resetPasswordVCValidateObj.newPassView.layer.borderColor = correctColor
            resetPasswordVCValidateObj.ReNewPassView.layer.borderColor = correctColor
            return true
        }
    }

//    func ValidateChangePasswordForm(_ changePasswordVCValidateObj:ChangePasswordViewController) -> Bool {
//
//        let language = DataManager.getVal(Config().AppUserDefaults.value(forKey:"language")) as? String ?? "en"
//
//        if isBlank(changePasswordVCValidateObj.txt_currentPassword) {
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "الرجاء إدخال كلمة المرور الحالية الخاصة بك."
//            }
//            else {
//                titleTxt = "Please enter your current password."
//            }
//            changePasswordVCValidateObj.view.endEditing(true)
//            changePasswordVCValidateObj.vw_currentPassword.backgroundColor = UIColor.red
//            changePasswordVCValidateObj.view.makeToast(titleTxt)
//            return false
//        }
//        else if isBlank(changePasswordVCValidateObj.txt_newPassword) {
//            changePasswordVCValidateObj.vw_currentPassword.backgroundColor = correctColor
//
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "الرجاء إدخال كلمة المرور الجديدة الخاصة بك"
//            }
//            else {
//                titleTxt = "Please enter your new password."
//            }
//            changePasswordVCValidateObj.view.endEditing(true)
//            changePasswordVCValidateObj.vw_newPassword.backgroundColor = UIColor.red
//            changePasswordVCValidateObj.view.makeToast(titleTxt)
//            return false
//        }
//        else if changePasswordVCValidateObj.txt_newPassword.text?.count ?? 0 < 7 {
//            changePasswordVCValidateObj.vw_currentPassword.backgroundColor = correctColor
//            changePasswordVCValidateObj.vw_newPassword.backgroundColor = correctColor
//
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "يجب أن تحتوي كلمة المرور على 7 أحرف على الأقل."
//            }
//            else {
//                titleTxt = "Password must contain at least 7 characters."
//            }
//            changePasswordVCValidateObj.view.endEditing(true)
//            changePasswordVCValidateObj.vw_newPassword.backgroundColor = UIColor.red
//            changePasswordVCValidateObj.view.makeToast(titleTxt)
//            return false
//        }
//        else if isBlank(changePasswordVCValidateObj.txt_confirmPassword) {
//            changePasswordVCValidateObj.vw_currentPassword.backgroundColor = correctColor
//            changePasswordVCValidateObj.vw_newPassword.backgroundColor = correctColor
//
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "الرجاء إدخال تأكيد كلمة المرور."
//            }
//            else {
//                titleTxt = "Please enter confirm password."
//            }
//            changePasswordVCValidateObj.view.endEditing(true)
//            changePasswordVCValidateObj.vw_confirmPassword.backgroundColor = UIColor.red
//            changePasswordVCValidateObj.view.makeToast(titleTxt)
//            return false
//        }else if changePasswordVCValidateObj.txt_newPassword.text! != changePasswordVCValidateObj.txt_confirmPassword.text!{
//            changePasswordVCValidateObj.vw_currentPassword.backgroundColor = correctColor
//
//
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "كلمة المرور غير متطابقة! الرجاء إدخال نفس كلمة المرور في كلا الحقلين."
//            }
//            else {
//                titleTxt = "Password Mismatch! Please enter the same password in both the fields."
//            }
//            changePasswordVCValidateObj.view.endEditing(true)
//            changePasswordVCValidateObj.vw_confirmPassword.backgroundColor = UIColor.red
//            changePasswordVCValidateObj.vw_newPassword.backgroundColor = UIColor.red
//            changePasswordVCValidateObj.view.makeToast(titleTxt)
//
//            return false
//        }
//        else{
//            changePasswordVCValidateObj.vw_currentPassword.backgroundColor = correctColor
//            changePasswordVCValidateObj.vw_newPassword.backgroundColor = correctColor
//            changePasswordVCValidateObj.vw_confirmPassword.backgroundColor = correctColor
//            return true
//        }
//    }
//
//
//    func ValidateContactUsForm(_ ContactUsVCValidateObj:ContactUsViewController) -> Bool {
//        let language = DataManager.getVal(Config().AppUserDefaults.value(forKey:"language")) as? String ?? "en"
//
//        if isBlank(ContactUsVCValidateObj.txt_fullname) {
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "من فضلك ادخل اسمك الكامل."
//            }
//            else {
//                titleTxt = "Please enter your full name."
//            }
//            ContactUsVCValidateObj.view.endEditing(true)
//            ContactUsVCValidateObj.vw_line_fullname.backgroundColor = UIColor.red
//            ContactUsVCValidateObj.view.makeToast(titleTxt)
//            return false
//        }
//       else if isBlank(ContactUsVCValidateObj.txt_email) {
//            ContactUsVCValidateObj.vw_line_fullname.backgroundColor = correctColor
//
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "رجاءا أدخل بريدك الإلكتروني."
//            }
//            else {
//                titleTxt = "Please enter your email."
//            }
//            ContactUsVCValidateObj.view.endEditing(true)
//            ContactUsVCValidateObj.vw_line_email.backgroundColor = UIColor.red
//            ContactUsVCValidateObj.view.makeToast(titleTxt)
//            return false
//        }
//       else if isValidEmail(ContactUsVCValidateObj.txt_email.text ?? ""){
//            ContactUsVCValidateObj.vw_line_fullname.backgroundColor = correctColor
//            ContactUsVCValidateObj.vw_line_email.backgroundColor = correctColor
//
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "يرجى إدخال البريد الإلكتروني الصحيح."
//            }
//            else {
//                titleTxt = "Please enter a valid email."
//            }
//            ContactUsVCValidateObj.view.endEditing(true)
//            ContactUsVCValidateObj.vw_line_email.backgroundColor = UIColor.red
//            ContactUsVCValidateObj.view.makeToast(titleTxt)
//            return false
//       }
//
//       else if isBlankTextView(ContactUsVCValidateObj.txt_message){
//            ContactUsVCValidateObj.vw_line_fullname.backgroundColor = correctColor
//            ContactUsVCValidateObj.vw_line_email.backgroundColor = correctColor
//
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "من فضلك أدخل رسالة."
//            }
//            else {
//                titleTxt = "Please enter a message."
//            }
//            ContactUsVCValidateObj.view.endEditing(true)
//            ContactUsVCValidateObj.txt_message.layer.borderColor = UIColor.red.cgColor
//            ContactUsVCValidateObj.view.makeToast(titleTxt)
//            return false
//       }
//        else{
//            ContactUsVCValidateObj.vw_line_fullname.backgroundColor = correctColor
//            ContactUsVCValidateObj.vw_line_email.backgroundColor = correctColor
//            ContactUsVCValidateObj.txt_message.layer.borderColor = correctColor.cgColor
//            return true
//        }
//    }
//
//
//    func ValidateAddServiceForm(_ editServiceVCValidateObj:EditServiceInfoViewController) -> Bool {
//        let language = DataManager.getVal(Config().AppUserDefaults.value(forKey:"language")) as? String ?? "en"
//
//        if editServiceVCValidateObj.selectedCategoryId == "" {
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "الرجاء تحديد فئة الخدمة."
//            }
//            else {
//                titleTxt = "Please select the service category."
//            }
//
//            editServiceVCValidateObj.btn_selectCategory.layer.borderColor = UIColor.red.cgColor
//
//            editServiceVCValidateObj.view.endEditing(true)
//            editServiceVCValidateObj.view.makeToast(titleTxt)
//            return false
//        }
//       else if isBlank(editServiceVCValidateObj.txt_productName) {
//            editServiceVCValidateObj.btn_selectCategory.layer.borderColor = Config().AppThemeMainColor.cgColor
//
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "الرجاء إدخال اسم الخدمة."
//            }
//            else {
//                titleTxt = "Please enter the service name."
//            }
//            editServiceVCValidateObj.view.endEditing(true)
//            editServiceVCValidateObj.txt_productName.layer.borderColor = UIColor.red.cgColor
//            editServiceVCValidateObj.view.makeToast(titleTxt)
//            return false
//        }
//
//       else if isBlank(editServiceVCValidateObj.txt_price) {
//            editServiceVCValidateObj.btn_selectCategory.layer.borderColor = Config().AppThemeMainColor.cgColor
//            editServiceVCValidateObj.txt_productName.layer.borderColor = Config().AppThemeMainColor.cgColor
//
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "الرجاء إدخال سعر للخدمة."
//            }
//            else {
//                titleTxt = "Please enter a price for the service."
//            }
//            editServiceVCValidateObj.view.endEditing(true)
//            editServiceVCValidateObj.txt_price.layer.borderColor = UIColor.red.cgColor
//            editServiceVCValidateObj.view.makeToast(titleTxt)
//            return false
//        }
//       else if isBlankTextView(editServiceVCValidateObj.txt_itemDescription) {
//            editServiceVCValidateObj.btn_selectCategory.layer.borderColor = Config().AppThemeMainColor.cgColor
//            editServiceVCValidateObj.txt_productName.layer.borderColor = Config().AppThemeMainColor.cgColor
//            editServiceVCValidateObj.txt_price.layer.borderColor = Config().AppThemeMainColor.cgColor
//
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "الرجاء إدخال وصف للخدمة."
//            }
//            else {
//                titleTxt = "Please enter a description for the service."
//            }
//            editServiceVCValidateObj.view.endEditing(true)
//            editServiceVCValidateObj.txt_itemDescription.layer.borderColor = UIColor.red.cgColor
//            editServiceVCValidateObj.view.makeToast(titleTxt)
//            return false
//        }
//        else{
//            editServiceVCValidateObj.btn_selectCategory.layer.borderColor = Config().AppThemeMainColor.cgColor
//            editServiceVCValidateObj.txt_productName.layer.borderColor = Config().AppThemeMainColor.cgColor
//            editServiceVCValidateObj.txt_price.layer.borderColor = Config().AppThemeMainColor.cgColor
//            editServiceVCValidateObj.txt_itemDescription.layer.borderColor = Config().AppThemeMainColor.cgColor
//            return true
//        }
//    }
//
//
//    func ValidateAddProductForm(_ editProductVCValidateObj:EditProductInfoViewController) -> Bool {
//        let language = DataManager.getVal(Config().AppUserDefaults.value(forKey:"language")) as? String ?? "en"
//
//        if editProductVCValidateObj.selectedCategoryId == "" {
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "الرجاء تحديد فئة المنتج."
//            }
//            else {
//                titleTxt = "Please select the product category."
//            }
//
//            editProductVCValidateObj.btn_selectCategory.layer.borderColor = UIColor.red.cgColor
//
//            editProductVCValidateObj.view.endEditing(true)
//            editProductVCValidateObj.view.makeToast(titleTxt)
//            return false
//        }
//       else if isBlank(editProductVCValidateObj.txt_productName) {
//        editProductVCValidateObj.btn_selectCategory.layer.borderColor = Config().AppThemeMainColor.cgColor
//
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "الرجاء إدخال اسم المنتج."
//            }
//            else {
//                titleTxt = "Please enter the product name."
//            }
//        editProductVCValidateObj.view.endEditing(true)
//        editProductVCValidateObj.txt_productName.layer.borderColor = UIColor.red.cgColor
//        editProductVCValidateObj.view.makeToast(titleTxt)
//            return false
//        }
//
//       else if isBlank(editProductVCValidateObj.txt_price) {
//        editProductVCValidateObj.btn_selectCategory.layer.borderColor = Config().AppThemeMainColor.cgColor
//        editProductVCValidateObj.txt_productName.layer.borderColor = Config().AppThemeMainColor.cgColor
//
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "الرجاء إدخال سعر للمنتج."
//            }
//            else {
//                titleTxt = "Please enter a price for the product."
//            }
//        editProductVCValidateObj.view.endEditing(true)
//        editProductVCValidateObj.txt_price.layer.borderColor = UIColor.red.cgColor
//        editProductVCValidateObj.view.makeToast(titleTxt)
//            return false
//        }
//       else if isBlankTextView(editProductVCValidateObj.txt_itemDescription) {
//        editProductVCValidateObj.btn_selectCategory.layer.borderColor = Config().AppThemeMainColor.cgColor
//        editProductVCValidateObj.txt_productName.layer.borderColor = Config().AppThemeMainColor.cgColor
//        editProductVCValidateObj.txt_price.layer.borderColor = Config().AppThemeMainColor.cgColor
//
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "الرجاء إدخال وصف للمنتج."
//            }
//            else {
//                titleTxt = "Please enter a description for the product."
//            }
//        editProductVCValidateObj.view.endEditing(true)
//        editProductVCValidateObj.txt_itemDescription.layer.borderColor = UIColor.red.cgColor
//        editProductVCValidateObj.view.makeToast(titleTxt)
//            return false
//        }
//       else if editProductVCValidateObj.arr_assets.count == 0 && editProductVCValidateObj.comesFrom != "edit"{
//        editProductVCValidateObj.btn_selectCategory.layer.borderColor = Config().AppThemeMainColor.cgColor
//        editProductVCValidateObj.txt_productName.layer.borderColor = Config().AppThemeMainColor.cgColor
//        editProductVCValidateObj.txt_price.layer.borderColor = Config().AppThemeMainColor.cgColor
//        editProductVCValidateObj.txt_itemDescription.layer.borderColor = Config().AppThemeMainColor.cgColor
//
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "الرجاء تحميل الصور للمنتج."
//            }
//            else {
//                titleTxt = "Please upload images for the product."
//            }
//        editProductVCValidateObj.view.endEditing(true)
//        editProductVCValidateObj.view.makeToast(titleTxt)
//            return false
//        }
//       else if editProductVCValidateObj.arr_editAsset.count == 0 && editProductVCValidateObj.comesFrom == "edit"{
//        editProductVCValidateObj.btn_selectCategory.layer.borderColor = Config().AppThemeMainColor.cgColor
//        editProductVCValidateObj.txt_productName.layer.borderColor = Config().AppThemeMainColor.cgColor
//        editProductVCValidateObj.txt_price.layer.borderColor = Config().AppThemeMainColor.cgColor
//        editProductVCValidateObj.txt_itemDescription.layer.borderColor = Config().AppThemeMainColor.cgColor
//
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "الرجاء تحميل الصور للمنتج."
//            }
//            else {
//                titleTxt = "Please upload images for the product."
//            }
//        editProductVCValidateObj.view.endEditing(true)
//        editProductVCValidateObj.view.makeToast(titleTxt)
//            return false
//        }
//
//
//       else if editProductVCValidateObj.deliveryType == "2" && isBlank(editProductVCValidateObj.txt_deliveryFee) {
//        editProductVCValidateObj.btn_selectCategory.layer.borderColor = Config().AppThemeMainColor.cgColor
//        editProductVCValidateObj.txt_productName.layer.borderColor = Config().AppThemeMainColor.cgColor
//        editProductVCValidateObj.txt_price.layer.borderColor = Config().AppThemeMainColor.cgColor
//        editProductVCValidateObj.txt_itemDescription.layer.borderColor = Config().AppThemeMainColor.cgColor
//
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "الرجاء إدخال رسوم التوصيل ، كما هو محدد في خيار رسوم التوصيل."
//            }
//            else {
//                titleTxt = "Please enter delivery fee, as you have selected with fee delivery option."
//            }
//        editProductVCValidateObj.view.endEditing(true)
//        editProductVCValidateObj.txt_price.layer.borderColor = UIColor.red.cgColor
//        editProductVCValidateObj.view.makeToast(titleTxt)
//            return false
//        }
//
//        else{
//            editProductVCValidateObj.btn_selectCategory.layer.borderColor = Config().AppThemeMainColor.cgColor
//            editProductVCValidateObj.txt_productName.layer.borderColor = Config().AppThemeMainColor.cgColor
//            editProductVCValidateObj.txt_price.layer.borderColor = Config().AppThemeMainColor.cgColor
//            editProductVCValidateObj.txt_itemDescription.layer.borderColor = Config().AppThemeMainColor.cgColor
//            editProductVCValidateObj.txt_price.layer.borderColor = Config().AppThemeMainColor.cgColor
//            return true
//        }
//    }
//
//
//    func ValidateAddRentalForm(_ editRentalVCValidateObj:editRentalInfoViewController) -> Bool {
//        let language = DataManager.getVal(Config().AppUserDefaults.value(forKey:"language")) as? String ?? "en"
//
//        if editRentalVCValidateObj.imgSelected == false {
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "الرجاء تحديد صورة لتحميلها لإعداد التأجير."
//            }
//            else {
//                titleTxt = "Please select an image to upload for rental setup."
//            }
//
//            editRentalVCValidateObj.view.endEditing(true)
//            editRentalVCValidateObj.view.makeToast(titleTxt)
//            return false
//        }
//       else if isBlank(editRentalVCValidateObj.txt_serviceName) {
//
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "الرجاء إدخال اسم الخدمة."
//            }
//            else {
//                titleTxt = "Please enter the service name."
//            }
//        editRentalVCValidateObj.view.endEditing(true)
//        editRentalVCValidateObj.txt_serviceName.layer.borderColor = UIColor.red.cgColor
//        editRentalVCValidateObj.view.makeToast(titleTxt)
//            return false
//        }
//
//       else if isBlank(editRentalVCValidateObj.txt_price) {
//
//        editRentalVCValidateObj.txt_serviceName.layer.borderColor = Config().AppThemeMainColor.cgColor
//
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "الرجاء إدخال سعر للخدمة."
//            }
//            else {
//                titleTxt = "Please enter a price for the service."
//            }
//        editRentalVCValidateObj.view.endEditing(true)
//        editRentalVCValidateObj.txt_price.layer.borderColor = UIColor.red.cgColor
//        editRentalVCValidateObj.view.makeToast(titleTxt)
//            return false
//        }
//       else if isBlankTextView(editRentalVCValidateObj.txt_description) {
//        editRentalVCValidateObj.txt_serviceName.layer.borderColor = Config().AppThemeMainColor.cgColor
//        editRentalVCValidateObj.txt_price.layer.borderColor = Config().AppThemeMainColor.cgColor
//
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "الرجاء إدخال وصف للخدمة."
//            }
//            else {
//                titleTxt = "Please enter a description for the service."
//            }
//        editRentalVCValidateObj.view.endEditing(true)
//        editRentalVCValidateObj.txt_description.layer.borderColor = UIColor.red.cgColor
//        editRentalVCValidateObj.view.makeToast(titleTxt)
//            return false
//        }
//       else if editRentalVCValidateObj.arr_addedProducts.count == 0 {
//        editRentalVCValidateObj.txt_serviceName.layer.borderColor = Config().AppThemeMainColor.cgColor
//        editRentalVCValidateObj.txt_price.layer.borderColor = Config().AppThemeMainColor.cgColor
//        editRentalVCValidateObj.txt_description.layer.borderColor = Config().AppThemeMainColor.cgColor
//
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "الرجاء تحديد الحد الأدنى 1 الملحق من القائمة."
//            }
//            else {
//                titleTxt = "Please select minimum 1 addon from the list."
//            }
//        editRentalVCValidateObj.view.endEditing(true)
//        editRentalVCValidateObj.view.makeToast(titleTxt)
//            return false
//        }
//        else{
//            editRentalVCValidateObj.txt_serviceName.layer.borderColor = Config().AppThemeMainColor.cgColor
//            editRentalVCValidateObj.txt_price.layer.borderColor = Config().AppThemeMainColor.cgColor
//            editRentalVCValidateObj.txt_description.layer.borderColor = Config().AppThemeMainColor.cgColor
//            return true
//        }
//    }
    
//    
//    func ValidateEditProfileForm(_ editProfileVCValidateObj:EditProfileViewController) -> Bool {
//        let language = DataManager.getVal(Config().AppUserDefaults.value(forKey:"language")) as? String ?? "en"
//        
//        if editProfileVCValidateObj.imgSelected == false{
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "الرجاء تحديد صورة للحساب."
//            }
//            else {
//                titleTxt = "Please select an image for the account."
//            }
//            
//            editProfileVCValidateObj.view.endEditing(true)
//            editProfileVCValidateObj.view.makeToast(titleTxt)
//
//            return false
//        }
//        else if isBlank(editProfileVCValidateObj.txt_fullname) {
//            var titleTxt = ""
//            if language == "ar" {
//                titleTxt =  "من فضلك ادخل اسمك الكامل."
//            }
//            else {
//                titleTxt = "Please enter your full name."
//            }
//            editProfileVCValidateObj.view.endEditing(true)
//            editProfileVCValidateObj.vw_lineFullName.backgroundColor = UIColor.red
//            editProfileVCValidateObj.view.makeToast(titleTxt)
//            return false
//        }
//        else {
//            editProfileVCValidateObj.vw_lineFullName.backgroundColor = correctColor
//            return true
//        }
//    }
    
//    func ValidateAddBusinessProfileForm(_ addBusinessVCValidateObj:AddBusinessViewController) -> Bool {
//        if isBlank(addBusinessVCValidateObj.txt_firstName) {
//          
//            addBusinessVCValidateObj.view.endEditing(true)
//            addBusinessVCValidateObj.view.frame.origin.y = 0
//            addBusinessVCValidateObj.txt_firstName.layer.borderColor = UIColor.red.cgColor
//            addBusinessVCValidateObj.txt_firstName.layer.borderWidth = 2
//            addBusinessVCValidateObj.view.makeToast("Please enter first name.")
//
//           // signupVCValidateObj.txt_firstName.becomeFirstResponder()
//            return false
//        }
//        else if isBlank(addBusinessVCValidateObj.txt_lastName) {
//            addBusinessVCValidateObj.txt_firstName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//          
//            addBusinessVCValidateObj.view.endEditing(true)
//            addBusinessVCValidateObj.view.frame.origin.y = 0
//            addBusinessVCValidateObj.txt_lastName.layer.borderColor = UIColor.red.cgColor
//            addBusinessVCValidateObj.txt_lastName.layer.borderWidth = 2
//            addBusinessVCValidateObj.view.makeToast("Please enter last name.")
//            return false
//        }
//        
//        else if isBlank(addBusinessVCValidateObj.txt_businessName) {
//            addBusinessVCValidateObj.txt_firstName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_lastName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            
//            addBusinessVCValidateObj.view.endEditing(true)
//            addBusinessVCValidateObj.view.frame.origin.y = 0
//            addBusinessVCValidateObj.txt_businessName.layer.borderColor = UIColor.red.cgColor
//            addBusinessVCValidateObj.txt_businessName.layer.borderWidth = 2
//            addBusinessVCValidateObj.view.makeToast("Please enter Business name.")
//            return false
//        }
//        
//        else if isBlank(addBusinessVCValidateObj.txt_displayName) {
//            addBusinessVCValidateObj.txt_firstName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_lastName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_businessName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            
//            addBusinessVCValidateObj.view.endEditing(true)
//            addBusinessVCValidateObj.view.frame.origin.y = 0
//            addBusinessVCValidateObj.txt_displayName.layer.borderColor = UIColor.red.cgColor
//            addBusinessVCValidateObj.txt_displayName.layer.borderWidth = 2
//            addBusinessVCValidateObj.view.makeToast("Please enter your business display name.")
//            return false
//        }
//        
//        else if isBlank(addBusinessVCValidateObj.txt_tin) {
//            addBusinessVCValidateObj.txt_firstName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_lastName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_businessName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_displayName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            
//            addBusinessVCValidateObj.view.endEditing(true)
//            addBusinessVCValidateObj.view.frame.origin.y = 0
//            addBusinessVCValidateObj.txt_tin.layer.borderColor = UIColor.red.cgColor
//            addBusinessVCValidateObj.txt_tin.layer.borderWidth = 2
//            addBusinessVCValidateObj.view.makeToast("Please enter your business tax number.")
//            return false
//        }
//        
//        else if isBlankTextView(addBusinessVCValidateObj.txt_aboutBusiness){
//            addBusinessVCValidateObj.txt_firstName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_lastName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_businessName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_displayName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_tin.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            
//            addBusinessVCValidateObj.view.endEditing(true)
//            addBusinessVCValidateObj.view.frame.origin.y = 0
//            addBusinessVCValidateObj.txt_aboutBusiness.layer.borderColor = UIColor.red.cgColor
//            addBusinessVCValidateObj.txt_aboutBusiness.layer.borderWidth = 2
//            addBusinessVCValidateObj.view.makeToast("Please enter about your business.")
//            return false
//        }
//        else if addBusinessVCValidateObj.selectedLicense == nil{
//            addBusinessVCValidateObj.txt_firstName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_lastName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_businessName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_displayName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_aboutBusiness.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_tin.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            
//            
//            addBusinessVCValidateObj.view.endEditing(true)
//            addBusinessVCValidateObj.view.frame.origin.y = 0
//            addBusinessVCValidateObj.txt_businessLicense.layer.borderColor = UIColor.red.cgColor
//            addBusinessVCValidateObj.txt_businessLicense.layer.borderWidth = 2
//            addBusinessVCValidateObj.view.makeToast("Please select your shop/business license.")
//            return false
//        }
//        else if addBusinessVCValidateObj.selectedId == nil{
//            addBusinessVCValidateObj.txt_firstName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_lastName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_businessName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_displayName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_businessLicense.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_tin.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            
//            addBusinessVCValidateObj.view.endEditing(true)
//            addBusinessVCValidateObj.view.frame.origin.y = 0
//            addBusinessVCValidateObj.txt_idProof.layer.borderColor = UIColor.red.cgColor
//            addBusinessVCValidateObj.txt_idProof.layer.borderWidth = 2
//            addBusinessVCValidateObj.view.makeToast("Please select your id proof.")
//            return false
//        }
//        else if addBusinessVCValidateObj.selectedCategoryName == ""{
//            addBusinessVCValidateObj.txt_firstName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_lastName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_businessName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_displayName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_businessLicense.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_idProof.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_tin.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            
//            addBusinessVCValidateObj.view.endEditing(true)
//            addBusinessVCValidateObj.view.frame.origin.y = 0
//            addBusinessVCValidateObj.txt_category.layer.borderColor = UIColor.red.cgColor
//            addBusinessVCValidateObj.txt_category.layer.borderWidth = 2
//            addBusinessVCValidateObj.view.makeToast("Please select category.")
//            return false
//        }
//        else if addBusinessVCValidateObj.selectedCountry == ""{
//            addBusinessVCValidateObj.txt_firstName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_lastName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_businessName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_displayName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_businessLicense.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_idProof.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_category.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_tin.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            
//            addBusinessVCValidateObj.view.endEditing(true)
//            addBusinessVCValidateObj.view.frame.origin.y = 0
//            addBusinessVCValidateObj.txt_country.layer.borderColor = UIColor.red.cgColor
//            addBusinessVCValidateObj.txt_country.layer.borderWidth = 2
//            addBusinessVCValidateObj.view.makeToast("Please select country.")
//            return false
//        }
//        
//        else if (isBlank(addBusinessVCValidateObj.txt_website) == false) && (verifyUrl(urlString: addBusinessVCValidateObj.txt_website.text) == false){
//            
//            addBusinessVCValidateObj.txt_firstName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_lastName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_businessName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_displayName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_businessLicense.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_idProof.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_category.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_country.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_tin.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            
//            addBusinessVCValidateObj.view.endEditing(true)
//            addBusinessVCValidateObj.view.frame.origin.y = 0
//            addBusinessVCValidateObj.txt_website.layer.borderColor = UIColor.red.cgColor
//            addBusinessVCValidateObj.txt_website.layer.borderWidth = 2
//            addBusinessVCValidateObj.view.makeToast("Please enter a valid url (like- https://www.google.com/) for your website.")
//            return false
//        }
//        
//        else if (isBlank(addBusinessVCValidateObj.txt_socialMedia) == false) && (verifyUrl(urlString: addBusinessVCValidateObj.txt_socialMedia.text) == false){
//            
//            addBusinessVCValidateObj.txt_firstName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_lastName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_businessName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_displayName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_businessLicense.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_idProof.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_category.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_country.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_website.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_tin.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            
//            addBusinessVCValidateObj.view.endEditing(true)
//            addBusinessVCValidateObj.view.frame.origin.y = 0
//            addBusinessVCValidateObj.txt_socialMedia.layer.borderColor = UIColor.red.cgColor
//            addBusinessVCValidateObj.txt_socialMedia.layer.borderWidth = 2
//            addBusinessVCValidateObj.view.makeToast("Please enter a valid url (like- https://www.google.com/) for your social media account.")
//            return false
//        }
//        else{
//            addBusinessVCValidateObj.txt_firstName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_lastName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_businessName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_displayName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_businessLicense.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_idProof.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_category.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_country.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_website.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_socialMedia.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addBusinessVCValidateObj.txt_tin.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            return true
//        }
//    }
//
//    
//    func ValidateUpdateBusinessProfileForm(_ updateBusinessVCValidateObj:BusinessProfileViewController) -> Bool {
//         if isBlank(updateBusinessVCValidateObj.txt_displayName) {
//         
//            updateBusinessVCValidateObj.view.endEditing(true)
//            updateBusinessVCValidateObj.view.frame.origin.y = 0
//            updateBusinessVCValidateObj.txt_displayName.layer.borderColor = UIColor.red.cgColor
//            updateBusinessVCValidateObj.txt_displayName.layer.borderWidth = 2
//            updateBusinessVCValidateObj.view.makeToast("Please enter your business display name.")
//            return false
//        }
//         else if isBlank(updateBusinessVCValidateObj.txt_tin) {
//             
//             updateBusinessVCValidateObj.txt_displayName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//             
//             updateBusinessVCValidateObj.view.endEditing(true)
//             updateBusinessVCValidateObj.view.frame.origin.y = 0
//             updateBusinessVCValidateObj.txt_tin.layer.borderColor = UIColor.red.cgColor
//             updateBusinessVCValidateObj.txt_tin.layer.borderWidth = 2
//             updateBusinessVCValidateObj.view.makeToast("Please enter your business tax number.")
//             return false
//         }
//        else if updateBusinessVCValidateObj.selectedCategoryId == "" {
//            
//            updateBusinessVCValidateObj.txt_displayName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_tin.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//                
//                
//            updateBusinessVCValidateObj.view.endEditing(true)
//            updateBusinessVCValidateObj.view.frame.origin.y = 0
//            updateBusinessVCValidateObj.txt_category.layer.borderColor = UIColor.red.cgColor
//            updateBusinessVCValidateObj.txt_category.layer.borderWidth = 2
//            updateBusinessVCValidateObj.view.makeToast("Please select category.")
//            return false
//        }
//        else if updateBusinessVCValidateObj.selectedCountryId == ""{
//            updateBusinessVCValidateObj.txt_displayName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_category.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_tin.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            
//            updateBusinessVCValidateObj.view.endEditing(true)
//            updateBusinessVCValidateObj.view.frame.origin.y = 0
//            updateBusinessVCValidateObj.txt_country.layer.borderColor = UIColor.red.cgColor
//            updateBusinessVCValidateObj.txt_country.layer.borderWidth = 2
//            updateBusinessVCValidateObj.view.makeToast("Please select country.")
//            return false
//        }
//        else if updateBusinessVCValidateObj.selectedStateId == ""{
//            updateBusinessVCValidateObj.txt_displayName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_category.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_country.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_tin.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            
//            updateBusinessVCValidateObj.view.endEditing(true)
//            updateBusinessVCValidateObj.view.frame.origin.y = 0
//            updateBusinessVCValidateObj.txt_staet.layer.borderColor = UIColor.red.cgColor
//            updateBusinessVCValidateObj.txt_staet.layer.borderWidth = 2
//            updateBusinessVCValidateObj.view.makeToast("Please select state.")
//            return false
//        }
//        else if updateBusinessVCValidateObj.selectedCityId == ""{
//            updateBusinessVCValidateObj.txt_displayName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_category.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_country.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_staet.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_tin.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            
//            updateBusinessVCValidateObj.view.endEditing(true)
//            updateBusinessVCValidateObj.view.frame.origin.y = 0
//            updateBusinessVCValidateObj.txt_city.layer.borderColor = UIColor.red.cgColor
//            updateBusinessVCValidateObj.txt_city.layer.borderWidth = 2
//            updateBusinessVCValidateObj.view.makeToast("Please select city.")
//            return false
//        }
//        else if isBlank(updateBusinessVCValidateObj.txt_zipcode){
//            updateBusinessVCValidateObj.txt_displayName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_category.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_country.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_staet.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_city.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_tin.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            
//            updateBusinessVCValidateObj.view.endEditing(true)
//            updateBusinessVCValidateObj.view.frame.origin.y = 0
//            updateBusinessVCValidateObj.txt_zipcode.layer.borderColor = UIColor.red.cgColor
//            updateBusinessVCValidateObj.txt_zipcode.layer.borderWidth = 2
//            updateBusinessVCValidateObj.view.makeToast("Please enter zipcode.")
//            return false
//        }
//        else if (isBlank(updateBusinessVCValidateObj.txt_website) == false) && (verifyUrl(urlString: updateBusinessVCValidateObj.txt_website.text) == false){
//            
//            updateBusinessVCValidateObj.txt_displayName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_category.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_country.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_staet.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_city.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_zipcode.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_tin.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            
//            updateBusinessVCValidateObj.view.endEditing(true)
//            updateBusinessVCValidateObj.view.frame.origin.y = 0
//            updateBusinessVCValidateObj.txt_website.layer.borderColor = UIColor.red.cgColor
//            updateBusinessVCValidateObj.txt_website.layer.borderWidth = 2
//            updateBusinessVCValidateObj.view.makeToast("Please enter a valid url (like- https://www.google.com/) for your website.")
//            return false
//        }
//        
//        else if (isBlank(updateBusinessVCValidateObj.txtsocialMedia) == false) && (verifyUrl(urlString: updateBusinessVCValidateObj.txtsocialMedia.text) == false){
//            
//            updateBusinessVCValidateObj.txt_displayName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_category.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_country.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_staet.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_city.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_zipcode.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_website.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_tin.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            
//            updateBusinessVCValidateObj.view.endEditing(true)
//            updateBusinessVCValidateObj.view.frame.origin.y = 0
//            updateBusinessVCValidateObj.txtsocialMedia.layer.borderColor = UIColor.red.cgColor
//            updateBusinessVCValidateObj.txtsocialMedia.layer.borderWidth = 2
//            updateBusinessVCValidateObj.view.makeToast("Please enter a valid url (like- https://www.google.com/) for your social media account.")
//            return false
//        }
//        else{
//            updateBusinessVCValidateObj.txt_displayName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_category.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_country.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_staet.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_city.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_zipcode.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_website.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            updateBusinessVCValidateObj.txt_tin.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            return true
//        }
//    }
//    
//    
//    func ValidateAddContactsUpForm(_ addContactVCValidateObj:AddContactsViewController) -> Bool {
//        if isBlank(addContactVCValidateObj.txt_name) {
//          
//            addContactVCValidateObj.view.endEditing(true)
////            addContactVCValidateObj.view.frame.origin.y = 0
//            addContactVCValidateObj.txt_name.layer.borderColor = UIColor.red.cgColor
//            addContactVCValidateObj.txt_name.layer.borderWidth = 2
//            
//            addContactVCValidateObj.view.makeToast("Please enter your name.", duration: 2.0, position: .bottom, title: "", image: nil, style: ToastManager.shared.style, completion: nil)
//            
//           // signupVCValidateObj.txt_firstName.becomeFirstResponder()
//            return false
//        }
//       else if isBlank(addContactVCValidateObj.txt_email) {
//            addContactVCValidateObj.txt_name.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            
//            addContactVCValidateObj.view.endEditing(true)
////            addContactVCValidateObj.view.frame.origin.y = 0
//            addContactVCValidateObj.txt_email.layer.borderColor = UIColor.red.cgColor
//            addContactVCValidateObj.txt_email.layer.borderWidth = 2
//           
//        addContactVCValidateObj.view.makeToast("Please enter your email id.", duration: 2.0, position: .bottom, title: "", image: nil, style: ToastManager.shared.style, completion: nil)
//            return false
//        }
//       else if isValidEmail(addContactVCValidateObj.txt_email.text ?? ""){
//            addContactVCValidateObj.txt_name.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addContactVCValidateObj.txt_email.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            
//            addContactVCValidateObj.view.endEditing(true)
////            addContactVCValidateObj.view.frame.origin.y = 0
//            addContactVCValidateObj.txt_email.layer.borderColor = UIColor.red.cgColor
//            addContactVCValidateObj.txt_email.layer.borderWidth = 2
//        addContactVCValidateObj.view.makeToast("Please enter your valid email Id.", duration: 2.0, position: .bottom, title: "", image: nil, style: ToastManager.shared.style, completion: nil)
//           return false
//       }
//       else if isBlank(addContactVCValidateObj.txt_phoneNumber) == false && isBlank(addContactVCValidateObj.txt_countryCode) == true {
//            addContactVCValidateObj.txt_name.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addContactVCValidateObj.txt_email.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//
//            addContactVCValidateObj.view.endEditing(true)
////            addContactVCValidateObj.view.frame.origin.y = 0
//            addContactVCValidateObj.txt_countryCode.layer.borderColor = UIColor.red.cgColor
//            addContactVCValidateObj.txt_countryCode.layer.borderWidth = 2
//        addContactVCValidateObj.view.makeToast("Please select your country code.", duration: 2.0, position: .bottom, title: "", image: nil, style: ToastManager.shared.style, completion: nil)
//            return false
//        }
//       else if isBlank(addContactVCValidateObj.txt_countryCode) == false && isBlank(addContactVCValidateObj.txt_phoneNumber) == true{
//            addContactVCValidateObj.txt_name.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addContactVCValidateObj.txt_email.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addContactVCValidateObj.txt_countryCode.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//
//            addContactVCValidateObj.view.endEditing(true)
////            addContactVCValidateObj.view.frame.origin.y = 0
//            addContactVCValidateObj.txt_phoneNumber.layer.borderColor = UIColor.red.cgColor
//            addContactVCValidateObj.txt_phoneNumber.layer.borderWidth = 2
//
//            addContactVCValidateObj.view.makeToast("Please enter your phone number.", duration: 2.0, position: .bottom, title: "", image: nil, style: ToastManager.shared.style, completion: nil)
//            return false
//        }
//       else if isBlank(addContactVCValidateObj.txt_phoneNumber) == false && (addContactVCValidateObj.txt_phoneNumber.text!.count > 15 || addContactVCValidateObj.txt_phoneNumber.text!.count < 7){
//       
//            addContactVCValidateObj.txt_name.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addContactVCValidateObj.txt_email.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addContactVCValidateObj.txt_countryCode.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addContactVCValidateObj.txt_phoneNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//        
//        
//            addContactVCValidateObj.view.endEditing(true)
////            signupVCValidateObj.view.frame.origin.y = 0
//            addContactVCValidateObj.txt_phoneNumber.layer.borderColor = UIColor.red.cgColor
//            addContactVCValidateObj.txt_phoneNumber.layer.borderWidth = 2
//        addContactVCValidateObj.view.makeToast("Phone number must be 7 - 15 digits.", duration: 2.0, position: .bottom, title: "", image: nil, style: ToastManager.shared.style, completion: nil)
//            return false
//        }
//        
//        else{
//            addContactVCValidateObj.txt_name.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addContactVCValidateObj.txt_email.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addContactVCValidateObj.txt_countryCode.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            addContactVCValidateObj.txt_phoneNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//
//            return true
//        }
//    }
//    
//    
//    
 
    
//    
//    
////    func ValidateSubscriptionPayment(_ paymentVCValidateObj:SubscriptionPaymentViewController) -> Bool {
////      
////        if isBlank(paymentVCValidateObj.txt_cardNumber) {
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter your card number."
////            }
////            paymentVCValidateObj.txt_cardNumber.layer.borderWidth = 2
////            paymentVCValidateObj.txt_cardNumber.layer.borderColor = UIColor.red.cgColor
////            paymentVCValidateObj.view.makeToast(titleTxt)
////            paymentVCValidateObj.view.endEditing(true)
////            paymentVCValidateObj.txt_cardNumber.becomeFirstResponder()
////            return false
////        } else if paymentVCValidateObj.txt_cardNumber.text?.count ?? 0 < 16 {
////            paymentVCValidateObj.txt_cardNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter correct card number."
////            }
////            paymentVCValidateObj.txt_cardNumber.layer.borderWidth = 2
////            paymentVCValidateObj.txt_cardNumber.layer.borderColor = UIColor.red.cgColor
////            paymentVCValidateObj.view.makeToast(titleTxt)
////            paymentVCValidateObj.view.endEditing(true)
////            paymentVCValidateObj.txt_cardNumber.becomeFirstResponder()
////            return false
////        }
////        
////        else if isBlank(paymentVCValidateObj.txt_expiry) {
////            paymentVCValidateObj.txt_cardNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter card expiry date."
////            }
////            paymentVCValidateObj.txt_expiry.layer.borderWidth = 2
////            paymentVCValidateObj.txt_expiry.layer.borderColor = UIColor.red.cgColor
////            paymentVCValidateObj.view.makeToast(titleTxt)
////            paymentVCValidateObj.view.endEditing(true)
////            paymentVCValidateObj.txt_expiry.becomeFirstResponder()
////            return false
////        }else if paymentVCValidateObj.isValidExpiryDate == false {
////            paymentVCValidateObj.txt_cardNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            paymentVCValidateObj.txt_expiry.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter a correct card expiry date."
////            }
////            paymentVCValidateObj.txt_expiry.layer.borderWidth = 2
////            paymentVCValidateObj.txt_expiry.layer.borderColor = UIColor.red.cgColor
////            paymentVCValidateObj.view.makeToast(titleTxt)
////            paymentVCValidateObj.view.endEditing(true)
////            paymentVCValidateObj.txt_expiry.becomeFirstResponder()
////            return false
////        }
////        else if isBlank(paymentVCValidateObj.txt_cvv) {
////            paymentVCValidateObj.txt_cardNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            paymentVCValidateObj.txt_expiry.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter card cvv number."
////            }
////            paymentVCValidateObj.txt_cvv.layer.borderWidth = 2
////            paymentVCValidateObj.txt_cvv.layer.borderColor = UIColor.red.cgColor
////            paymentVCValidateObj.view.makeToast(titleTxt)
////            paymentVCValidateObj.view.endEditing(true)
////            paymentVCValidateObj.txt_cvv.becomeFirstResponder()
////            return false
////        }
////        else if paymentVCValidateObj.txt_cvv.text?.count ?? 0 < 3 {
////            paymentVCValidateObj.txt_cardNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            paymentVCValidateObj.txt_expiry.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter a valid cvv number."
////            }
////            paymentVCValidateObj.txt_cvv.layer.borderWidth = 2
////            paymentVCValidateObj.txt_cvv.layer.borderColor = UIColor.red.cgColor
////            paymentVCValidateObj.view.makeToast(titleTxt)
////            paymentVCValidateObj.view.endEditing(true)
////            paymentVCValidateObj.txt_cvv.becomeFirstResponder()
////            return false
////        }
////        else if paymentVCValidateObj.txt_cvv.text?.count ?? 0 < 3 {
////            paymentVCValidateObj.txt_cardNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            paymentVCValidateObj.txt_expiry.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            paymentVCValidateObj.txt_cvv.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter correct card cvv number."
////            }
////            paymentVCValidateObj.txt_cvv.layer.borderWidth = 2
////            paymentVCValidateObj.txt_cvv.layer.borderColor = UIColor.red.cgColor
////            paymentVCValidateObj.view.makeToast(titleTxt)
////            paymentVCValidateObj.view.endEditing(true)
////            paymentVCValidateObj.txt_cvv.becomeFirstResponder()
////            return false
////        }
////        else{
////            paymentVCValidateObj.txt_cardNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            paymentVCValidateObj.txt_expiry.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            paymentVCValidateObj.txt_cvv.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            
////            return true
////        }
////    }
////    
////    
////    func ValidateProfileUpdateForm(_ profileVCValidateObj:profileEditViewController) -> Bool {
////      
////        if isBlank(profileVCValidateObj.txt_name) {
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter your comapny name."
////            }
////            profileVCValidateObj.txt_name.layer.borderColor = UIColor.red.cgColor
////            profileVCValidateObj.view.makeToast(titleTxt)
////            profileVCValidateObj.view.endEditing(true)
////            profileVCValidateObj.txt_name.becomeFirstResponder()
////            return false
////        }else if isBlank(profileVCValidateObj.txt_contact) {
////            profileVCValidateObj.txt_name.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter your phone number."
////            }
////            profileVCValidateObj.txt_contact.layer.borderColor = UIColor.red.cgColor
////            profileVCValidateObj.view.makeToast(titleTxt)
////            profileVCValidateObj.view.endEditing(true)
////            profileVCValidateObj.txt_contact.becomeFirstResponder()
////            return false
////        }else if profileVCValidateObj.txt_contact.text!.count > 15 || profileVCValidateObj.txt_contact.text!.count < 7{
////            profileVCValidateObj.txt_name.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            profileVCValidateObj.txt_contact.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  "يجب أن يتراوح رقم الهاتف من 7 إلى 15 حرفًا."
////            }
////            else {
////                titleTxt = "Phone number must be 7 - 15 digits."
////            }
////            profileVCValidateObj.txt_contact.layer.borderColor = UIColor.red.cgColor
////            profileVCValidateObj.view.makeToast(titleTxt)
////            profileVCValidateObj.view.endEditing(true)
////            profileVCValidateObj.txt_contact.becomeFirstResponder()
////            return false
////        } else if profileVCValidateObj.selectedCountryName == ""{
////            profileVCValidateObj.txt_name.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            profileVCValidateObj.txt_contact.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////           
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  "البريد الإلكتروني غير صحيح"
////            }
////            else {
////                titleTxt = "Please select your country."
////            }
////            profileVCValidateObj.txt_country.layer.borderColor = UIColor.red.cgColor
////            profileVCValidateObj.view.makeToast(titleTxt)
////            profileVCValidateObj.view.endEditing(true)
////            return false
////        }else if profileVCValidateObj.arr_selectedCountriesList.count == 0{
////            profileVCValidateObj.txt_name.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            profileVCValidateObj.txt_contact.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            profileVCValidateObj.txt_country.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////             
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  "البريد الإلكتروني غير صحيح"
////            }
////            else {
////                titleTxt = "Please select the countries that you will serve."
////            }
////            profileVCValidateObj.view.makeToast(titleTxt)
////            profileVCValidateObj.view.endEditing(true)
////            return false
////        }
////        else if isBlank(profileVCValidateObj.txt_email) == false && isValidEmail(profileVCValidateObj.txt_email.text!){
////            profileVCValidateObj.txt_name.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            profileVCValidateObj.txt_contact.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            profileVCValidateObj.txt_country.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  "البريد الإلكتروني غير صحيح"
////            }
////            else {
////                titleTxt = "Please enter a valid email."
////            }
////            profileVCValidateObj.txt_email.layer.borderColor = UIColor.red.cgColor
////            profileVCValidateObj.view.makeToast(titleTxt)
////            profileVCValidateObj.view.endEditing(true)
////            profileVCValidateObj.txt_email.becomeFirstResponder()
////            return false
////        }
////        else if isBlank(profileVCValidateObj.txt_email) == false && (profileVCValidateObj.txt_email.text!.count > 50 || profileVCValidateObj.txt_email.text!.count < 10){
////            
////            profileVCValidateObj.txt_email.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            profileVCValidateObj.txt_name.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            profileVCValidateObj.txt_contact.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            profileVCValidateObj.txt_country.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Email Address length must be 10 to 50 characters long."
////            }
////            profileVCValidateObj.txt_email.layer.borderColor = UIColor.red.cgColor
////            profileVCValidateObj.view.makeToast(titleTxt)
////            profileVCValidateObj.view.endEditing(true)
////            profileVCValidateObj.txt_email.becomeFirstResponder()
////            return false
////        }
////        else if profileVCValidateObj.isLicenseUploaded == false {
////            profileVCValidateObj.txt_email.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            profileVCValidateObj.txt_name.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            profileVCValidateObj.txt_contact.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            profileVCValidateObj.txt_country.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  "الرجاء قبول الشروط والأحكام"
////            }
////            else {
////                titleTxt = "Please upload a valid trade license."
////            }
////            profileVCValidateObj.view.makeToast(titleTxt)
////            profileVCValidateObj.view.endEditing(true)
////            return false
////        }
////        else{
////            profileVCValidateObj.txt_email.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            profileVCValidateObj.txt_name.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            profileVCValidateObj.txt_contact.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            profileVCValidateObj.txt_country.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            
////            return true
////        }
////    }
////    
////    
////    func ValidateContactUsForm(_ contactUsVCValidateObj:ContactUsViewController) -> Bool {
////      
////        if isBlank(contactUsVCValidateObj.txt_name) {
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter your name."
////            }
////            contactUsVCValidateObj.txt_name.layer.borderWidth = 1
////            contactUsVCValidateObj.txt_name.layer.borderColor = UIColor.red.cgColor
////            contactUsVCValidateObj.view.makeToast(titleTxt)
////            contactUsVCValidateObj.view.endEditing(true)
////            contactUsVCValidateObj.txt_name.becomeFirstResponder()
////            return false
////        }else if isBlank(contactUsVCValidateObj.txt_email) {
////            contactUsVCValidateObj.txt_name.layer.borderWidth = 0
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter your email."
////            }
////            contactUsVCValidateObj.txt_email.layer.borderWidth = 1
////            contactUsVCValidateObj.txt_email.layer.borderColor = UIColor.red.cgColor
////            contactUsVCValidateObj.view.makeToast(titleTxt)
////            contactUsVCValidateObj.view.endEditing(true)
////            contactUsVCValidateObj.txt_email.becomeFirstResponder()
////            return false
////        } else if isValidEmail(contactUsVCValidateObj.txt_email.text!){
////            contactUsVCValidateObj.txt_name.layer.borderWidth = 0
////            contactUsVCValidateObj.txt_email.layer.borderWidth = 0
////            
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  "البريد الإلكتروني غير صحيح"
////            }
////            else {
////                titleTxt = "Please enter a valid email."
////            }
////            contactUsVCValidateObj.txt_email.layer.borderWidth = 1
////            contactUsVCValidateObj.txt_email.layer.borderColor = UIColor.red.cgColor
////            contactUsVCValidateObj.view.makeToast(titleTxt)
////            contactUsVCValidateObj.view.endEditing(true)
////            contactUsVCValidateObj.txt_email.becomeFirstResponder()
////            return false
////        } else if isBlankTextView(contactUsVCValidateObj.txt_message){
////            contactUsVCValidateObj.txt_name.layer.borderWidth = 0
////            contactUsVCValidateObj.txt_email.layer.borderWidth = 0
////            
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  "البريد الإلكتروني غير صحيح"
////            }
////            else {
////                titleTxt = "Please enter a message."
////            }
////            contactUsVCValidateObj.txt_message.layer.borderWidth = 1
////            contactUsVCValidateObj.txt_message.layer.borderColor = UIColor.red.cgColor
////            contactUsVCValidateObj.view.makeToast(titleTxt)
////            contactUsVCValidateObj.view.endEditing(true)
////            contactUsVCValidateObj.txt_message.becomeFirstResponder()
////            return false
////        }
////        else{
////            contactUsVCValidateObj.txt_name.layer.borderWidth = 0
////            contactUsVCValidateObj.txt_email.layer.borderWidth = 0
////            contactUsVCValidateObj.txt_message.layer.borderWidth = 0
////            
////            return true
////        }
////    }
////    
////    
//    func ValidateProfileUpdateForm(_ editProfileVCValidateObj:MyProfileViewController) -> Bool {
//      
//        if isBlank(editProfileVCValidateObj.txt_name) {
//        
//            editProfileVCValidateObj.view.endEditing(true)
//            editProfileVCValidateObj.view.frame.origin.y = 0
//            editProfileVCValidateObj.txt_name.layer.borderColor = UIColor.red.cgColor
//            editProfileVCValidateObj.txt_name.layer.borderWidth = 2
//            editProfileVCValidateObj.view.makeToast("First Name can't be blank.")
//        
//            return false
//        }else if isBlank(editProfileVCValidateObj.txt_lastName) {
//            editProfileVCValidateObj.txt_name.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            
//            editProfileVCValidateObj.view.endEditing(true)
//            editProfileVCValidateObj.view.frame.origin.y = 0
//            editProfileVCValidateObj.txt_lastName.layer.borderColor = UIColor.red.cgColor
//            editProfileVCValidateObj.txt_lastName.layer.borderWidth = 2
//            editProfileVCValidateObj.view.makeToast("Last Name can't be blank.")
//            
//            return false
//        }else if editProfileVCValidateObj.btn_changePaaword.isSelected == true  && isBlank(editProfileVCValidateObj.txt_currentPassword){
//            editProfileVCValidateObj.txt_name.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            editProfileVCValidateObj.txt_lastName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            
//            editProfileVCValidateObj.view.endEditing(true)
//            editProfileVCValidateObj.view.frame.origin.y = 0
//            editProfileVCValidateObj.txt_currentPassword.layer.borderColor = UIColor.red.cgColor
//            editProfileVCValidateObj.txt_currentPassword.layer.borderWidth = 2
//            editProfileVCValidateObj.view.makeToast("Current Password can't be blank, when change password field is checked.")
//            
//            return false
//        }else if editProfileVCValidateObj.btn_changePaaword.isSelected == true  && isBlank(editProfileVCValidateObj.txt_newPassword){
//            editProfileVCValidateObj.txt_name.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            editProfileVCValidateObj.txt_lastName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            editProfileVCValidateObj.txt_currentPassword.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            
//            editProfileVCValidateObj.view.endEditing(true)
//            editProfileVCValidateObj.view.frame.origin.y = 0
//            editProfileVCValidateObj.txt_newPassword.layer.borderColor = UIColor.red.cgColor
//            editProfileVCValidateObj.txt_newPassword.layer.borderWidth = 2
//            editProfileVCValidateObj.view.makeToast("New Password can't be blank, when change password field is checked.")
//            
//            return false
//        }
//        else if editProfileVCValidateObj.btn_changePaaword.isSelected == true  && isBlank(editProfileVCValidateObj.txt_retypeNewPassword){
//            editProfileVCValidateObj.txt_name.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            editProfileVCValidateObj.txt_lastName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            editProfileVCValidateObj.txt_currentPassword.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            editProfileVCValidateObj.txt_newPassword.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            
//            editProfileVCValidateObj.view.endEditing(true)
//            editProfileVCValidateObj.view.frame.origin.y = 0
//            editProfileVCValidateObj.txt_retypeNewPassword.layer.borderColor = UIColor.red.cgColor
//            editProfileVCValidateObj.txt_retypeNewPassword.layer.borderWidth = 2
//            editProfileVCValidateObj.view.makeToast("Re-Type Password can't be blank, when change password field is checked.")
//            
//            return false
//        }
//        else if editProfileVCValidateObj.btn_changePaaword.isSelected == true  && (editProfileVCValidateObj.txt_retypeNewPassword.text != editProfileVCValidateObj.txt_newPassword.text){
//            editProfileVCValidateObj.txt_name.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            editProfileVCValidateObj.txt_lastName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            editProfileVCValidateObj.txt_currentPassword.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            editProfileVCValidateObj.txt_newPassword.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            editProfileVCValidateObj.txt_retypeNewPassword.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            
//            editProfileVCValidateObj.view.endEditing(true)
//            editProfileVCValidateObj.view.frame.origin.y = 0
//            editProfileVCValidateObj.txt_retypeNewPassword.layer.borderColor = UIColor.red.cgColor
//            editProfileVCValidateObj.txt_retypeNewPassword.layer.borderWidth = 2
//            editProfileVCValidateObj.view.makeToast("Re-Type Password doesn't match with the New Password.")
//            
//            return false
//        }
//        else{
//            editProfileVCValidateObj.txt_name.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            editProfileVCValidateObj.txt_lastName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            editProfileVCValidateObj.txt_currentPassword.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            editProfileVCValidateObj.txt_newPassword.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            editProfileVCValidateObj.txt_retypeNewPassword.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            return true
//        }
//    }
//    
//    
////    func ValidateAddItem(_ addItemVCValidateObj:AddItemViewController) -> Bool {
////      
////        if addItemVCValidateObj.selectedCategoryId == "" {
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please select the category."
////            }
////           
////            addItemVCValidateObj.view.makeToast(titleTxt)
////            addItemVCValidateObj.view.endEditing(true)
////            
////            return false
////        }
////        else if isBlank(addItemVCValidateObj.txt_itemName) {
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter a name for the item."
////            }
////            addItemVCValidateObj.txt_itemName.layer.borderColor = UIColor.red.cgColor
////            addItemVCValidateObj.view.makeToast(titleTxt)
////            addItemVCValidateObj.view.endEditing(true)
////            addItemVCValidateObj.txt_itemName.becomeFirstResponder()
////            return false
////        }
////        else if isBlankTextView(addItemVCValidateObj.txt_itemDescription) {
////            addItemVCValidateObj.txt_itemName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter a description for the item."
////            }
////            addItemVCValidateObj.txt_itemDescription.layer.borderColor = UIColor.red.cgColor
////            addItemVCValidateObj.view.makeToast(titleTxt)
////            addItemVCValidateObj.view.endEditing(true)
////            addItemVCValidateObj.txt_itemDescription.becomeFirstResponder()
////            return false
////        }
////        else if addItemVCValidateObj.arr_tempSavedItemData.count == 0 && addItemVCValidateObj.viewArisedFrom != "Edit"{
////            addItemVCValidateObj.txt_itemName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addItemVCValidateObj.txt_itemDescription.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addItemVCValidateObj.view.makeToast("Please select and save the item's attributes.")
////            addItemVCValidateObj.view.endEditing(true)
////            return false
////        }
////        else if addItemVCValidateObj.selectedAssets.count == 0 && addItemVCValidateObj.viewArisedFrom != "Edit"{
////            addItemVCValidateObj.txt_discount.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addItemVCValidateObj.txt_itemName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addItemVCValidateObj.txt_itemDescription.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            
////            addItemVCValidateObj.view.makeToast("Please upload minimum 1 pic for the item.")
////            addItemVCValidateObj.view.endEditing(true)
////            return false
////        }
////        else if addItemVCValidateObj.arr_selectedFiles.count == 0 && addItemVCValidateObj.viewArisedFrom == "Edit"{
////            addItemVCValidateObj.txt_discount.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addItemVCValidateObj.txt_itemName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addItemVCValidateObj.txt_itemDescription.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            
////            addItemVCValidateObj.view.makeToast("Please upload minimum 1 pic for the item.")
////            addItemVCValidateObj.view.endEditing(true)
////            return false
////        }
////        else if addItemVCValidateObj.btn_addOffer.isSelected == true{
////            addItemVCValidateObj.txt_itemName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addItemVCValidateObj.txt_itemDescription.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            if isBlank(addItemVCValidateObj.txt_discount){
////                addItemVCValidateObj.txt_discount.layer.borderColor = UIColor.red.cgColor
////                addItemVCValidateObj.view.makeToast("Please enter the discount offered on the product.")
////                addItemVCValidateObj.view.endEditing(true)
////                addItemVCValidateObj.txt_discount.becomeFirstResponder()
////                return false
////            }
////            else if addItemVCValidateObj.selectedFromDate == nil {
////                addItemVCValidateObj.txt_discount.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////                addItemVCValidateObj.view.makeToast("Please select a from-date for the offer.")
////                addItemVCValidateObj.view.endEditing(true)
////                return false
////            }
////            else if addItemVCValidateObj.selectedToDate == nil  {
////                addItemVCValidateObj.txt_discount.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////                addItemVCValidateObj.view.makeToast("Please enter a to-date for the offer.")
////                addItemVCValidateObj.view.endEditing(true)
////                return false
////            }
////            else {
////                return true
////            }
////        }
////       
////        else{
////            addItemVCValidateObj.txt_discount.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addItemVCValidateObj.txt_itemName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addItemVCValidateObj.txt_itemDescription.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            return true
////        }
////    }
////    
////    func ValidateUpgradeSubscriptionPayment(_ paymentVCValidateObj:UpgradePackagePaymentViewController) -> Bool {
////      
////        if isBlank(paymentVCValidateObj.txt_cardNumber) {
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter your card number."
////            }
////            paymentVCValidateObj.txt_cardNumber.layer.borderWidth = 2
////            paymentVCValidateObj.txt_cardNumber.layer.borderColor = UIColor.red.cgColor
////            paymentVCValidateObj.view.makeToast(titleTxt)
////            paymentVCValidateObj.view.endEditing(true)
////            paymentVCValidateObj.txt_cardNumber.becomeFirstResponder()
////            return false
////        } else if paymentVCValidateObj.txt_cardNumber.text?.count ?? 0 < 16 {
////            paymentVCValidateObj.txt_cardNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter correct card number."
////            }
////            paymentVCValidateObj.txt_cardNumber.layer.borderWidth = 2
////            paymentVCValidateObj.txt_cardNumber.layer.borderColor = UIColor.red.cgColor
////            paymentVCValidateObj.view.makeToast(titleTxt)
////            paymentVCValidateObj.view.endEditing(true)
////            paymentVCValidateObj.txt_cardNumber.becomeFirstResponder()
////            return false
////        }
////        
////        else if isBlank(paymentVCValidateObj.txt_expiry) {
////            paymentVCValidateObj.txt_cardNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter card expiry date."
////            }
////            paymentVCValidateObj.txt_expiry.layer.borderWidth = 2
////            paymentVCValidateObj.txt_expiry.layer.borderColor = UIColor.red.cgColor
////            paymentVCValidateObj.view.makeToast(titleTxt)
////            paymentVCValidateObj.view.endEditing(true)
////            paymentVCValidateObj.txt_expiry.becomeFirstResponder()
////            return false
////        }else if paymentVCValidateObj.isValidExpiryDate == false {
////            paymentVCValidateObj.txt_cardNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            paymentVCValidateObj.txt_expiry.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter a correct card expiry date."
////            }
////            paymentVCValidateObj.txt_expiry.layer.borderWidth = 2
////            paymentVCValidateObj.txt_expiry.layer.borderColor = UIColor.red.cgColor
////            paymentVCValidateObj.view.makeToast(titleTxt)
////            paymentVCValidateObj.view.endEditing(true)
////            paymentVCValidateObj.txt_expiry.becomeFirstResponder()
////            return false
////        }
////        else if isBlank(paymentVCValidateObj.txt_cvv) {
////            paymentVCValidateObj.txt_cardNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            paymentVCValidateObj.txt_expiry.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar"{
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter card cvv number."
////            }
////            paymentVCValidateObj.txt_cvv.layer.borderWidth = 2
////            paymentVCValidateObj.txt_cvv.layer.borderColor = UIColor.red.cgColor
////            paymentVCValidateObj.view.makeToast(titleTxt)
////            paymentVCValidateObj.view.endEditing(true)
////            paymentVCValidateObj.txt_cvv.becomeFirstResponder()
////            return false
////        }
////        else if paymentVCValidateObj.txt_cvv.text?.count ?? 0 < 3 {
////            paymentVCValidateObj.txt_cardNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            paymentVCValidateObj.txt_expiry.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter a valid cvv number."
////            }
////            paymentVCValidateObj.txt_cvv.layer.borderWidth = 2
////            paymentVCValidateObj.txt_cvv.layer.borderColor = UIColor.red.cgColor
////            paymentVCValidateObj.view.makeToast(titleTxt)
////            paymentVCValidateObj.view.endEditing(true)
////            paymentVCValidateObj.txt_cvv.becomeFirstResponder()
////            return false
////        }
////        else if paymentVCValidateObj.txt_cvv.text?.count ?? 0 < 3 {
////            paymentVCValidateObj.txt_cardNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            paymentVCValidateObj.txt_expiry.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            paymentVCValidateObj.txt_cvv.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter correct card cvv number."
////            }
////            paymentVCValidateObj.txt_cvv.layer.borderWidth = 2
////            paymentVCValidateObj.txt_cvv.layer.borderColor = UIColor.red.cgColor
////            paymentVCValidateObj.view.makeToast(titleTxt)
////            paymentVCValidateObj.view.endEditing(true)
////            paymentVCValidateObj.txt_cvv.becomeFirstResponder()
////            return false
////        }
////        else{
////            paymentVCValidateObj.txt_cardNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            paymentVCValidateObj.txt_expiry.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            paymentVCValidateObj.txt_cvv.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            
////            return true
////        }
////    }
////    
////    
////    func ValidateAddCoupon(_ addCouponVCValidateObj:AddCouponViewController) -> Bool {
////      
////        if addCouponVCValidateObj.imgApplied == false {
////            addCouponVCValidateObj.view.makeToast("Please add an image for your coupon.")
////            addCouponVCValidateObj.view.endEditing(true)
////            return false
////        }
////        else if isBlank(addCouponVCValidateObj.txt_title) {
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter title for your coupon."
////            }
////            addCouponVCValidateObj.txt_title.layer.borderWidth = 2
////            addCouponVCValidateObj.txt_title.layer.borderColor = UIColor.red.cgColor
////            addCouponVCValidateObj.view.makeToast(titleTxt)
////            addCouponVCValidateObj.view.endEditing(true)
////            addCouponVCValidateObj.txt_title.becomeFirstResponder()
////            return false
////        }
////        else if isBlankTextView(addCouponVCValidateObj.txt_Description) {
////            addCouponVCValidateObj.txt_title.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter description for your coupon."
////            }
////            addCouponVCValidateObj.txt_Description.layer.borderWidth = 2
////            addCouponVCValidateObj.txt_Description.layer.borderColor = UIColor.red.cgColor
////            addCouponVCValidateObj.view.makeToast(titleTxt)
////            addCouponVCValidateObj.view.endEditing(true)
////            addCouponVCValidateObj.txt_Description.becomeFirstResponder()
////            return false
////        }
////        else if addCouponVCValidateObj.btn_From.currentTitle == "" ||  addCouponVCValidateObj.btn_From.currentTitle == "dd/mm/yyyy"{
////            addCouponVCValidateObj.txt_title.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.txt_Description.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter from-date for your coupon."
////            }
////            addCouponVCValidateObj.vw_from.layer.borderWidth = 2
////            addCouponVCValidateObj.vw_from.layer.borderColor = UIColor.red.cgColor
////            addCouponVCValidateObj.view.makeToast(titleTxt)
////            addCouponVCValidateObj.view.endEditing(true)
////            return false
////        }
////        else if addCouponVCValidateObj.btn_to.currentTitle == "" ||  addCouponVCValidateObj.btn_to.currentTitle == "dd/mm/yyyy" {
////            addCouponVCValidateObj.txt_title.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.txt_Description.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.vw_from.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter to-date for your coupon."
////            }
////            addCouponVCValidateObj.vw_to.layer.borderWidth = 2
////            addCouponVCValidateObj.vw_to.layer.borderColor = UIColor.red.cgColor
////            addCouponVCValidateObj.view.makeToast(titleTxt)
////            addCouponVCValidateObj.view.endEditing(true)
////            return false
////        }
////        else if isBlank(addCouponVCValidateObj.txt_discountPercent) {
////            addCouponVCValidateObj.txt_title.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.txt_Description.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.vw_from.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.vw_to.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter discount(%) for your coupon."
////            }
////            addCouponVCValidateObj.txt_discountPercent.layer.borderWidth = 2
////            addCouponVCValidateObj.txt_discountPercent.layer.borderColor = UIColor.red.cgColor
////            addCouponVCValidateObj.view.makeToast(titleTxt)
////            addCouponVCValidateObj.view.endEditing(true)
////            addCouponVCValidateObj.txt_discountPercent.becomeFirstResponder()
////            return false
////        }
////        else if isBlank(addCouponVCValidateObj.txt_minTxnValue) {
////            addCouponVCValidateObj.txt_title.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.txt_Description.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.vw_from.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.vw_to.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.txt_discountPercent.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter minimum transaction value for your coupon."
////            }
////            addCouponVCValidateObj.txt_minTxnValue.layer.borderWidth = 2
////            addCouponVCValidateObj.txt_minTxnValue.layer.borderColor = UIColor.red.cgColor
////            addCouponVCValidateObj.view.makeToast(titleTxt)
////            addCouponVCValidateObj.view.endEditing(true)
////            addCouponVCValidateObj.txt_minTxnValue.becomeFirstResponder()
////            return false
////        }
////        else if isBlank(addCouponVCValidateObj.txt_maxCouponAmt) {
////            addCouponVCValidateObj.txt_title.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.txt_Description.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.vw_from.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.vw_to.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.txt_discountPercent.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.txt_minTxnValue.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter maximum offerred amount for your coupon."
////            }
////            addCouponVCValidateObj.txt_maxCouponAmt.layer.borderWidth = 2
////            addCouponVCValidateObj.txt_maxCouponAmt.layer.borderColor = UIColor.red.cgColor
////            addCouponVCValidateObj.view.makeToast(titleTxt)
////            addCouponVCValidateObj.view.endEditing(true)
////            addCouponVCValidateObj.txt_maxCouponAmt.becomeFirstResponder()
////            return false
////        }
////        else if isBlank(addCouponVCValidateObj.txt_code) {
////            addCouponVCValidateObj.txt_title.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.txt_Description.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.vw_from.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.vw_to.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.txt_discountPercent.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.txt_minTxnValue.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.txt_maxCouponAmt.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter code for your coupon."
////            }
////            addCouponVCValidateObj.txt_code.layer.borderWidth = 2
////            addCouponVCValidateObj.txt_code.layer.borderColor = UIColor.red.cgColor
////            addCouponVCValidateObj.view.makeToast(titleTxt)
////            addCouponVCValidateObj.view.endEditing(true)
////            addCouponVCValidateObj.txt_code.becomeFirstResponder()
////            return false
////        }
////        else if addCouponVCValidateObj.txt_code.text!.count < 8 || addCouponVCValidateObj.txt_code.text!.count > 20{
////            addCouponVCValidateObj.txt_title.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.txt_Description.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.vw_from.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.vw_to.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.txt_discountPercent.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.txt_minTxnValue.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.txt_maxCouponAmt.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Code must be in the range 8-20 characters."
////            }
////            addCouponVCValidateObj.txt_code.layer.borderWidth = 2
////            addCouponVCValidateObj.txt_code.layer.borderColor = UIColor.red.cgColor
////            addCouponVCValidateObj.view.makeToast(titleTxt)
////            addCouponVCValidateObj.view.endEditing(true)
////            addCouponVCValidateObj.txt_code.becomeFirstResponder()
////            return false
////        }
////        
////        else{
////            addCouponVCValidateObj.txt_title.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.txt_Description.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.vw_from.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.vw_to.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.txt_discountPercent.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.txt_minTxnValue.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.txt_maxCouponAmt.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addCouponVCValidateObj.txt_code.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            return true
////        }
////    }
////    
////    func ValidateBankDetailsForm1(_ addDetailsVCValidateObj:bankAccountSignupViewController) -> Bool {
////      
////       if isBlank(addDetailsVCValidateObj.txt_accountName) {
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter your bank account holder name."
////            }
////            addDetailsVCValidateObj.txt_accountName.layer.borderWidth = 2
////            addDetailsVCValidateObj.txt_accountName.layer.borderColor = UIColor.red.cgColor
////            addDetailsVCValidateObj.view.makeToast(titleTxt)
////            addDetailsVCValidateObj.view.endEditing(true)
////            addDetailsVCValidateObj.txt_accountName.becomeFirstResponder()
////            return false
////        }
////       else if isBlank(addDetailsVCValidateObj.txt_accountNumber) {
////            addDetailsVCValidateObj.txt_accountName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter your bank account number."
////            }
////            addDetailsVCValidateObj.txt_accountNumber.layer.borderWidth = 2
////            addDetailsVCValidateObj.txt_accountNumber.layer.borderColor = UIColor.red.cgColor
////            addDetailsVCValidateObj.view.makeToast(titleTxt)
////            addDetailsVCValidateObj.view.endEditing(true)
////            addDetailsVCValidateObj.txt_accountNumber.becomeFirstResponder()
////            return false
////       }
////       else if addDetailsVCValidateObj.txt_accountNumber.text?.count ?? 0 < 9 {
////            addDetailsVCValidateObj.txt_accountName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addDetailsVCValidateObj.txt_accountNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addDetailsVCValidateObj.txt_ibanNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter a valid account number."
////            }
////            addDetailsVCValidateObj.txt_accountNumber.layer.borderWidth = 2
////            addDetailsVCValidateObj.txt_accountNumber.layer.borderColor = UIColor.red.cgColor
////            addDetailsVCValidateObj.view.makeToast(titleTxt)
////            addDetailsVCValidateObj.view.endEditing(true)
////            addDetailsVCValidateObj.txt_accountNumber.becomeFirstResponder()
////            return false
////       }
////       else if isBlank(addDetailsVCValidateObj.txt_ibanNumber) {
////            addDetailsVCValidateObj.txt_accountName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addDetailsVCValidateObj.txt_accountNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter your IBAN number."
////            }
////            addDetailsVCValidateObj.txt_ibanNumber.layer.borderWidth = 2
////            addDetailsVCValidateObj.txt_ibanNumber.layer.borderColor = UIColor.red.cgColor
////            addDetailsVCValidateObj.view.makeToast(titleTxt)
////            addDetailsVCValidateObj.view.endEditing(true)
////            addDetailsVCValidateObj.txt_ibanNumber.becomeFirstResponder()
////            return false
////       }
////      
////       else if addDetailsVCValidateObj.txt_ibanNumber.text?.count ?? 0 != 23 {
////            addDetailsVCValidateObj.txt_accountName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addDetailsVCValidateObj.txt_accountNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addDetailsVCValidateObj.txt_ibanNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter a valid IBAN number."
////            }
////            addDetailsVCValidateObj.txt_ibanNumber.layer.borderWidth = 2
////            addDetailsVCValidateObj.txt_ibanNumber.layer.borderColor = UIColor.red.cgColor
////            addDetailsVCValidateObj.view.makeToast(titleTxt)
////            addDetailsVCValidateObj.view.endEditing(true)
////            addDetailsVCValidateObj.txt_ibanNumber.becomeFirstResponder()
////            return false
////       }
////       else if !(addDetailsVCValidateObj.txt_ibanNumber.text!.contains(addDetailsVCValidateObj.txt_accountNumber.text ?? "")) {
////            addDetailsVCValidateObj.txt_accountName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addDetailsVCValidateObj.txt_accountNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addDetailsVCValidateObj.txt_ibanNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            var titleTxt = ""
////            if language == "ar" {
////                titleTxt =  ""
////            }
////            else {
////                titleTxt = "Please enter a valid IBAN number."
////            }
////            addDetailsVCValidateObj.txt_ibanNumber.layer.borderWidth = 2
////            addDetailsVCValidateObj.txt_ibanNumber.layer.borderColor = UIColor.red.cgColor
////            addDetailsVCValidateObj.view.makeToast(titleTxt)
////            addDetailsVCValidateObj.view.endEditing(true)
////            addDetailsVCValidateObj.txt_ibanNumber.becomeFirstResponder()
////            return false
////       }
////        else{
////            addDetailsVCValidateObj.txt_accountName.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addDetailsVCValidateObj.txt_accountNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            addDetailsVCValidateObj.txt_ibanNumber.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
////            return true
////        }
////    }
////    
//    
//    func ValidatePaymentForm(_ paymentVCValidateObj:PaymentDetailsViewController) -> Bool {
//      
//        if isBlank(paymentVCValidateObj.txt_number) {
//            paymentVCValidateObj.view.endEditing(true)
//            paymentVCValidateObj.txt_number.layer.borderWidth = 2
//            paymentVCValidateObj.txt_number.layer.borderColor = UIColor.red.cgColor
//            paymentVCValidateObj.view.makeToast("Please enter your card number.", duration: 1.5, position: .bottom, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
//        
//            return false
//        }else if isBlank(paymentVCValidateObj.txt_expiry) {
//            paymentVCValidateObj.txt_number.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//           
//            paymentVCValidateObj.view.endEditing(true)
//            paymentVCValidateObj.txt_expiry.layer.borderWidth = 2
//            paymentVCValidateObj.txt_expiry.layer.borderColor = UIColor.red.cgColor
//            paymentVCValidateObj.view.makeToast("Please enter your card expiry date.", duration: 1.5, position: .bottom, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
//            return false
//        }else if isBlank(paymentVCValidateObj.txt_cvv) {
//            paymentVCValidateObj.txt_number.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            paymentVCValidateObj.txt_expiry.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//           
//            paymentVCValidateObj.view.endEditing(true)
//            paymentVCValidateObj.txt_cvv.layer.borderWidth = 2
//            paymentVCValidateObj.txt_cvv.layer.borderColor = UIColor.red.cgColor
//            paymentVCValidateObj.view.makeToast("Please enter your card cvv.", duration: 1.5, position: .bottom, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
//
//            return false
//        }
//        else{
//            paymentVCValidateObj.txt_number.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            paymentVCValidateObj.txt_expiry.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            paymentVCValidateObj.txt_cvv.layer.borderColor = Config().AppThemetextBoxesBorderColor.cgColor
//            return true
//        }
//    }  
}


