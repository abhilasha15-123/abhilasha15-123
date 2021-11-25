//
//  LocalizedStringKeys.swift
//  TuVozNow
//
//  Created by pc on 18/06/20.
//  Copyright © 2020 zokoo. All rights reserved.
//

import Foundation
import UIKit
enum LocalizedStringKeys {
    //Launch Screen
    static let skipLoginForNow = "Skip login for now"
    static let promotionalVoices = "Promotional Voices:"
    static let Chromecast = "Chromecast"
    static let videoPlayback = "Video Playback"
    
    //Sign In
    static let WelcomeBack = "Welcome back!"
    static let DontHaveAnAccount = "Don't have an account?"
    static let SignUp = "Sign Up"
    static let Username = "Username:"
    static let Password = "Password:"
    static let Forgotpassword_LogIn = "Forgot username or password?"
    static let SelectLanguage = "Select Language"
    static let termsOfServiceDescription = "By tapping to continue, you are indicating that you agree to the TuVozNow Terms of Service."
    static let termsOfService = "Terms of Service"
    //Age Confirmation Screen
    static let confirmYourAge = "Confirm Your Age"
    static let weRequireUsersAgeConfirmation = "We require users to be 18 years old or over.Please confirm your age."
    static let confirmedThat18Years = "I confirmed that I am 18 years or older."
    //Launch Screen FaceID and Touch ID Messages
    static let kBiometryNotAvailableReason = "Biometric authentication is not available for this device."
    /// ****************  Touch ID  ****************** ///
    static let kTouchIdAuthenticationReason = "Confirm your fingerprint to authenticate."
    static let kTouchIdPasscodeAuthenticationReason = "Touch ID is locked now, because of too many failed attempts. Enter passcode to unlock Touch ID."
    /// Error Messages Touch ID
    static let kSetPasscodeToUseTouchID = "Please set device passcode to use Touch ID for authentication."
    static let kNoFingerprintEnrolled = "There are no fingerprints enrolled in the device. Please go to Device Settings -> Touch ID & Passcode and enroll your fingerprints."
    static let kDefaultTouchIDAuthenticationFailedReason = "Touch ID does not recognize your fingerprint. Please try again with your enrolled fingerprint."
    /// ****************  Face ID  ****************** ///
    static let kFaceIdAuthenticationReason = "Confirm your face to authenticate."
    static let kFaceIdPasscodeAuthenticationReason = "Face ID is locked now, because of too many failed attempts. Enter passcode to unlock Face ID."
    /// Error Messages Face ID
    static let kSetPasscodeToUseFaceID = "Please set device passcode to use Face ID for authentication."
    static let kNoFaceIdentityEnrolled = "There is no face enrolled in the device. Please go to Device Settings -> Face ID & Passcode and enroll your face."
    static let kDefaultFaceIDAuthenticationFailedReason = "Face ID does not recognize your face. Please try again with your enrolled face."
    //SignUp Screen
    static let ReEnterPassword = "Re-Enter Password:"
    static let Code = "Code:"
    static let PhoneNumber = "Phone Number:"
    static let CreatingAnAccount = "Creating an account is easy and allows you to get the most out of TuVozNow."
    static let AlreadyHaveAnAccount = "Already have an account?"
    static let SignIn = "Sign In"
    static let UsernameVerified = "Username verified."
    static let UsernameAlreadyExist = "Username already exist."
    static let PhoneNumberVerified = "Phone number verified."
    static let PhoneNumberAlreadyExist = "Phone number already exist."
    static let Back = "Back"
    static let Continue = "Continue"
    
