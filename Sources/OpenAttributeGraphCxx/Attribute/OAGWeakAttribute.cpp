//
//  OAGWeakAttribute.cpp
//  OpenAttributeGraphCxx

#include <OpenAttributeGraph/OAGWeakAttribute.h>

OAGWeakAttribute OAGCreateWeakAttribute(OAGAttribute attribute) {
    // TODO
    return {OAGAttributeNil , 0};
}

OAGAttribute OAGWeakAttributeGetAttribute(OAGWeakAttribute weakAttribute) {
    // TODO
    return OAGAttributeNil;
}

OAGWeakValue OAGGraphGetWeakValue(OAGWeakAttribute weakAttribute, OAGValueOptions options, OAGTypeID type) {
    // TODO
    return {nullptr, false};
}
