//
//  Constants.swift
//  UbUTT
//
//  Created by if26-grp1 on 26/11/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import Foundation

public final class Constants{
    
    // GENERIC CONSTANTS
    public final let SUCCESS_RESULT:Int = 0
    public final let FAILURE_RESULT:Int = 1
    
    // PACKAGES CONSTANTS
    public final let RECEIVER:String = "com.google.android.gms.location.sample.locationaddress" + ".RECEIVER"
    public final let RESULT_DATA_KEY:String = "com.google.android.gms.location.sample.locationaddress" + ".RESULT_DATA_KEY"
    public final let LOCATION_DATA_EXTRA:String = "com.google.android.gms.location.sample.locationaddress" + ".LOCATION_DATA_EXTRA"
    public final let FETCH_ADDRESS_EXTRA:String = "com.google.android.gms.location.sample.locationaddress" + ".FETCH_ADDRESS_SERVICE"
    public final let  FETCH_ADDRESS_LATITUDE:String = "com.google.android.gms.location.sample.locationaddress" + ".FETCH_ADDRESS_LATITUDE"
    public final let  FETCH_ADDRESS_LONGITUDE:String = "com.google.android.gms.location.sample.locationaddress" + ".FETCH_ADDRESS_LONGITUDE"
    public final let  LAST_LOCATION_EXTRA:String = "utt.if26.ubutt" + ".last_location_extra"
    public final let  USER_EXTRA:String = "utt.if26.ubutt" + ".user_extra"
    public final let  COURSE_EXTRA:String = "utt.if26.ubutt" + ".course_extra"
    public final let  ORIGIN_EXTRA:String = "utt.if26.ubutt" + ".origin_extra"
    public final let  DESTINATION_EXTRA:String = "utt.if26.ubutt" + ".destination_extra"
    public final let  DESTINATION_LOCATION_EXTRA:String = "utt.if26.ubutt" + ".destLocation_extra"
    
    // PERMISSION CODE CONSTANTS
    public final let  LOCATION_PERMISSION_REQUEST_CODE:Int = 122
    public final let  READ_EXTERNAL_STORAGE_PERMISSION_REQUEST_CODE:Int = 123
    
    //REQUEST CODE FOR ACTIVITY RESULT CONSTANTS
    public final let  PROFILE_REQUEST_CODE:Int = 101
    public final let  IMAGE_REQUEST_CODE:Int = 102
    public final let  NOTE_REQUEST_CODE:Int = 103
    
    // MAP CONSTANTS
    public final let  DEFAULT_ZOOM:Float = 15.0
    public final let  DISTRICT_ZOOM:Float = 16.0
    public final let  TOWN_ZOOM:Float = 14.0
    
    // OTHERS CONSTANTS
    public final let  earthRadiusInKM:Int = 6371
    public final let  meterInDegree:Double = (1 / ((2 * Double.pi / 360) * 6378.137)) / 1000  //1 meter in degree
    public final let  pricePerMeter:Double = 0.011
}
