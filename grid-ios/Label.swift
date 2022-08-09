//
//  Label.swift
//  grid-ios
//
//  Created by Brian Osborn on 8/5/22.
//

import Foundation

/**
 * Grid Label
 */
public class Label {
    
    /**
     * Name
     */
    public var name: String
    
    /**
     * Center point
     */
    public var center: GridPoint
    
    /**
     * Bounds
     */
    public var bounds: Bounds
    
    /**
     * Initialize
     *
     * @param width
     *            tile width
     * @param height
     *            tile height
     * @param x
     *            x coordinate
     * @param y
     *            y coordinate
     * @param zoom
     *            zoom level
     */
    public init(name: String, center: GridPoint, bounds: Bounds) {
        self.name = name
        self.center = center
        self.bounds = bounds
    }

}
