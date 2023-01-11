// initial point
var initial_point = Point(lng: 35.038810, lat: 48.471207);
// radius
var cool_places = CoolPlacesNearMe(SetInitialPoint: initial_point, RadiusToFind: 10)
let real_cool_places = cool_places.GetCoolPlaces()
if (real_cool_places != nil){
  for var place in real_cool_places!{
    print(place.name + " " + String(place.distance_from_point))
  }
}
