//
//  Enums.swift
//  TuVozNow
//
//  Created by mac-14 on 08/04/20.
//  Copyright © 2020 zokoo. All rights reserved.
//

import Foundation
import UIKit


//MARK: Storyboard Names
enum StoryboardNames{
    static let Main = "Main"
    static let Home = "Home"
    static let Search = "Search"
}

//MARK: View Controller Identifiers
enum ViewContollerIdentifiers{
    //Sign Up
    static let ViewController = "ViewController"
    static let SelectLanguageViewController = "SelectLanguageViewController"
    static let LogInViewController = "LogInViewController"
    static let SignUpViewController = "SignUpViewController"
    static let ChooseMembershipViewController = "ChooseMembershipViewController"
    static let SuccessViewController = "SuccessViewController"
    static let ChoosePaymentMethodViewController = "ChoosePaymentMethodViewController"
    static let CardInformationViewController = "CardInformationViewController"
    static let ForgotPasswordViewController = "ForgotPasswordViewController"
    static let videocallVC = "VideoCallVC"
    static let OTPViewController = "OTPViewController"
    static let ResetPasswordViewController = "ResetPasswordViewController"
    static let ChatVc = "ChatVC"
    static let CountryPickerViewController = "CountryPickerViewController"
    static let AgeConfirmationViewController = "AgeConfirmationViewController"
    static let TermsAndServiceViewController = "TermsAndServiceViewController"
    //Home
    static let HomeTabBarVC = "HomeTabBarVC"
    static let WorldwideVC = "WorldwideVC"
    static let ByRegionVC = "ByRegionVC"
    static let HomeSegmentedVC = "HomeSegmentedVC"
    static let MorePopularVideoViewController = "MorePopularVideoViewController"
    //Following
    static let FollowingSegmentViewController = "FollowingSegmentViewController"
    static let RegionViewController = "RegionViewController"
    static let PeopleViewController = "PeopleViewController"
    static let RegionDetailsViewController = "RegionDetailsViewController"
    //Uploading
    static let UploadVideoVC = "UploadVideoVC"
    static let VideoDetailsVC = "VideoDetailsVC"
    static let VideoAuthenticationVC = "VideoAuthenticationVC"
    static let VideoSuccessPopVc = "VideoSuccessPopVc"
    static let TrimerViewController = "TrimerViewController"
    //Inbox
    static let InboxSegmentedViewController = "InboxSegmentedViewController"
    static let MessageListViewController = "MessageListViewController"
    static let RequestsViewController = "RequestsViewController"
    static let ChatWindowViewController = "ChatWindowViewController"
    //Profile
    static let ProfileViewController = "ProfileViewController"
    static let PublicProfileViewController = "PublicProfileViewController"
    static let FollowersListViewController = "FollowersListViewController"
    static let FollowingListViewController = "FollowingListViewController"
    static let LikedVideoListViewController = "LikedVideoListViewController"
    static let SavedVideoListViewController = "SavedVideoListViewController"
    static let MembershipViewController = "MembershipViewController"
    //VideoPlayer
    static let VideoPlayerViewController = "VideoPlayerViewController"
    static let LandscapeVideoPlayerViewController = "LandscapeVideoPlayerViewController"
    static let NewVideoPlayerViewController = "NewVideoPlayerViewController"
    //UserProfileViewController
    static let UserProfileViewController = "UserProfileViewController"
    //Search
    static let SearchViewController = "SearchViewController"
    static let SearchResultViewController = "SearchResultViewController"
    static let FilterViewController = "FilterViewController"
    //flag
    static let FlagListViewController = "FlagListViewController"
    static let VideoPlayerWithDetailsViewController = "VideoPlayerWithDetailsViewController"
}

//MARK: Cell Identifiers
enum CellIdentifiers {
    //Sign Up
    static let CountryPickerTableViewCell = "CountryPickerTableViewCell"
    static let LanguagePickerTableViewCell = "LanguagePickerTableViewCell"
    //Home
    static let RegionTableViewCell = "RegionTableViewCell"
    static let TopVideosTableViewCell = "TopVideosTableViewCell"
    static let VideoTitileTableViewCell = "VideoTitileTableViewCell"
    static let PopularTableViewCell = "PopularTableViewCell"
    static let VideoCollectionViewCell = "VideoCollectionViewCell"
    static let TopVideoCollectionViewCell = "TopVideoCollectionViewCell"
    static let MoreVideosCollectionViewCell = "MoreVideosCollectionViewCell"
    //Following
    static let FollowingRegionsTableViewCell = "FollowingRegionsTableViewCell"
    static let PeopleFollowingTableViewCell = "PeopleFollowingTableViewCell"
    static let PeopleFollowingTitleTableViewCell = "PeopleFollowingTitleTableViewCell"
    //Upload
    static let GalleryCollectionViewCell = "GalleryCollectionViewCell"
    //Inbox
    static let MessagesTableViewCell = "MessagesTableViewCell"
    static let RequestsTableViewCell = "RequestsTableViewCell"
    //Profile
    static let ProfileCategoryTableViewCell = "ProfileCategoryTableViewCell"
    static let ProfileTableViewCell = "ProfileTableViewCell"
    static let MyVideosTableViewCell = "MyVideosTableViewCell"
    static let MyVideosWithTitleTableViewCell = "MyVideosWithTitleTableViewCell"
    static let FollowersTableViewCell = "FollowersTableViewCell"
    static let SavedVideosTableViewCell = "SavedVideosTableViewCell"
    static let CommentsTableViewCell = "CommentsTableViewCell"
    static let UserInfoTableViewCell = "UserInfoTableViewCell"
    //Search
    static let SearchTableViewCell = "SearchTableViewCell"
    static let SearchRegionTableViewCell = "SearchRegionTableViewCell"
    static let SearchPersonTableViewCell = "SearchPersonTableViewCell"
    static let SearchVideosTableViewCell = "SearchVideosTableViewCell"
    //video
    static let VideoDetailsTableViewCell = "VideoDetailsTableViewCell"
    static let UserProfileVideoDetailsTableViewCell = "UserProfileVideoDetailsTableViewCell"
    static let LikeSaveDownloadTableViewCell = "LikeSaveDownloadTableViewCell"
    static let CommentsTitleTableViewCell = "CommentsTitleTableViewCell"
    //flag
    static let FlagListTableViewCell = "FlagListTableViewCell"
}

