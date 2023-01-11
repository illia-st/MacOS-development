import Foundation

public struct Places: Codable {
    let candidates: [Candidate]
}
public struct Candidate: Codable {
    let geometry: Geometry
    let name: String
}
public struct Geometry: Codable {
    let location: Location
}
public struct Location: Codable {
    let lat, lng: Double
}

public class JsonParser{

    private var m_path_to_file: String = ""
    private var json_data: Data?
    public init(){
        json_data = readLocalFile()
    }
    private func readLocalFile() -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: "Places",
                    ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    public func parse() -> Places? {
        if (json_data == nil){
            return nil
        }
        do{
            let places = try? JSONDecoder().decode(Places.self, from: json_data ?? Data())
            print(places?.candidates.count)
            return places
        }catch{
            print(error)
        }
        return nil
    }
}
