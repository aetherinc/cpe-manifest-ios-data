//
//  NGDMTimedEvent.swift
//  NextGen
//
//  Created by Alec Ananian on 3/8/16.
//  Copyright © 2016 Warner Bros. Entertainment, Inc. All rights reserved.
//

import Foundation

class NGDMTimedEvent: NSObject {
    
    private var _manifestObject: NGETimedEventType!
    
    private var _id: String!
    var id: String {
        get {
            if _id == nil {
                if isAudioVisual() {
                    _id = _manifestObject.PresentationID
                } else if isGallery() {
                    _id = _manifestObject.GalleryID
                } else if isAppGroup() {
                    _id = _manifestObject.AppGroupID
                } else if isTextItem() {
                    _id = "\(_manifestObject.TextGroupID.value)\(_manifestObject.TextGroupID.index)"
                } else {
                    _id = ""
                }
            }
            
            return _id
        }
    }
    
    var startTime: Double {
        get {
            if let str = _manifestObject.StartTimecode.value {
                return Double(str)!
            }
            
            return -1
        }
    }
    
    var endTime: Double {
        get {
            if let str = _manifestObject.EndTimecode.value {
                return Double(str)!
            }
            
            return -1
        }
    }
    
    var text: String? {
        get {
            if isTextItem() {
                if let textGroupId = _manifestObject.TextGroupID.value, textGroupIndex = _manifestObject.TextGroupID.index, textGroup = NGDMTextGroup.getById(textGroupId) {
                    return textGroup.textItem(textGroupIndex)
                }
            }
            
            return nil
        }
    }
    
    var appGroup: NGDMAppGroup? {
        get {
            if isAppGroup() {
                return NGDMAppGroup.getById(_manifestObject.AppGroupID)
            }
            
            return nil
        }
    }
    
    init(manifestObject: NGETimedEventType) {
        _manifestObject = manifestObject
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let otherTimedEvent = object as? NGDMTimedEvent {
            return id == otherTimedEvent.id
        }
        
        return false
    }
    
    func isTextItem() -> Bool {
        return _manifestObject.TextGroupID != nil
    }
    
    func isAudioVisual() -> Bool {
        return _manifestObject.PresentationID != nil
    }
    
    func isGallery() -> Bool {
        return _manifestObject.GalleryID != nil
    }
    
    func isAppGroup() -> Bool {
        return _manifestObject.AppGroupID != nil
    }
    
    func isProduct(namespace: String) -> Bool {
        if let productId = _manifestObject.ProductID {
            return productId.Namespace == namespace
        }
        
        return false
    }
    
    func getAudioVisual(experience: NGDMExperience) -> NGDMAudioVisual? {
        if isAudioVisual() {
            return experience.audioVisuals[_manifestObject.PresentationID]
        }
        
        return nil
    }
    
    func getGallery(experience: NGDMExperience) -> NGDMGallery? {
        if isGallery() {
            return experience.galleries[_manifestObject.GalleryID]
        }
        
        return nil
    }
    
    func getExperienceApp(experience: NGDMExperience) -> NGDMExperienceApp? {
        if isAppGroup() {
            return experience.apps[_manifestObject.AppGroupID]
        }
        
        return nil
    }
    
    func getDescriptionText(experience: NGDMExperience) -> String? {
        if isAudioVisual() {
            return getAudioVisual(experience)?.metadata?.title
        }
        
        if isTextItem() {
            return text
        }
        
        return nil
    }
    
    func getImageURL(experience: NGDMExperience) -> NSURL? {
        if isAudioVisual() {
            return getAudioVisual(experience)?.getImageURL()
        }
        
        if isAppGroup() {
            return getExperienceApp(experience)?.getImageURL()
        }
        
        return nil
    }
    
}