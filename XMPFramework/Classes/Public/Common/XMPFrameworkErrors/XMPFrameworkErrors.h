//
//  XMPFrameworkErrors.h
//  XMPFramework
//
//  Created by Filip Busic on 11/2/18.
//

#ifndef XMPFrameworkErrors_h
#define XMPFrameworkErrors_h

/* XMP Framework Error Codes */
enum XMPFrameworkErrorCodes {
  
  /* General Error(s) */
  XMPFrameworkErrorCodeGeneral = 100,
  
  /* Namespace Error(s) */
  XMPFrameworkErrorCodeNamespaceURIFailedToResolve = 201,
  XMPFrameworkErrorCodeNamespacePrefixFailedToResolve = 202,
  XMPFrameworkErrorCodeNamespaceInvalid = 203,
  XMPFrameworkErrorCodeNamespaceFailedToRegister = 204,
  
  /* XMPWriter Error(s) */
  XMPFrameworkErrorCodePropertyInvalid = 301,
  XMPFrameworkErrorCodeUnsupportedPrimitiveType = 302,
  XMPFrameworkErrorCodeUnsupportedObjectType = 303,
  XMPFrameworkErrorCodeUnknownWriteError = 304
  
};

#endif /* XMPFrameworkErrors_h */
