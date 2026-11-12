// Reads a scanned book with the text recogniser built into macOS (Apple Vision). Offline.
//
//   swift scan-ocr.swift <book.pdf | folder of page images | image> <outdir> [options]
//   swift scan-ocr.swift --languages
//
//   --lang <code[,code]>   language of the book, e.g. vi-VT, en-US, de-DE (default en-US)
//   --pages <first-last>   only these pages, 1-based (default: all)
//   --raw                  no language correction: a second reading to compare with the first
//   --no-images            do not write the page images
//
// Writes, for each page: NNNN.txt (the lines, a blank line between blocks), NNNN.json (every
// line with its box and confidence) and NNNN.jpg (the page, to look at when a line is in doubt).
// A page whose .json exists is skipped, so an interrupted run picks up where it stopped.

import AppKit
import PDFKit
import Vision

func fail(_ message: String) -> Never {
    FileHandle.standardError.write((message + "\n").data(using: .utf8)!)
    exit(2)
}

func supportedLanguages() -> [String] {
    let request = VNRecognizeTextRequest()
    request.recognitionLevel = .accurate
    return (try? request.supportedRecognitionLanguages()) ?? []
}

var positional: [String] = []
var languages = ["en-US"]
var pageRange: (Int, Int)?
var raw = false
var writeImages = true

var args = Array(CommandLine.arguments.dropFirst())
while !args.isEmpty {
    let arg = args.removeFirst()
    switch arg {
    case "--languages":
        print(supportedLanguages().joined(separator: "\n"))
        exit(0)
    case "--lang":
        guard !args.isEmpty else { fail("--lang needs a language code") }
        languages = args.removeFirst().split(separator: ",").map(String.init)
    case "--pages":
        guard !args.isEmpty else { fail("--pages needs <first-last>") }
        let parts = args.removeFirst().split(separator: "-").compactMap { Int($0) }
        guard parts.count == 2, parts[0] >= 1, parts[0] <= parts[1] else {
            fail("--pages needs <first-last>, for example 1-40")
        }
        pageRange = (parts[0], parts[1])
    case "--raw": raw = true
    case "--no-images": writeImages = false
    default:
        if arg.hasPrefix("--") { fail("unknown option \(arg)") }
        positional.append(arg)
    }
}
guard positional.count == 2 else {
    fail("usage: scan-ocr.swift <book.pdf | folder of page images | image> <outdir> "
        + "[--lang vi-VT] [--pages 1-40] [--raw] [--no-images]\n       scan-ocr.swift --languages")
}

let supported = supportedLanguages()
for language in languages where !supported.contains(language) {
    fail("This macOS cannot read \(language). It reads: \(supported.joined(separator: ", "))")
}

let input = URL(fileURLWithPath: positional[0])
let outDir = URL(fileURLWithPath: positional[1])
let fm = FileManager.default
try? fm.createDirectory(at: outDir, withIntermediateDirectories: true)

let longSide: CGFloat = 3000
let imageTypes: Set<String> = ["png", "jpg", "jpeg", "tif", "tiff", "heic", "bmp", "gif"]

enum Source {
    case pdf(PDFDocument)
    case images([URL])

    var count: Int {
        switch self {
        case .pdf(let doc): return doc.pageCount
        case .images(let urls): return urls.count
        }
    }

    func page(_ n: Int) -> CGImage? {
        switch self {
        case .pdf(let doc):
            guard let page = doc.page(at: n - 1) else { return nil }
            let image = page.thumbnail(of: NSSize(width: longSide, height: longSide), for: .mediaBox)
            return image.cgImage(forProposedRect: nil, context: nil, hints: nil)
        case .images(let urls):
            return NSImage(contentsOf: urls[n - 1])?
                .cgImage(forProposedRect: nil, context: nil, hints: nil)
        }
    }
}

