//
//  AdobeXMPToolKit.h
//  XMPFramework
//
//  Created by Filip Busic on 8/11/18.
//

#ifndef AdobeXMPToolKit_h
#define AdobeXMPToolKit_h

#include <string>
#include <iostream>

// Must be defined to instantiate template classes
#define TXMP_STRING_TYPE std::string

// Must be defined to give access to XMPFiles
#define XMP_INCLUDE_XMPFILES 1

#define XMPUtilsDomain @"org.cocoapods.XMPFramework"

// Ensure XMP templates are instantiated
#include "XMP_incl.hpp"

// Provide access to the API
#include "XMP.hpp"

#endif /* AdobeXMPToolKit_h */
