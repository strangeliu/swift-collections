//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift Collections open source project
//
// Copyright (c) 2022 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//


// #############################################################################
// #                                                                           #
// #            DO NOT EDIT THIS FILE; IT IS AUTOGENERATED.                    #
// #                                                                           #
// #############################################################################



// In single module mode, we need these declarations to be internal,
// but in regular builds we want them to be public. Unfortunately
// the current best way to do this is to duplicate all definitions.
#if COLLECTIONS_SINGLE_MODULE
extension FixedWidthInteger {
  @inlinable @inline(__always)
  internal var _nonzeroBitCount: Self {
    Self(truncatingIfNeeded: nonzeroBitCount)
  }

  @inlinable @inline(__always)
  internal func _rank(ofBit bit: UInt) -> Int {
    assert(bit < Self.bitWidth)
    let mask: Self = (1 &<< bit) &- 1
    return (self & mask).nonzeroBitCount
  }
}

extension UInt {
  @_effects(releasenone)
  @usableFromInline
  internal func _bit(ranked n: Int) -> UInt? {
    // FIXME: Use bit deposit instruction when available (PDEP on Intel).
    assert(UInt.bitWidth == 64 || UInt.bitWidth == 32,
           "Unsupported UInt bitWidth")

    var shift: Self = 0
    var n = Self(truncatingIfNeeded: n)

    if MemoryLayout<UInt>.size == 8 {
      let c32 = (self & 0xFFFFFFFF)._nonzeroBitCount
      if n >= c32 {
        shift &+= 32
        n &-= c32
      }
    } else {
      assert(MemoryLayout<Self>.size == 4, "Unknown platform")
    }

    let c16 = ((self &>> shift) & 0xFFFF)._nonzeroBitCount
    if n >= c16 {
      shift &+= 16
      n &-= c16
    }
    let c8 = ((self &>> shift) & 0xFF)._nonzeroBitCount
    if n >= c8 {
      shift &+= 8
      n &-= c8
    }
    let c4 = ((self &>> shift) & 0xF)._nonzeroBitCount
    if n >= c4 {
      shift &+= 4
      n &-= c4
    }
    let c2 = ((self &>> shift) & 0x3)._nonzeroBitCount
    if n >= c2 {
      shift &+= 2
      n &-= c2
    }
    let c1 = (self &>> shift) & 0x1
    if n >= c1 {
      shift &+= 1
      n &-= c1
    }
    guard n == 0 && (self &>> shift) & 0x1 == 1 else { return nil }
    return shift
  }
}

extension UInt32 {
  // Returns the position of the `n`th set bit in `self`, i.e., the bit with
  // rank `n`.
  @_effects(releasenone)
  @usableFromInline
  internal func _bit(ranked n: Int) -> UInt? {
    // FIXME: Use bit deposit instruction when available (PDEP on Intel).
    assert(n >= 0 && n < Self.bitWidth)
    var shift: Self = 0
    var n = Self(truncatingIfNeeded: n)
    let c16 = (self & 0xFFFF)._nonzeroBitCount
    if n >= c16 {
      shift = 16
      n -= c16
    }
    let c8 = ((self &>> shift) & 0xFF)._nonzeroBitCount
    if n >= c8 {
      shift &+= 8
      n -= c8
    }
    let c4 = ((self &>> shift) & 0xF)._nonzeroBitCount
    if n >= c4 {
      shift &+= 4
      n -= c4
    }
    let c2 = ((self &>> shift) & 0x3)._nonzeroBitCount
    if n >= c2 {
      shift &+= 2
      n -= c2
    }
    let c1 = (self &>> shift) & 0x1
    if n >= c1 {
      shift &+= 1
      n -= c1
    }
    guard n == 0, (self &>> shift) & 0x1 == 1 else { return nil }
    return UInt(truncatingIfNeeded: shift)
  }
}

extension UInt16 {
  // Returns the position of the `n`th set bit in `self`, i.e., the bit with
  // rank `n`.
  @_effects(releasenone)
  @usableFromInline
  internal func _bit(ranked n: Int) -> UInt? {
    // FIXME: Use bit deposit instruction when available (PDEP on Intel).
    assert(n >= 0 && n < Self.bitWidth)
    var shift: Self = 0
    var n = Self(truncatingIfNeeded: n)
    let c8 = ((self &>> shift) & 0xFF)._nonzeroBitCount
    if n >= c8 {
      shift &+= 8
      n -= c8
    }
    let c4 = ((self &>> shift) & 0xF)._nonzeroBitCount
    if n >= c4 {
      shift &+= 4
      n -= c4
    }
    let c2 = ((self &>> shift) & 0x3)._nonzeroBitCount
    if n >= c2 {
      shift &+= 2
      n -= c2
    }
    let c1 = (self &>> shift) & 0x1
    if n >= c1 {
      shift &+= 1
      n -= c1
    }
    guard n == 0, (self &>> shift) & 0x1 == 1 else { return nil }
    return UInt(truncatingIfNeeded: shift)
  }
}
#else // !COLLECTIONS_SINGLE_MODULE
extension FixedWidthInteger {
  @inlinable @inline(__always)
  internal var _nonzeroBitCount: Self {
    Self(truncatingIfNeeded: nonzeroBitCount)
  }

