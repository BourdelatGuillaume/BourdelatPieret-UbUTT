/**
 * This is the implementation Haversine Distance Algorithm between two places
 * @author ananth
 * R = earth’s radius (mean radius = 6,371km)
 Δlat = lat2− lat1
 Δlong = long2− long1
 a = sin²(Δlat/2) + cos(lat1).cos(lat2).sin²(Δlong/2)
 c = 2.atan2(√a, √(1−a))
 d = R.c
 *
 */

import Foundation
import GoogleMaps

public class HaversineCalculator {
    
    /**
     * RETURN DISTANCE BETWEEN TWO POINTS IN METER
     * **/
    public static func calculateDistance(p1: CLLocationCoordinate2D, p2: CLLocationCoordinate2D) -> Double {
        let latDistance = toRad(value: p2.latitude-p1.latitude);
        let lonDistance = toRad(value: p2.longitude-p1.longitude);
        let a = sin(latDistance / 2) * sin(latDistance / 2) + cos(toRad(value: p1.latitude)) * cos(toRad(value: p2.latitude)) * sin(lonDistance / 2) * sin(lonDistance / 2);
        return Double((Constants.earthRadiusInKM*1000))*(2 * atan2(sqrt(a), sqrt(1-a)));
    }
    
    private static func toRad(value: Double) -> Double{
        return value * Double.pi / 180;
    }
    
}
