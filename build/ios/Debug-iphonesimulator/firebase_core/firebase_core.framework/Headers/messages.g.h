// Copyright 2023, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
// Autogenerated from Pigeon (v9.2.5), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import <Foundation/Foundation.h>

@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

@class PigeonFirebaseOptions;
@class PigeonInitializeResponse;

@interface PigeonFirebaseOptions : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithApiKey:(NSString *)apiKey
                         appId:(NSString *)appId
             messagingSenderId:(NSString *)messagingSenderId
                     projectId:(NSString *)projectId
                    authDomain:(nullable NSString *)authDomain
                   databaseURL:(nullable NSString *)databaseURL
                 storageBucket:(nullable NSString *)storageBucket
                 measurementId:(nullable NSString *)measurementId
                    trackingId:(nullable NSString *)trackingId
             deepLinkURLScheme:(nullable NSString *)deepLinkURLScheme
               androidClientId:(nullable NSString *)androidClientId
                   iosClientId:(nullable NSString *)iosClientId
                   iosBundleId:(nullable NSString *)iosBundleId
                    appGroupId:(nullable NSString *)appGroupId;
@property(nonatomic, copy) NSString *apiKey;
@property(nonatomic, copy) NSString *appId;
@property(nonatomic, copy) NSString *messagingSenderId;
@property(nonatomic, copy) NSString *projectId;
@property(nonatomic, copy, nullable) NSString *authDomain;
@property(nonatomic, copy, nullable) NSString *databaseURL;
@property(nonatomic, copy, nullable) NSString *storageBucket;
@property(nonatomic, copy, nullable) NSString *measurementId;
@property(nonatomic, copy, nullable) NSString *trackingId;
@property(nonatomic, copy, nullable) NSString *deepLinkURLScheme;
@property(nonatomic, copy, nullable) NSString *androidClientId;
@property(nonatomic, copy, nullable) NSString *iosClientId;
@property(nonatomic, copy, nullable) NSString *iosBundleId;
@property(nonatomic, copy, nullable) NSString *appGroupId;
@end

@interface PigeonInitializeResponse : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithName:(NSString *)name
                             options:(PigeonFirebaseOptions *)options
    isAutomaticDataCollectionEnabled:(nullable NSNumber *)isAutomaticDataCollectionEnabled
                     pluginConstants:(NSDictionary<NSString *, id> *)pluginConstants;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong) PigeonFirebaseOptions *options;
@property(nonatomic, strong, nullable) NSNumber *isAutomaticDataCollectionEnabled;
@property(nonatomic, strong) NSDictionary<NSString *, id> *pluginConstants;
@end

/// The codec used by FirebaseCoreHostApi.
NSObject<FlutterMessageCodec> *FirebaseCoreHostApiGetCodec(void);

@protocol FirebaseCoreHostApi
- (void)initializeAppAppName:(NSString *)appName
        initializeAppRequest:(PigeonFirebaseOptions *)initializeAppRequest
                  completion:(void (^)(PigeonInitializeResponse *_Nullable,
                                       FlutterError *_Nullable))completion;
- (void)initializeCoreWithCompletion:(void (^)(NSArray<PigeonInitializeResponse *> *_Nullable,
                                               FlutterError *_Nullable))completion;
- (void)optionsFromResourceWithCompletion:(void (^)(PigeonFirebaseOptions *_Nullable,
                                                    FlutterError *_Nullable))completion;
@end

extern void FirebaseCoreHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger,
                                     NSObject<FirebaseCoreHostApi> *_Nullable api);

/// The codec used by FirebaseAppHostApi.
NSObject<FlutterMessageCodec> *FirebaseAppHostApiGetCodec(void);

@protocol FirebaseAppHostApi
- (void)setAutomaticDataCollectionEnabledAppName:(NSString *)appName
                                         enabled:(NSNumber *)enabled
                                      completion:(void (^)(FlutterError *_Nullable))completion;
- (void)setAutomaticResourceManagementEnabledAppName:(NSString *)appName
                                             enabled:(NSNumber *)enabled
                                          completion:(void (^)(FlutterError *_Nullable))completion;
- (void)deleteAppName:(NSString *)appName completion:(void (^)(FlutterError *_Nullable))completion;
@end

extern void FirebaseAppHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger,
                                    NSObject<FirebaseAppHostApi> *_Nullable api);

NS_ASSUME_NONNULL_END
