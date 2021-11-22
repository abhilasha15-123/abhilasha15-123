//
//  SignUpViewController.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 04/06/21.
//

import UIKit
import GoogleSignIn
import AuthenticationServices
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var fullnameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var MobileTxt: UITextField!
    @IBOutlet weak var PasswordTxt: UITextField!
    @IBOutlet weak var ConfirmPasswordTxt: UITextField!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var fullname: UIView!
    @IBOutlet weak var emailview: UIView!
    @IBOutlet weak var mobileview: UIView!
    @IBOutlet weak var passwordview: UIView!
    @IBOutlet weak var confirmpasswordview: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullname.layer.cornerRadius = 7
        fullname.layer.borderWidth = 1.2
        fullname.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0).cgColor
        
        emailview.layer.cornerRadius = 7
        emailview.layer.borderWidth = 1.2
        emailview.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0).cgColor
        
        mobileview.layer.cornerRadius = 7
        mobileview.layer.borderWidth = 1.2
        mobileview.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0).cgColor
        
        passwordview.layer.cornerRadius = 7
        passwordview.layer.borderWidth = 1.2
        passwordview.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0).cgColor
        
        emailview.layer.cornerRadius = 7
        emailview.layer.borderWidth = 1.2
        emailview.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0).cgColor
        
        confirmpasswordview.layer.cornerRadius = 7
        confirmpasswordview.layer.borderWidth = 1.2
        confirmpasswordview.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0).cgColor

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signInBtnAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func RegisterBtnAction(_ sender: Any) {
        self.view.endEditing(true)
        if ValidationClass().ValidateSignUpForm(self){
                 
            basicFunctions.presentLoader()
  
            let parameterDictionary = NSMutableDictionary()
                   
            parameterDictionary.setValue(fullnameTxt.text ?? "", forKey: "name")
            parameterDictionary.setValue(emailTxt.text ?? "", forKey: "email")
            parameterDictionary.setValue(MobileTxt.text ?? "", forKey: "mobile")
            parameterDictionary.setValue(PasswordTxt.text ?? "", forKey: "password")
            parameterDictionary.setValue(Config().api_key, forKey: "api_key")
    
            print(parameterDictionary)

            let methodName = "register"
               
            DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
                let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
              
                if status == "1" {
                   
                    let data = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
                 
                    Config().AppUserDefaults.setValue(DataManager.getVal(data["id"]) as? String ?? "", forKey: "user_id")
                        
                    self.view.makeToast(message)
                            
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){

                        let vc = self.storyboard?.instantiateViewController(identifier: "VerficationViewController") as! VerficationViewController
                        vc.datatype = "1"
                        vc.userId = DataManager.getVal(data["id"]) as? String ?? ""
                        self.navigationController?.pushViewController(vc, animated: true)

                    }
                }else{
                    self.view.makeToast(message)
                }
                   
                basicFunctions.stopLoading()
             
            }
        }
    }
    
    @IBAction func facebookBtnAction(_ sender: Any) {
        handleFacebookLogin()
    }
    
    @IBAction func twitterBtnAction(_ sender: Any) {
        handleAppleIdRequest()
    }
    
    @IBAction func googleBtnAction(_ sender: Any) {
        googleSigninInit()
    }
    
    @IBAction func termsConditionBtnAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "WebVwViewController") as! WebVwViewController
        vc.urlStr = "https://soultribenow.com/terms"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}