//MARK: Nib Identifiers
enum NibIdentifiers {
    //Sign Up
    static let CountryPickerTableViewCell = "CountryPickerTableViewCell"
    static let LanguagePickerTableViewCell = "LanguagePickerTableViewCell"
    //Home
    static let RegionTableViewCell = "RegionTableViewCell"
    static let TopVideosTableViewCell = "TopVideosTableViewCell"
    static let VideoTitileTableViewCell = "VideoTitileTableViewCell"
    static let PopularTableViewCell = "PopularTableViewCell"
    static let VideoCollectionViewCell = "VideoCollectionViewCell"
    static let TopVideoCollectionViewCell = "TopVideoCollectionViewCell"
    static let MoreVideosCollectionViewCell = "MoreVideosCollectionViewCell"
    //Following
    static let FollowingRegionsTableViewCell = "FollowingRegionsTableViewCell"
    static let PeopleFollowingTableViewCell = "PeopleFollowingTableViewCell"
    static let PeopleFollowingTitleTableViewCell = "PeopleFollowingTitleTableViewCell"
    //Upload
    static let GalleryCollectionViewCell = "GalleryCollectionViewCell"
    //Inbox
    static let MessagesTableViewCell = "MessagesTableViewCell"
    static let RequestsTableViewCell = "RequestsTableViewCell"
    //Profile
    static let ProfileCategoryTableViewCell = "ProfileCategoryTableViewCell"
    static let ProfileTableViewCell = "ProfileTableViewCell"
    static let MyVideosTableViewCell = "MyVideosTableViewCell"
    static let MyVideosWithTitleTableViewCell = "MyVideosWithTitleTableViewCell"
    static let FollowersTableViewCell = "FollowersTableViewCell"
    static let SavedVideosTableViewCell = "SavedVideosTableViewCell"
    static let CommentsTableViewCell = "CommentsTableViewCell"
    static let UserInfoTableViewCell = "UserInfoTableViewCell"
    //Seach
    static let SearchTableViewCell = "SearchTableViewCell"
    static let SearchRegionTableViewCell = "SearchRegionTableViewCell"
    static let SearchPersonTableViewCell = "SearchPersonTableViewCell"
    static let SearchVideosTableViewCell = "SearchVideosTableViewCell"
    //video
    static let VideoDetailsTableViewCell = "VideoDetailsTableViewCell"
    static let UserProfileVideoDetailsTableViewCell = "UserProfileVideoDetailsTableViewCell"
    static let LikeSaveDownloadTableViewCell = "LikeSaveDownloadTableViewCell"
    static let CommentsTitleTableViewCell = "CommentsTitleTableViewCell"
    //flag
    static let FlagListTableViewCell = "FlagListTableViewCell"
}

//MARK: APP Colors
enum APPColor{
    static let APP_BG = UIColor(named: "APP_BG")
    static let APP_BLACK = UIColor(named: "APP_BLACK")
    static let APP_DARK_GRAY = UIColor(named: "APP_DARK_GRAY")
    static let APP_LIGHT_BG = UIColor(named: "APP_LIGHT_BG")
    static let APP_Light_Gray = UIColor(named: "APP_Light_Gray")
    static let APP_RED = UIColor(named: "APP_RED")
    static let APP_Text_Gray = UIColor(named: "APP_Text_Gray")
    static let APP_TEXTColor = UIColor(named: "APP_TEXTColor")
    static let APP_THEME = UIColor(named: "APP_THEME")
    static let APP_WHITE = UIColor(named: "APP_WHITE")
    
    static let APP_GRAY = UIColor(named: "APP_Gray")
    static let APP_BGColor = UIColor(red: 229/255, green: 231/255, blue: 236/255, alpha: 1.0)
    static let APP_RGB_APPGray = UIColor(red: 199/255, green: 202/255, blue: 211/255, alpha: 1.0)
}


