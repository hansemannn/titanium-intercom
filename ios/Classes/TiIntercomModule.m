/**
 * titanium-intercom
 *
 * Created by Hans Knoechel
 * Copyright (c) 2020 Your Company. All rights reserved.
 */

#import "TiIntercomModule.h"

#import <TitaniumKit/TitaniumKit.h>
#import <Intercom/Intercom.h>

@implementation TiIntercomModule

#pragma mark Internal

- (id)moduleGUID
{
  return @"a0354e09-4d47-4de7-8321-90d162393b55";
}

- (NSString *)moduleId
{
  return @"ti.intercom";
}

- (void)_configure
{
  [super _configure];
  [[TiApp app] registerApplicationDelegate:self];
}

- (void)_destroy
{
  [super _destroy];
  [[TiApp app] unregisterApplicationDelegate:self];
}

#pragma Public APIs

- (void)configure:(id)params
{
  ENSURE_SINGLE_ARG(params, NSDictionary);

  NSString *apiKey = params[@"apiKey"];
  NSString *appId = params[@"appId"];

  [Intercom setApiKey:apiKey forAppId:appId];
}

- (void)setVisible:(NSNumber *)visible
{
  [Intercom setLauncherVisible:[TiUtils boolValue:visible def:NO]];
}

- (void)registerUser:(id)user
{
  ENSURE_SINGLE_ARG_OR_NIL(user, NSDictionary);

  if (user == nil) {
    [Intercom registerUnidentifiedUser];
    return;
  }

  NSString *userId = user[@"identifier"];
  NSString *email = user[@"email"];

  if (email == nil) {
    [Intercom registerUserWithUserId:userId];
    return;
  }

  [Intercom registerUserWithUserId:userId email:email];
}

- (void)updateUser:(id)user
{
  ENSURE_SINGLE_ARG(user, NSDictionary);

  NSString *email = user[@"email"];
  NSString *name = user[@"name"];

  ICMUserAttributes *userAttributes = [ICMUserAttributes new];

  if (email != nil) {
    userAttributes.email = email;
  }

  if (name != nil) {
    userAttributes.name = name;
  }

  [Intercom updateUser:userAttributes];
}

- (void)logout:(id)unused
{
  [Intercom logout];
}

- (void)presentMessenger:(id)message
{
  ENSURE_SINGLE_ARG_OR_NIL(message, NSString);

  [Intercom presentMessageComposer:[TiUtils stringValue:message]];
}

- (void)presentHelpCenter:(id)unused
{
  [Intercom presentHelpCenter];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
  [Intercom setDeviceToken:deviceToken];
}

@end
