//
//  UploadVideoDataModel.swift
//  StoryDemo
//
//  Created by MAC-25 on 24/11/21.
//

import Foundation


struct UploadVideoData: Codable {
    var imageData: Data
    var videoURL: URL
    var imageType: String
    var videoType: String
    var title: String
    var description: String
    var countryName: String
    var isAnonymous: Int
    var myduration: String
}
