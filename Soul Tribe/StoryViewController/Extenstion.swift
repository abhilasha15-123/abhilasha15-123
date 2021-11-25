//
//  Extenstion.swift
//  StoryDemo
//
//  Created by MAC-25 on 24/11/21.
//

import Foundation
import AVKit
import AVFoundation
import UIKit


extension String {
    func fileExtension() -> String {
         return URL(fileURLWithPath: self).pathExtension
     }

}
//MARK: CMTime
extension CMTime {
    var roundedSeconds: TimeInterval {
        return seconds.rounded()
    }
    var hours:  Int { return Int(roundedSeconds / 3600) }
    var minute: Int { return Int(roundedSeconds.truncatingRemainder(dividingBy: 3600) / 60) }
    var second: Int { return Int(roundedSeconds.truncatingRemainder(dividingBy: 60)) }
    var positionalTime: String {
        return hours > 0 ?
            String(format: "%d:%02d:%02d",
                   hours, minute, second) :
            String(format: "%02d:%02d",
                   minute, second)
    }
}