    //OTP Screen
    static let EnterOTP = "Enter OTP"
    static let Verify = "Verify"
    //Alert Messages
    static let UnableToSendOTP = "Unable to send OTP on the given mobile number."
    static let OTPResendSuccessfully = "OTP resend successfully."
    static let UnableToResendOTP = "Unable to re-send OTP."
    static let TuVozNowWantsToUsePaypal = "\"TuVozNow\" wants to use \"paypal.com\" to Sign In"
    static let SomethingWentWrongPleaseTryAgainLater = "Something went wrong. Please try again later."
    static let UsernameFieldShouldNotBeEmpty = "Username field should not be empty."
    static let PasswordFieldShouldNotBeEmpty = "Password field should not be empty."
    static let PasswordValidation = "Password must contain 8-20 characters with at least 1 uppercase letter, 1 lowercase letter, 1 number and 1 special character."
    static let EmailFieldShouldNotBeEmpty = "Email field should not be empty."
    static let PleaseEnterValidEmailAddress = "Please enter valid email address."
    static let ReEnterPasswordFieldShouldNotBeEmpty = "Re-Enter Password field should not be empty."
    static let PhoneNumberFiledShouldNotBeEmpty = "PhoneNumber filed should not be empty."
    static let PleaseMakeSurePasswordsMatch = "Please make sure passwords match."
    static let PleaseEnterValidePhoneNumber = "Please enter valide phone number."
    static let PleaseEnterOTP = "Please enter OTP."
    static let PleaseEnterValidOTPToResetYourPassword = "Please enter valid OTP to reset your password."
    static let PleaseSelectValidCountryCode = "Please select valid country code."
    static let PleaseEnterVideoTitle = "Please enter video title."
    static let PleaseEnterVideoDescription = "Please enter video description."
    static let PleaseSelectProperRegion = "Please select proper region."
    static let PleaseEnterValidOTPToUploadVideo = "Please enter valid OTP to upload video."
    static let UsCodeSsTuvoznowAccountPhoneVerificationCode = "Use %d as Tuvoznow account phone verification code."
    static let SignInOrSignUpFirst = "Please sign in or sign up first."
    static let AllowePhotos = "Please allow photos from setting to get all videos."
    static let VideoTypeNowAllowed = "This type of video is not allowed to upload."
    static let PleaseWriteSomething = "Please write something."
    static let No_More_Videos = "No more videos availble."
    //OTP Screen
    static let OTPSubStting = "A SMS with a OTP has been sent to your phone. Please enter the code below."
    static let DidntGetOTP = "Didn't get OTP?"
    static let resendInSeconds = "Resend in %d seconds"
    static let resendInOneSeconds = "Resend in 1 second"
    static let resendNow = "RESEND NOW"
    //Choose Memebership
    static let chooseMembership = "Choose Membership"
    static let Free = "Free"
    static let Premium = "Premium"
    static let PremiumPrice = "$ %d / month"
    static let PremiumNotAvailable = "Premium membership is temporary unavailable."
    static let chooseMembershipDescription = "Choose how you want to discover the world around you. You can always change your membership down the road."
    static let premimumDescription = "Watch and share videos completely ad-free with our premium membership."
    //Forgot password screen
    static let ForgotPassword = "Forgot Password!"
    static let Submit = "Submit"
    static let forgotPasswordDesciption = "Enter the phone number associated with your account below and we’ll send you a text to reset your password."
    //Choose payment method screen
    static let choosePaymentMethod = "Choose Payment Method"
    static let choosePaymentDescription = "Select your preferred payment method below to get started with your premium membership."
    //Success screen
    static let success = "Success!"
    static let successDescription = "You've created your account. Now you're ready to view or share videos from around the world!"
    //Reset Password screen
    static let ResetPassword = "Reset Password"
    static let ResetYourPassword = "Reset Your Password"
    static let resetPasswordDescription = "You can reset your password here. After reseting your password you can successfully login with updated password."
    static let Hello = "Hello"
    //Country Picker Screen
    static let SelectCountry = "Select Country"
    
