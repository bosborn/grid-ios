//
//  Line.swift
//  grid-ios
//
//  Created by Brian Osborn on 8/4/22.
//

import Foundation
import sf_ios

/**
 * Line between two points
 */
open class Line: SFLine {
    
    /**
     * Initialize
     *
     * @param point1
     *            first point
     * @param point2
     *            second point
     */
    public init(point1: GridPoint, point2: GridPoint) {
        super.init(hasZ: false, andHasM: false)
        setPoints(point1: point1, point2: point2)
    }
    
    /**
     * Initialize
     *
     * @param line
     *            line to copy
     */
    public init(line: Line) {
        super.init(hasZ: line.hasZ, andHasM: line.hasM)
        setPoints(point1: line.point1, point2: line.point2)
    }
    
    /**
     * The first point
     */
    public var point1: GridPoint {
        get {
            return startPoint() as! GridPoint
        }
        set(point1) {
            setPoints(point1: point1, point2: point2)
        }
    }
    
    /**
     * The second point
     */
    public var point2: GridPoint {
        get {
            return endPoint() as! GridPoint
        }
        set(point2) {
            setPoints(point1: point1, point2: point2)
        }
    }
    
    /**
     * Set the points
     *
     * @param point1
     *            first point
     * @param point2
     *            second point
     */
    public func setPoints(point1: GridPoint, point2: GridPoint) {
        var linePoints: [GridPoint] = []
        linePoints.append(point1)
        linePoints.append(point2)
        points = linePoints as? NSMutableArray
        validateUnits()
    }
    
    /**
     * The unit
     */
    public var unit: Unit {
        get {
            return point1.unit
        }
    }
    
    /**
     * Is in the provided unit type
     *
     * @param unit
     *            unit
     * @return true if in the unit
     */
    public func isUnit(unit: Unit) -> Bool {
        return point1.isUnit(unit: unit)
    }
    
    /**
     * Is this line in degrees
     *
     * @return true if degrees
     */
    public func isDegrees() -> Bool {
        return point1.isDegrees()
    }
    
    /**
     * Is this line in meters
     *
     * @return true if meters
     */
    public func isMeters() -> Bool {
        return point1.isMeters()
    }
    
    /**
     * Convert to the unit
     *
     * @param unit
     *            unit
     * @return line in units, same line if equal units
     */
    public func toUnit(unit: Unit) -> Line {
        var line: Line
        if (isUnit(unit: unit)) {
            line = self
        } else {
            line = mutableCopy() as! Line
            line.setPoints(point1: point1.toUnit(unit: unit), point2: point2.toUnit(unit: unit))
        }
        return line
    }
    
    /**
     * Convert to degrees
     *
     * @return line in degrees, same line if already in degrees
     */
    public func toDegrees() -> Line {
        return toUnit(unit: Unit.DEGREE)
    }
    
    /**
     * Convert to meters
     *
     * @return line in meters, same line if already in meters
     */
    public func toMeters() -> Line {
        return toUnit(unit: Unit.METER)
    }
    
    /**
     * Get the intersection between this line and the provided line
     *
     * @param line
     *            line
     * @return intersection
     */
    public func intersection(line: Line) -> GridPoint? {
        return GridUtils.intersection(line1: self, line2: line)
    }
    
    public override func mutableCopy(with zone: NSZone? = nil) -> Any {
        return Line(line: self)
    }
    
    public override func encode(with coder: NSCoder) {
        super.encode(with: coder)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func isEqual(line: Line?) -> Bool {
        if(self == line) {
            return true
        }
        if(line == nil) {
            return false
        }
        if(!super.isEqual(line)) {
            return false
        }
        return true
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        
        if(!(object is Line)) {
            return false
        }
        
        return isEqual(line: object as? Line)
    }

    public override var hash: Int {
        return super.hash
    }
    
    /**
     * Validate units are the same
     */
    private func validateUnits() {
        if (!point1.isUnit(unit: point2.unit)) {
            preconditionFailure("Points are in different units. point1: \(String(describing: point1.unit)), point2: \(String(describing: point2.unit)))")
        }
    }
    
}