//UserDefaults Key
enum UserDefaultsKey{
    static let isLoggedIn = "isLoggedIn"
    static let fcmToken = "fcmToken"
    static let isNotFirstTimeLaunch = "isFirstTimeLaunch"
    static let isFromOTPScreen = "isFromOTPScreen"
    static let isFromForgotPassword = "isFromForgotPassword"
    static let isFromVideoAuthentication = "isFromVideoAuthentication"
    static let isFromSignUpScreen = "isFromSignUpScreen"
    static let isFromVideoOTPScreen = "isFromVideoOTPScreen"
    static let token = "token"
    static let userName = "userName"
    static let profileImage = "profileImage"
    static let FileImage = "FileImage"
    static let phoneNumber = "PhoneNumber"
    static let userID = "UserID"
    static let appLanguage = "app_lang"
    static let bio = "bio"
    static let membership = "membership"
    static let payment = "payment"
    static let status = "status"
    static let createdAt = "created_at"
    static let updatedAt = "updated_at"
    static let followersCount = "followers_count"
    static let videosCount = "videos_count"
   
    static let signUpPassword = "signUpPassword"
    static let countDownTime = "countDownTime"
    //Filter For Search
    static let selectedSearchByCategory = "selectedSearchByCategory"
    static let selectedUploadDateCategory = "selectedUploadDateCategory"
    static let selectedShowCategory = "selectedShowCategory"
    //User Profile
    static let lastVideoUploadedTime = "lastVideoUploadedTime"
    //Video Screen
    static let fullScreenStartTime = "fullScreenStartTime"
}


//Notification Names
enum NotificationNames{
    static let TopVideosData = "TopVideosData"
    static let PopularVideoData = "PopularVideoData"
    static let RegionVideosData = "RegionVideosData"
    static let RegionArray = "RegionArray"
    static let FollowingRegionArray = "FollowingRegionArray"
    static let UploadVideoStatus = "UploadVideoStatus"
    static let sceneDidEnterBackground = "sceneDidEnterBackground"
    static let PeopleRecentVideos = "PeopleRecentVideos"
    static let RequestedUsersArray = "RequestedUsersArray"
    static let newConversation = "newConversation"
    static let MessageSendersArray = "MessageSendersArray"
    static let NotificationAllow = "NotificationAllow"
    static let NotificationNotAllow = "NotificationNotAllow"
}

//Keychain Keys
enum KeyChainKey{
    static let K_email = "email"
    static let K_Password = "Password"
}

//MimeTypes
enum MimeTypes1 {
    //Images
    static let jpeg = "image/jpeg"
    static let png = "image/png"
    static let jpg = "image/jpg"
    //Videos
    static let mp4 = "video/mp4"
    static let ogx = "video/ogx"
    static let oga = "video/oga"
    static let ogv = "video/ogv"
    static let ogg = "video/ogg"
    static let webm = "video/webm"
    static let mkv = "video/mkv"
    static let wom = "video/wom"
    static let mov = "video/mov"
}

//MimeTypes
enum MimeTypes{
    //Images
    static let jpeg = "image/jpeg"
    static let png = "image/png"
    static let jpg = "image/jpg"
    //Videos
    static let mp4 = "video/mp4"
    static let ogx = "video/ogx"
    static let oga = "video/oga"
    static let ogv = "video/ogv"
    static let ogg = "video/ogg"
    static let webm = "video/webm"
    static let mkv = "video/mkv"
    static let wom = "video/wom"
    static let mov = "video/mov"
    static let mov1 = "video/quicktime"
}

//SeachBy (Search Filter)
enum SearchByCategory{
    static let Relevance = "Relevance"
    static let Popularity = "Popularity"
    static let MostRecent = "MostRecent"
}
//Upload Date (Search Filter)
enum UploadDateCategory{
    static let AnyTime = "AnyTime"
    static let Today = "Today"
    static let ThisWeek = "ThisWeek"
    static let ThisMonth = "ThisMonth"
    static let ThisYear = "ThisYear"
}
//Show (Search Filter)
enum ShowCategoty {
    static let UsersAndRegions = "UsersAndRegions"
    static let Users = "Users"
    static let Regions = "Regions"
}

//Fonts
enum CustomFonts{
    //Lato
    static let Lato_Black = "Lato-Black"
    static let Lato_BlackItalic = "Lato-BlackItalic"
    static let Lato_Bold = "Lato-Bold"
    static let Lato_BoldItalic = "Lato-BoldItalic"
    static let Lato_Italic = "Lato-Italic"
    static let Lato_Light = "Lato-Light"
    static let Lato_LightItalic = "Lato-LightItalic"
    static let Lato_Regular = "Lato-Regular"
    static let Lato_Thin = "Lato-Thin"
    static let Lato_ThinItalic = "Lato-ThinItalic"
    //Volkorn
    static let Vollkorn_Bold = "Vollkorn-Bold"
    static let Vollkotn_SemiBold = "Vollkorn-SemiBold"
}