    //TabBar
    static let Home = "Home"
    static let Following = "Following"
    static let Contacts = "Contacts"
    static let Follow = "Follow"
    static let Upload = "Upload"
    static let Inbox = "Inbox"
    static let Profile = "Profile"
    //Home Tab
    static let Trending = "Trending"
    static let Worldwide = "World wide"
    static let ByRegion = "By Region"
    static let viewMore = "View more"
    static let Cancel = "Cancel"
    static let TopVieceWorldWide = "Top Voices World Wide"
    static let TopVoicesWorldWideSubTitle = "Here you can view top videos and popular videos."
    //World wide screen
    static let top10Videos = "Top 10 Voices Worldwide"
    static let popularVoices = "Popular Voices:"
    //By Region Screen
    static let popularRegion = "Popular Region"
    static let TopVideosIn = "Top videos in"
    static let TopVoicesIn = "Top voices in"
    //Region Details
    static let TopVideos = "Top voices "
    static let inText = "in"
    //Following tab
    static let Regions = "Regions"
    static let People = "People"
    //Regions screen
    static let RegionsYouAreFollowing = "Regions You're Following:"
    static let FollowingRegions = "Following Regions"
    static let ViewRegion = "View Region"
    static let RegionTab_Placeholder_Description = "Here you can view regions that you've followed for quick-access. To begin, search for a region and hit \"follow\"."
    //People screen
    static let FollowingPeople = "Following People"
    static let PropleYouAreFollowing = "People You’re Following:"
    static let PeopleTab_Placholder_Description = "Here you can view people that you've followed and their most recent videos. To follow a user. simply click follow next to their name."
    
    //Upload Tab
    static let selectPhotoDescrition = "Select a video to upload from your library"
    static let noPhotosDescription = "No videos in your library"
    static let VideoDetails = "Video Details"
    static let Anonymous = "Anonymous"
    static let SignIn_PopUP_Title = "You're Not Signed In"
    static let SignIN_PoUp_Uploading_Message = "Signing into your accounts allows you to upload videos to TuVozNow."
    static let Video_Aleredy_Saved = "This video is already saved."
    
    //Video Details screeen
    static let PostingAs = "Posting as:"
    static let PostVideoAnonymously = "Post Video Anonymously"
    static let VideoTitle = "Video Title:"
    static let VideoDescription = "Video Description:"
    static let Description = "Description"
    static let AnonymousDescription = "Posting your video anonymously removes your name from the video and is a permanent action. Videos posted anonymously go through a brief content moderation process."
    //Two Fector Autnentication screen
    static let TwoFectorAuthentication = "Two-Factor Authentication"
    static let MessageSendDescription = "A message with a verification code has been sent to your device. Please enter the code to continue."
    static let VideoUploadingSuccessfully = "Video uploaded successfully."
    static let UnableToUploadVideo = "Unable to upload video. Please try again."
    static let VideoUploadingFailed = "Video uploading failed."
    static let VideoUploadingMessage = "Use %d as Video Uploading authentication code."
    static let SignIN_PoUp_downloading_Message = "Signing into your accounts allows you to download videos."
    //Success Screen (Video Uploading)
    static let VideoUploadingDescription = "We will let you know as soon as your video is ready to view."
    
    //Inbox Tab
    static let Message = "Message"
    static let Messages = "Messages"
    static let Request = "Request"
    
    static let Requests = "Requests"
    static let Requested = "Requested"
    static let MessagesPlaceholderText = "Here you can view chat list with last message."
    static let RequestList = "Request List"
    static let RequestPlaceholderText = "Here you can view requests that people want to connect with you."
    static let Accept = "Accept"
    static let Decline = "Decline"
    static let Blocked = "Blocked"
    static let Block = "Block"
    static let Unblock = "Unblock"
    //Profile Tab
    static let PublicProfile = "Public Profile"
    static let Followers = "Followers"
    static let LikedVideos = "Liked Videos"
    static let SavedVideos = "Saved Videos"
    static let private_profile = "Private Profile"
    static let video_request = "Video Request"
    static let saved_livestream_videos = "Saved Livestream Videos"
    
    static let Membership = "Membership"
    static let Logout = "Logout"
    static let DeletePhoto = "Delete Photo"
    static let TakePhoto = "Take Photo"
    static let ChoosePhoto = "Choose Photo"
    static let Language = "Language"
    
    //Public Profile Screen
    static let About = "About:"
    static let AboutYou = "About You"
    static let Address = "Address"
    
    static let YourVideo = "Your Video "
    static let YourVideos = "Your Videos "
    
