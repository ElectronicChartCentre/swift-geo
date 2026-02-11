//
//  File.swift
//  swift-geo
//

import Foundation

public struct GeoJSONDecoder {
    
    public static func parseFeature(data: Data, creator: GeometryCreator) -> Feature? {
        do {
            guard let decoded = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            
            guard let type = decoded["type"] as? String, type == "Feature" else {
                return nil
            }
            
            let properties = decoded["properties"] as? [String: Any] ?? [:]
            
            guard let geoJSONGeometry = decoded["geometry"] as? [String: Any], let geometry = parseGeometry(decoded: geoJSONGeometry, creator: creator) else {
                return nil
            }
            
            return Feature(properties: properties, geometry: geometry)
            
        } catch {
            print("ERROR: Could not decode Feature \(error)")
            return nil
        }
    }
    
    public static func parseGeometry(data: Data, creator: GeometryCreator) -> Geometry? {
        do {
            guard let decoded = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return parseGeometry(decoded: decoded, creator: creator)
        } catch {
            print("ERROR: Could not decode Geometry \(error)")
            return nil
        }
    }
    
    private static func parseGeometry(decoded: [String: Any], creator: GeometryCreator) -> Geometry? {
        guard let geometryType = decoded["type"] as? String else {
            return nil
        }
        
        guard let geoJSONCoordinates = decoded["coordinates"] else {
            return nil
        }
        
        if let singleCoordinate = geoJSONCoordinates as? [Double], let coord = coordinate(singleCoordinate, creator: creator) {
            switch geometryType {
            case "Point":
                return creator.createPoint(coord: coord)
            default:
                print("ERROR: Unsupported single coordinate Geometry Type: \(geometryType)")
                return nil
            }
        }
        
        if let multiCoordinates = geoJSONCoordinates as? [[Double]] {
            let coords = coordinates(multiCoordinates, creator: creator)
            switch geometryType {
            case "LineString":
                return creator.createLineString(coords: coords)
            case "MultiPoint":
                return creator.createMultiPoint(coords: coords)
            default:
                print("ERROR: Unsupported Geometry Type: \(geometryType)")
                return nil
            }
        }
        
        if let multiMultiCoordinates = geoJSONCoordinates as? [[[Double]]] {
            let coordss = coordinatess(multiMultiCoordinates, creator: creator)
            switch geometryType {
            case "Polygon":
                let shell = creator.createLinearRing(coords: coordss[0])
                var holes: [any LinearRing] = []
                for (i, cords) in coordss.enumerated() where i != 0 {
                    let hole = creator.createLinearRing(coords: cords)
                    holes.append(hole)
                }
                return creator.createPolygon(shell: shell, holes: holes)
            default:
                print("ERROR: Unsupported Geometry Type: \(geometryType)")
                return nil
            }
        }
        
        print("ERROR: Could not decode geometry: \(decoded)")
        return nil
    }
    
    private static func coordinate(_ pair: [Double], creator: GeometryCreator) -> (any Coordinate)? {
        switch pair.count {
        case 2:
            return creator.createCoordinate2D(x: pair[0], y: pair[1])
        case 3:
            return creator.createCoordinate3D(x: pair[0], y: pair[1], z: pair[2])
        default:
            return nil
        }
    }
    
    private static func coordinates(_ cs: [[Double]], creator: GeometryCreator) -> [any Coordinate] {
        var r: [any Coordinate] = []
        for pair in cs {
            if let coordinate = coordinate(pair, creator: creator) {
                r.append(coordinate)
            }
        }
        return r
    }
    
    private static func coordinatess(_ css: [[[Double]]], creator: GeometryCreator) -> [[any Coordinate]] {
        var r: [[any Coordinate]] = []
        for cs in css {
            let coordinates = coordinates(cs, creator: creator)
            r.append(coordinates)
        }
        return r
    }
    
}
