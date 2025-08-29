//
//  metadata.cpp
//  OpenAttributeGraphCxx
//
//  Audited for iOS 18.0
//  Status: WIP

#include <OpenAttributeGraphCxx/Runtime/metadata.hpp>

#ifdef OPENATTRIBUTEGRAPH_SWIFT_TOOLCHAIN_SUPPORTED

using OAG::swift::metadata;

void metadata::append_description(CFMutableStringRef description) const OAG_NOEXCEPT {
    // TODO
}

#endif /* OPENATTRIBUTEGRAPH_SWIFT_TOOLCHAIN_SUPPORTED */