  @inlinable @inline(__always)
  public func _rank(ofBit bit: UInt) -> Int {
    assert(bit < Self.bitWidth)
    let mask: Self = (1 &<< bit) &- 1
    return (self & mask).nonzeroBitCount
  }
}

extension UInt {
  @_effects(releasenone)
  //@usableFromInline
  public func _bit(ranked n: Int) -> UInt? {
    // FIXME: Use bit deposit instruction when available (PDEP on Intel).
    assert(UInt.bitWidth == 64 || UInt.bitWidth == 32,
           "Unsupported UInt bitWidth")

    var shift: Self = 0
    var n = Self(truncatingIfNeeded: n)

    if MemoryLayout<UInt>.size == 8 {
      let c32 = (self & 0xFFFFFFFF)._nonzeroBitCount
      if n >= c32 {
        shift &+= 32
        n &-= c32
      }
    } else {
      assert(MemoryLayout<Self>.size == 4, "Unknown platform")
    }

    let c16 = ((self &>> shift) & 0xFFFF)._nonzeroBitCount
    if n >= c16 {
      shift &+= 16
      n &-= c16
    }
    let c8 = ((self &>> shift) & 0xFF)._nonzeroBitCount
    if n >= c8 {
      shift &+= 8
      n &-= c8
    }
    let c4 = ((self &>> shift) & 0xF)._nonzeroBitCount
    if n >= c4 {
      shift &+= 4
      n &-= c4
    }
    let c2 = ((self &>> shift) & 0x3)._nonzeroBitCount
    if n >= c2 {
      shift &+= 2
      n &-= c2
    }
    let c1 = (self &>> shift) & 0x1
    if n >= c1 {
      shift &+= 1
      n &-= c1
    }
    guard n == 0 && (self &>> shift) & 0x1 == 1 else { return nil }
    return shift
  }
}

extension UInt32 {
  // Returns the position of the `n`th set bit in `self`, i.e., the bit with
  // rank `n`.
  @_effects(releasenone)
  //@usableFromInline
  public func _bit(ranked n: Int) -> UInt? {
    // FIXME: Use bit deposit instruction when available (PDEP on Intel).
    assert(n >= 0 && n < Self.bitWidth)
    var shift: Self = 0
    var n = Self(truncatingIfNeeded: n)
    let c16 = (self & 0xFFFF)._nonzeroBitCount
    if n >= c16 {
      shift = 16
      n -= c16
    }
    let c8 = ((self &>> shift) & 0xFF)._nonzeroBitCount
    if n >= c8 {
      shift &+= 8
      n -= c8
    }
    let c4 = ((self &>> shift) & 0xF)._nonzeroBitCount
    if n >= c4 {
      shift &+= 4
      n -= c4
    }
    let c2 = ((self &>> shift) & 0x3)._nonzeroBitCount
    if n >= c2 {
      shift &+= 2
      n -= c2
    }
    let c1 = (self &>> shift) & 0x1
    if n >= c1 {
      shift &+= 1
      n -= c1
    }
    guard n == 0, (self &>> shift) & 0x1 == 1 else { return nil }
    return UInt(truncatingIfNeeded: shift)
  }
}

extension UInt16 {
  // Returns the position of the `n`th set bit in `self`, i.e., the bit with
  // rank `n`.
  @_effects(releasenone)
  //@usableFromInline
  public func _bit(ranked n: Int) -> UInt? {
    // FIXME: Use bit deposit instruction when available (PDEP on Intel).
    assert(n >= 0 && n < Self.bitWidth)
    var shift: Self = 0
    var n = Self(truncatingIfNeeded: n)
    let c8 = ((self &>> shift) & 0xFF)._nonzeroBitCount
    if n >= c8 {
      shift &+= 8
      n -= c8
    }
    let c4 = ((self &>> shift) & 0xF)._nonzeroBitCount
    if n >= c4 {
      shift &+= 4
      n -= c4
    }
    let c2 = ((self &>> shift) & 0x3)._nonzeroBitCount
    if n >= c2 {
      shift &+= 2
      n -= c2
    }
    let c1 = (self &>> shift) & 0x1
    if n >= c1 {
      shift &+= 1
      n -= c1
    }
    guard n == 0, (self &>> shift) & 0x1 == 1 else { return nil }
    return UInt(truncatingIfNeeded: shift)
  }
}
#endif // COLLECTIONS_SINGLE_MODULE