    //Followers Screen
    static let YourFollowers = "Your Followers"
    
    //Following Screen
    
    //Liked Videos
    static let YourLikedVideo = "Your Liked Video"
    static let YourLikedVideos = "Your Liked Videos"
    
    //Saved Videos
    static let YourSavedVideos = "Your Saved Videos"
    static let ViewSavedVideos = "Here you can view videos thay you Saved."
    //Membership Screen
    static let PreferedPaymentMethod = "Your preferred payment method:"
    static let DebitOrCreditCard = "Debit or Credit Card"
    
    //Search
    static let SearchPlaceholder = "Search Tuvoznow"
    static let Filter = "Filter"
    static let Filters = "Filters"
    static let Apply = "Apply"
    static let SearchBy = "Search By:"
    static let UploadDate = "Upload Date:"
    static let Show = "Show:"
    static let Relevance = "Relevance"
    static let Popularity = "Popularity"
    static let MostRecent = "Most Recent"
    static let AnyTime = "Anytime"
    static let Today = "Today"
    static let ThisWeek = "This Week"
    static let ThisMonth = "This Month"
    static let ThisYear = "This Year"
    static let UsersAndRegions = "Users & Regions"
    static let Users = "Users"
    static let PlaceholderTextForSearch = "No result found with searched text. Please try again with different text."
    //Video Player Screen
    static let Share = " Share"
    static let Save = " Save"
    static let Saved = " Saved"
    static let Comments = "Comments"
    static let NoComments = "No comments yet"
    static let PleaseSelectReason = "Please select reason."
    static let Pause = "Pause"
    static let CancelDownload = "Cancel Download"
    static let ResumeDownload = "Resume Download"
    static let Video_Uploaded_By_You = "This video is uploaded by you."

    static let SeeMore = "See more"
    static let SeeLess = "See less"
    
    //User Profile
    static let RequestAlertMessage = "Already requested. Please wait till the %d's response."
    //Common
    static let Likes = "Likes"
    static let Like = "Like"
    static let Views = "Views"
    static let View = "View"
    
    static let Video = "Video"
    static let Videos = "Videos"
    static let Follower = "Follower"
    static let ContinueWithSpace = "  Countinue      "
    static let YouAreNotSignedIn = "You're Not Signed In"
    static let SignIN_Placholder_Description = "Sign in to view your profile information and access all of TuVozNow"
    static let YearAgo = "year ago"
    static let YearsAgo = "years ago"
    static let MonthAgo = "month ago"
    static let MonthsAgo = "months ago"
    static let DayAgo = "day ago"
    static let DaysAgo = "days ago"
    static let HourAgo = "hour ago"
    static let HoursAgo = "hours ago"
    static let MinuteAgo = "minute ago"
    static let MinutesAgo = "minutes ago"
    static let MomentAgo = "a moment ago"
}


//extension Bundle {
//    private static var bundle: Bundle!
//
//    public static func localizedBundle() -> Bundle! {
////        if bundle == nil {
////            let appLang = UserDefaults.standard.string(forKey: "app_lang") ?? "en"
////            let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
////            bundle = Bundle(path: path!)
////        }
//        let appLang =  "en"
//        let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
//        bundle = Bundle(path: path!)
//        return bundle;
//    }
//
//    public static func setLanguage(lang: String) {
//        UserDefaults.standard.set(lang, forKey: "app_lang")
//        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
//        bundle = Bundle(path: path!)
//    }
//}

extension String {
//    func localized() -> String {
//
//        return NSLocalizedString(self, tableName: nil, bundle: Bundle.localizedBundle(), value: "", comment: "")
//    }

//    func localizeWithFormat(arguments: CVarArg...) -> String{
//        return String(format: self.localized(), arguments: arguments)
//    }
//    
//    func localizedWithAttributes(fontName: String, fontsize: CGFloat) -> NSAttributedString{
//        return NSAttributedString(string: self.localized(), attributes: [NSAttributedString.Key.font : UIFont(name: fontName, size: fontsize) ?? UIFont.systemFont(ofSize: fontsize)])
//    }
}
