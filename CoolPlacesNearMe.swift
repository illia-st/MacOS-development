import Foundation

public struct Point{
    var lng: Double = 0.0
    var lat: Double = 0.0
}

class CoolPlacesNearMe {
    public struct CoolPlace{
        var name: String = ""
        var distance_from_point: Double
    }
    private var m_initial_location: Point
    private var m_radius: Double
    private var places: Places?
    
    public init(SetInitialPoint initial_location: Point, RadiusToFind radius: Double){
        
        m_initial_location = initial_location
        m_radius = radius
        var json_parser: JsonParser = JsonParser()
        places = json_parser.parse()
    }
    func deg2rad(deg: Double) -> Double {
        return deg * Double.pi / 180
    }
    func rad2deg(rad: Double) -> Double {
        return rad * 180.0 / Double.pi
    }
    func distance(lat1: Double, lng1: Double, lat2: Double, lng2: Double) -> Double{
        var d_lat1: Double = deg2rad(deg: lat1)
        var d_lng1: Double = deg2rad(deg: lng1)
        var d_lat2: Double = deg2rad(deg: lat2)
        var d_lng2: Double = deg2rad(deg: lng2)


        var dLat: Double = d_lat2 - d_lat1
        var dLng: Double = d_lng2 - d_lng1

        var ans = pow(sin(dLat / 2), 2) +
                cos(d_lat1) * cos(d_lat2) *
                pow(sin(dLng / 2), 2)

        ans = 2 * asin(sqrt(ans))

        var Earth_R: Double = 6371

        ans = ans * Earth_R

        return ans
    }

    public func GetCoolPlaces() -> [CoolPlace]?{
        if(places == nil){
            return nil
        }
        var cool_places: [CoolPlace] = []
        for var place in places!.candidates{
            var distance_in_km = distance(lat1: place.geometry.location.lat, lng1: place.geometry.location.lng,
                    lat2: m_initial_location.lat, lng2: m_initial_location.lng)
            if(distance_in_km <= m_radius){
                cool_places.append(CoolPlace(name: place.name, distance_from_point: distance_in_km))
            }
        }
        return cool_places
    }
}
