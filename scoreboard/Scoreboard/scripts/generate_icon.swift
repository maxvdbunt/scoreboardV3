#!/usr/bin/env swift
// generate_icon.swift
// Run this script on a Mac to generate the Scoreboard app icon.
// Usage: swift generate_icon.swift
//
// This creates a 1024x1024 PNG with:
// - Red background
// - Large "3" with a glass/glossy appearance
//
// Requires macOS with CoreGraphics/CoreText available.

import Foundation
import CoreGraphics
import CoreText

let size = 1024
let colorSpace = CGColorSpaceCreateDeviceRGB()

guard let context = CGContext(
    data: nil,
    width: size,
    height: size,
    bitsPerComponent: 8,
    bytesPerRow: 0,
    space: colorSpace,
    bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
) else {
    print("Failed to create graphics context")
    exit(1)
}

let rect = CGRect(x: 0, y: 0, width: size, height: size)

// --- Red background ---
context.setFillColor(CGColor(red: 0.85, green: 0.1, blue: 0.1, alpha: 1.0))
context.fill(rect)

// --- Subtle gradient overlay for depth ---
let gradientColors = [
    CGColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 0.4),
    CGColor(red: 0.6, green: 0.05, blue: 0.05, alpha: 0.3)
] as CFArray
let gradientLocations: [CGFloat] = [0.0, 1.0]
if let gradient = CGGradient(colorsSpace: colorSpace, colors: gradientColors, locations: gradientLocations) {
    context.drawLinearGradient(
        gradient,
        start: CGPoint(x: Double(size) / 2, y: Double(size)),
        end: CGPoint(x: Double(size) / 2, y: 0),
        options: []
    )
}

// --- Draw the "3" ---
let text = "3" as CFString
let fontSize: CGFloat = 700

// Create the font
let font = CTFontCreateWithName("HelveticaNeue-Bold" as CFString, fontSize, nil)

// Create attributed string
let attributes: [NSAttributedString.Key: Any] = [
    .font: font,
    .foregroundColor: CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.95)
]

let attrString = NSAttributedString(string: "3", attributes: attributes)
let line = CTLineCreateWithAttributedString(attrString)
let lineBounds = CTLineGetBoundsWithOptions(line, .useGlyphPathBounds)

// Center the text
let xPos = (CGFloat(size) - lineBounds.width) / 2 - lineBounds.origin.x
let yPos = (CGFloat(size) - lineBounds.height) / 2 - lineBounds.origin.y

context.textPosition = CGPoint(x: xPos, y: yPos)
CTLineDraw(line, context)

// --- Glass highlight overlay on the "3" ---
// Add a subtle white-to-transparent gradient in the top half
context.saveGState()

// Create a clipping path using the text shape
let textPath = CGMutablePath()
textPath.addRect(CGRect(x: 0, y: CGFloat(size) / 2, width: CGFloat(size), height: CGFloat(size) / 2))
context.addPath(textPath)
context.clip()

let glassColors = [
    CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.15),
    CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
] as CFArray
if let glassGradient = CGGradient(colorsSpace: colorSpace, colors: glassColors, locations: [0.0, 1.0]) {
    context.drawLinearGradient(
        glassGradient,
        start: CGPoint(x: Double(size) / 2, y: Double(size)),
        end: CGPoint(x: Double(size) / 2, y: Double(size) / 2),
        options: []
    )
}

context.restoreGState()

// --- Save the image ---
guard let image = context.makeImage() else {
    print("Failed to create image")
    exit(1)
}

let outputURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    .appendingPathComponent("Scoreboard")
    .appendingPathComponent("Assets.xcassets")
    .appendingPathComponent("AppIcon.appiconset")
    .appendingPathComponent("AppIcon.png")

guard let destination = CGImageDestinationCreateWithURL(outputURL as CFURL, "public.png" as CFString, 1, nil) else {
    print("Failed to create image destination at: \(outputURL.path)")
    exit(1)
}

CGImageDestinationAddImage(destination, image, nil)

if CGImageDestinationFinalize(destination) {
    print("✅ App icon saved to: \(outputURL.path)")
} else {
    print("❌ Failed to save app icon")
    exit(1)
}
