//
//  File.swift
//  swift-geo
//

import Foundation

public struct GeoJSONEncoder {
    
    public static func encode(_ features: [Feature]) -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: toDictionary(features))
        } catch {
            print("ERROR: could not GeoJSON encode features. \(error)")
            return Data()
        }
    }
    
    public static func encode(_ feature: Feature) -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: toDictionary(feature))
        } catch {
            print("ERROR: could not GeoJSON encode feature. \(error)")
            return Data()
        }
    }
    
    public static func encode(_ geometry: Geometry) -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: toDictionary(geometry))
        } catch {
            print("ERROR: could not GeoJSON encode geometry. \(error)")
            return Data()
        }
    }
    
    private static func toDictionary(_ features: [Feature]) -> [String: Any] {
        var fc = [String: Any]()
        fc["type"] = "FeatureCollection"
        
        var fs = [[String: Any]]()
        for feature in features {
            fs.append(toDictionary(feature))
        }
        
        fc["features"] = fs
        return fc
    }

    
    private static func toDictionary(_ feature: Feature) -> [String: Any] {
        return ["type": "Feature", "properties": feature.properties, "geometry": toDictionary(feature.geometry)]
    }
    
    private static func toDictionary(_ geometry: Geometry) -> [String: Any] {
        if let point = geometry as? Point {
            return ["type": "Point", "coordinates": toArray(point.coordinate)]
        }
        if let lineString = geometry as? LineString {
            return ["type": "LineString", "coordinates": toArray(lineString.coordinates)]
        }
        if let linearRing = geometry as? LinearRing {
            return ["type": "LinearRing", "coordinates": toArray(linearRing.coordinates)]
        }
        if let multiPoint = geometry as? MultiPoint {
            return ["type": "MultiPoint", "coordinates": toArray(multiPoint.coordinates())]
        }
        if let polygon = geometry as? Polygon {
            var coordss = [[any Coordinate]]()
            coordss.append(polygon.shell.coordinates)
            for hole in polygon.holes {
                coordss.append(hole.coordinates)
            }
            return ["type": "Polygon", "coordinates": toArray(coordss)]
        }
        print("ERROR: unsupported geometry type in GeoJSONEncoder: \(type(of: geometry))")
        
        return [:]
    }
    
    private static func toArray(_ coordinate: any Coordinate) -> [Double] {
        if let c2d = coordinate as? DefaultCoordinate2D {
            return [c2d.x, c2d.y]
        }
        if let c3d = coordinate as? DefaultCoordinate3D {
            return [c3d.x, c3d.y, c3d.z]
        }
        return [coordinate.x, coordinate.y]
    }
    
    private static func toArray(_ coordinates: [any Coordinate]) -> [[Double]] {
        var coords = [[Double]]()
        for coordinate in coordinates {
            coords.append(toArray(coordinate))
        }
        return coords
    }
    
    private static func toArray(_ coordinatess: [[any Coordinate]]) -> [[[Double]]] {
        var coordss = [[[Double]]]()
        for coordinates in coordinatess {
            coordss.append(toArray(coordinates))
        }
        return coordss
    }

    
}
