//
//  File.swift
//  swift-collections
//
//  Created by Jian Liu on 2025/1/7.
//

import Foundation

extension Deque {
    
    @inlinable
    public func copyContents(
        to destination: UnsafeMutablePointer<Element>,
        length: Int
    ) {
        guard length > 0 else { return }
        return _storage.read { handle in
            let endSlot = handle.startSlot.advanced(by: length)
            if endSlot.position <= handle.capacity {
                let buffer = handle.buffer(for: handle.startSlot ..< endSlot)
                destination.initialize(from: buffer.baseAddress!, count: length)
            } else {
                let subfixLength = handle.capacity - handle.startSlot.position
                let prefixBuffer = handle.buffer(for: handle.startSlot ..< .init(at: handle.capacity))
                destination.initialize(from: prefixBuffer.baseAddress!, count: subfixLength)
                let remainingLength = length - subfixLength
                let suffixBuffer = handle.buffer(for: .init(at: 0) ..< .init(at: remainingLength))
                destination.advanced(by: subfixLength).initialize(from: suffixBuffer.baseAddress!, count: remainingLength)
            }
        }
    }
}