extension SignUpViewController{
    func handleFacebookLogin(){
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.publicProfile, .email], viewController: self, completion: { loginResult in
            switch loginResult {
            case .failed(let error):
                print("\(error)")
            case .cancelled:
                print("cancelled")
            case .success(let grantedPermissions, let declinedPermissions, _):
                print("\(grantedPermissions) \(declinedPermissions)")
                
                if grantedPermissions.contains(.email){
                    self.getFBUserData()
                }
            }
        })
    }
    
    
    func handleAppleIdRequest() {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
            
        }else{
            self.view.makeToast(  Bundle.main.localizedString(forKey: "Pleaseupdateyourappleversiontouseapplesignin", value: nil, table: "Localizable"))
        }
    }
    
    
    func showTextInputPrompt(withMessage message: String,completionBlock: @escaping ((Bool, String?) -> Void)) {
        let prompt = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
          completionBlock(false, nil)
        }
        weak var weakPrompt = prompt
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
          guard let text = weakPrompt?.textFields?.first?.text else { return }
          completionBlock(true, text)
        }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(cancelAction)
        prompt.addAction(okAction)
        present(prompt, animated: true, completion: nil)
    }
    
    func socialLogin(cred : AuthCredential,usr:GIDGoogleUser){
        Auth.auth().signIn(with: cred) { authResult, error in
            if let error = error {
                let isMFAEnabled = true
            
                let authError = error as NSError
                if isMFAEnabled, authError.code == AuthErrorCode.secondFactorRequired.rawValue {
                    // The user is a multi-factor user. Second factor challenge is required.
                    let resolver = authError.userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
                    var displayNameString = ""
                    for tmpFactorInfo in resolver.hints {
                        displayNameString += tmpFactorInfo.displayName ?? ""
                        displayNameString += " "
                    }
            
            
                    self.showTextInputPrompt(withMessage: "Select factor to sign in\n\(displayNameString)", completionBlock: { userPressedOK, displayName in
                        var selectedHint: PhoneMultiFactorInfo?
                        for tmpFactorInfo in resolver.hints {
                            if displayName == tmpFactorInfo.displayName {
                                selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
                            }
                        }
                        PhoneAuthProvider.provider().verifyPhoneNumber(with: selectedHint!, uiDelegate: nil,multiFactorSession: resolver.session) { verificationID, error in
                            if error != nil {
                                print("Multi factor start sign in failed. Error: \(error.debugDescription)")
                            } else {
                                self.showTextInputPrompt(withMessage: "Verification code for \(selectedHint?.displayName ?? "")",completionBlock: { userPressedOK, verificationCode in
                                    let credential: PhoneAuthCredential? = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!,verificationCode: verificationCode!)
                                    let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator.assertion(with: credential!)
                                    resolver.resolveSignIn(with: assertion!) { authResult, error in
                                        if error != nil {
                                            print("Multi factor finanlize sign in failed. Error:\(error.debugDescription)")
                                        } else {
                                            self.navigationController?.popViewController(animated: true)
                                        }
                                    }
                                }
                                )
                            }
                        }
                    }
                    )
                } else {
                    self.view.makeToast(error.localizedDescription)
                    return
                }
                // ...
                return
            }
        
        // User is signed in
            let googleId = DataManager.getVal(usr.userID) as? String ?? ""
        //        let email_id = DataManager.getVal(user.profile.email) as? String ?? ""
        //        let first_name = DataManager.getVal(user.profile.givenName) as? String ?? ""
        //        let last_name = DataManager.getVal(user.profile.familyName) as? String ?? ""
        
        guard let emailv = usr.profile?.email else { return }
        guard let imageUrl = usr.profile?.imageURL(withDimension: 400) else { return }
        print(imageUrl)
        //emailIdTxtFld.text = emailv
        
        var socialInfo : [String:String] = [:]
        socialInfo["email"] = emailv
        socialInfo["social_id"] = usr.userID
        socialInfo["social_type"] = "google"
        socialInfo["first_name"] = usr.profile?.givenName
        socialInfo["last_name"] = usr.profile?.familyName
        socialInfo["mobile_number"] = ""
        socialInfo["image"] = imageUrl.path
        print(imageUrl.path)
        
            self.api_socialLogin(info: socialInfo, type: "Google")
            
        }
    }
    
    func googleSigninInit() {
        let clientID = FirebaseApp.app()?.options.clientID ?? ""
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            if error != nil {
                return
            }
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                   accessToken: authentication.accessToken)
            
            if user != nil {
                socialLogin(cred: credential, usr: user!)
            }else{
                Bundle.main.localizedString(forKey: "UnabletosigninwiththeaccountPleasetryagain", value: nil, table: "Localizable")
            }
        }
    }
    
    
    //MARK:- Facebook User Data
    func getFBUserData(){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completion: {(connection, result, error) -> Void in
                if error != nil{
                    print("FB error")
                    return
                }
                let fbLoginManager = LoginManager()
                fbLoginManager.logOut()
                print(result as Any)
                
                let fields = result as? [String:Any];
             
                self.FacebookLogin_API(data : fields ?? [:])
            })
        }
    }
    
    
    func FacebookLogin_API(data : [String:Any]){
        
//        let fullName = DataManager.getVal(data["name"]) as? String ?? ""
        let firstName = DataManager.getVal(data["first_name"]) as? String ?? ""
        let lastName = DataManager.getVal(data["last_name"]) as? String ?? ""
        let social_id = DataManager.getVal(data["id"]) as? String ?? ""
        let email = DataManager.getVal(data["email"]) as? String ?? ""
//        let facebookProfileUrl = "http://graph.facebook.com/\(social_id)/picture?type=large"
        
        let picDict = DataManager.getVal(data["picture"]) as? [String:Any] ?? [:]
        let urlDict = DataManager.getVal(picDict["data"]) as? [String:Any] ?? [:]
        let urlImg = DataManager.getVal(urlDict["url"]) as? String ?? ""
        
        
        var socialInfo : [String:String] = [:]
        socialInfo["email"] = email
        socialInfo["social_id"] = social_id
        socialInfo["social_type"] = "facebook"
        socialInfo["first_name"] = firstName
        socialInfo["last_name"] = lastName
        socialInfo["mobile_number"] = ""
        socialInfo["image"] = urlImg
        
        self.api_socialLogin(info: socialInfo, type: "Fb")
        
    }
    
    
    func api_socialLogin(info : [String:Any], type: String){
          
        basicFunctions.presentLoader()

        let parameterDictionary = NSMutableDictionary()
        
        parameterDictionary.setValue(DataManager.getVal(info["email"]) as? String ?? "", forKey: "email")
        parameterDictionary.setValue("\(DataManager.getVal(info["first_name"]) as? String ?? "") \(DataManager.getVal(info["last_name"]) as? String ?? "")", forKey: "name")
        parameterDictionary.setValue(DataManager.getVal(info["image"]) as? String ?? "", forKey: "profile_picture")
        parameterDictionary.setValue(Config().api_key, forKey: "api_key")
       

        var methodName = ""
        
        if type == "Google"{
            parameterDictionary.setValue(DataManager.getVal(info["social_id"]) as? String ?? "", forKey: "google_id")
            methodName = "google_login"
        }else{
            parameterDictionary.setValue(DataManager.getVal(info["social_id"]) as? String ?? "", forKey: "facebook_id")
            methodName = "facebook_login"
        }
        
        print(parameterDictionary)
        
        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as! String
            let message  = DataManager.getVal(responseData?["message"]) as! String

            if status == "1" {
               
                let data = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
                let screen_val = DataManager.getVal(data["app_screen"]) as? String ?? ""
                 
                self.view.makeToast(message)
                 
                Config().AppUserDefaults.setValue(DataManager.getVal(data["id"]) as? String ?? "", forKey: "user_id")
                 
                if screen_val == "0"{
                    let vc = self.storyboard?.instantiateViewController(identifier: "LocationAccessVC") as! LocationAccessVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if screen_val == "1"{
                    let vc = self.storyboard?.instantiateViewController(identifier: "SetprofileVC") as! SetprofileVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if screen_val == "2"{
                    let vc = self.storyboard?.instantiateViewController(identifier: "SetProfilestep2VC") as! SetProfilestep2VC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if screen_val == "3"{
                    let arr = (DataManager.getVal(data["vibe"]) as? String ?? "").components(separatedBy: ",")
                     
                    if arr.contains("Soul Love") || arr.contains("Tribe"){
                        let vc = self.storyboard?.instantiateViewController(identifier: "SetProfilestep3VC") as! SetProfilestep3VC
                        vc.vibe = DataManager.getVal(data["vibe"]) as? String ?? ""
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else{
                        let vc = self.storyboard?.instantiateViewController(identifier: "SetProfilefinalVC") as! SetProfilefinalVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }else if screen_val == "4"{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let navigate = storyboard.instantiateViewController(withIdentifier: "TTabBarViewController") as! TTabBarViewController
                        let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                        let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                        slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                        UIApplication.shared.windows.first?.rootViewController = slideMenuController
                        UIApplication.shared.windows.first?.makeKeyAndVisible()
                    }
                }
            }
            else {
                self.view.makeToast(message, duration: 2.0, position: .bottom, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
            }
//                self.removeSpinner()
            basicFunctions.stopLoading()
        }
    }
}


extension SignUpViewController : ASAuthorizationControllerDelegate{
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
            case let credentials as ASAuthorizationAppleIDCredential:
                DispatchQueue.main.async {

                    let appleId = credentials.user
                    print(appleId)
                    let appleUserFirstName = credentials.fullName?.givenName ?? ""
                    let appleUserLastName = credentials.fullName?.familyName ?? ""
                    let appleUserEmail = credentials.email ?? ""
      
                    Config().AppUserDefaults.setValue(appleId, forKey: "AppleToken")
                    Config().AppUserDefaults.setValue(appleUserEmail, forKey: "AppleUserEmail")
                    Config().AppUserDefaults.setValue(appleUserFirstName, forKey: "AppleUserFirstName")
                    Config().AppUserDefaults.setValue(appleUserLastName, forKey: "AppleUserLastName")
                   //apicall
                }

        case let credentials as ASPasswordCredential:
            DispatchQueue.main.async {

                let appleUsername = credentials.user
                print(appleUsername as Any)
                let applePassword = credentials.password
                print(applePassword as Any)
                //Write your code
                
                //apicall

            }

        default :
            let alert: UIAlertController = UIAlertController(title: "Apple Sign In", message: "Something went wrong with your Apple Sign In!", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

            self.present(alert, animated: true, completion: nil)
            break
        }
    }


    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error){
        
        let alert: UIAlertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
  
}


extension SignUpViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}


