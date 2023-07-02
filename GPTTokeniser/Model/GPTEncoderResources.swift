//
//  GPTEncoderResources.swift
//
//
//  Created by Arnav Singhal on 02/07/23.
//

import Foundation

public final class GPTEncoderResources {
    public static let resourceBundle: Bundle = {
        let candidates = [
            Bundle.main.resourceURL,
            Bundle(for: GPTEncoderResources.self).resourceURL,
        ]

        let bundleName = "GPTEncoder_GPTEncoder"

        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        return Bundle(for: GPTEncoderResources.self)
    }()
}