var isDir: ObjCBool = false
guard fm.fileExists(atPath: input.path, isDirectory: &isDir) else { fail("not found: \(input.path)") }
let source: Source
if isDir.boolValue {
    let urls = ((try? fm.contentsOfDirectory(at: input, includingPropertiesForKeys: nil)) ?? [])
        .filter { imageTypes.contains($0.pathExtension.lowercased()) }
        .sorted { $0.lastPathComponent.localizedStandardCompare($1.lastPathComponent) == .orderedAscending }
    guard !urls.isEmpty else { fail("no page images in \(input.path)") }
    source = .images(urls)
} else if input.pathExtension.lowercased() == "pdf" {
    guard let doc = PDFDocument(url: input) else { fail("cannot open \(input.path)") }
    source = .pdf(doc)
} else {
    source = .images([input])
}

let first = pageRange?.0 ?? 1
let last = min(pageRange?.1 ?? source.count, source.count)
guard first <= last else { fail("the source has \(source.count) pages") }

struct Line {
    let text: String
    let confidence: Double
    let x, y, w, h: Double
}

// Lines in reading order, with a blank line where the gap to the line above is wider than usual.
func pageText(_ lines: [Line]) -> String {
    let heights = lines.map(\.h).sorted()
    let typical = heights.isEmpty ? 0 : heights[heights.count / 2]
    var out = ""
    var previous: Line?
    for line in lines {
        if let p = previous {
            let gap = line.y - (p.y + p.h)
            out += gap > typical * 0.8 || gap < -typical ? "\n\n" : "\n"
        }
        out += line.text
        previous = line
    }
    return out + "\n"
}

var failed = 0
for n in first...last {
    let name = String(format: "%04d", n)
    let jsonURL = outDir.appendingPathComponent("\(name).json")
    if fm.fileExists(atPath: jsonURL.path) { continue }
    autoreleasepool {
        guard let image = source.page(n) else {
            print("page \(n): could not be rendered")
            failed += 1
            return
        }
        let request = VNRecognizeTextRequest()
        request.recognitionLevel = .accurate
        request.recognitionLanguages = languages
        request.usesLanguageCorrection = !raw
        request.automaticallyDetectsLanguage = false
        do {
            try VNImageRequestHandler(cgImage: image, options: [:]).perform([request])
        } catch {
            print("page \(n): \(error.localizedDescription)")
            failed += 1
            return
        }
        var lines: [Line] = []
        for observation in request.results ?? [] {
            guard let best = observation.topCandidates(1).first else { continue }
            let box = observation.boundingBox
            lines.append(Line(
                text: best.string, confidence: Double(best.confidence),
                x: Double(box.minX), y: Double(1 - box.maxY),
                w: Double(box.width), h: Double(box.height)))
        }
        let object: [String: Any] = [
            "page": n, "width": image.width, "height": image.height, "languages": languages,
            "languageCorrection": !raw,
            "lines": lines.map {
                ["text": $0.text, "conf": $0.confidence, "x": $0.x, "y": $0.y, "w": $0.w, "h": $0.h]
            },
        ]
        do {
            if writeImages {
                let rep = NSBitmapImageRep(cgImage: image)
                if let jpeg = rep.representation(using: .jpeg, properties: [.compressionFactor: 0.7]) {
                    try jpeg.write(to: outDir.appendingPathComponent("\(name).jpg"))
                }
            }
            try pageText(lines).write(
                to: outDir.appendingPathComponent("\(name).txt"), atomically: true, encoding: .utf8)
            // The .json goes last: it is what marks the page as done.
            try JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted, .sortedKeys])
                .write(to: jsonURL, options: .atomic)
        } catch {
            print("page \(n): \(error.localizedDescription)")
            failed += 1
            return
        }
        let unsure = lines.filter { $0.confidence < 0.5 }.count
        print("page \(n): \(lines.count) lines" + (unsure > 0 ? ", \(unsure) unsure" : ""))
    }
}
if failed > 0 { fail("\(failed) page(s) failed; run again to retry them") }
