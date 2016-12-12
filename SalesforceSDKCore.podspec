Pod::Spec.new do |s|

  s.name         = "SalesforceSDKCore"
  s.version      = "5.1.0"
  s.summary      = "Salesforce Mobile SDK for iOS"
  s.homepage     = "https://github.com/forcedotcom/SalesforceMobileSDK-iOS"

  s.license      = { :type => "Salesforce.com Mobile SDK License", :file => "LICENSE.md" }
  s.author       = { "Kevin Hawkins" => "khawkins@salesforce.com" }

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/forcedotcom/SalesforceMobileSDK-iOS.git",
                     :tag => "v#{s.version}",
                     :submodules => true }
  
  s.requires_arc = true
  s.default_subspec  = 'SalesforceSDKCore'

  s.subspec 'SalesforceSDKCore' do |sdkcore|

      sdkcore.dependency 'CocoaLumberjack', '~> 2.4.0'
      sdkcore.dependency 'SalesforceAnalytics'
      sdkcore.libraries = 'z'
      sdkcore.resource_bundles = { 'SalesforceSDKResources' => [ 'shared/resources/SalesforceSDKResources.bundle/**' ] }
      sdkcore.resource = 'shared/resources/SalesforceSDKAssets.xcassets'

      # subspec for code that any of the source_files of no-arc depend on
      sdkcore.subspec 'base' do |sp|
          sp.source_files = 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/Logging/SFLogger.h', 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/Logging/SFLogger.m', 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/SalesforceSDKConstants.h', 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/NSData+SFAdditions.h', 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/NSData+SFAdditions.m', 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/NSString+SFAdditions.h', 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/NSString+SFAdditions.m','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/NSNotificationCenter+SFAdditions.h', 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/NSNotificationCenter+SFAdditions.m'
          sp.public_header_files = 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/Logging/SFLogger.h', 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/SalesforceSDKConstants.h', 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/NSData+SFAdditions.h', 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/NSString+SFAdditions.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/NSNotificationCenter+SFAdditions.h'
          sp.requires_arc = true
          sp.prefix_header_contents = '#import "SFLogger.h"', '#import "SalesforceSDKConstants.h"'
      end

      # subspec for code that doesn't support arc
      sdkcore.subspec 'no-arc' do |sp|
          sp.dependency 'SalesforceSDKCore/SalesforceSDKCore/base'
          sp.source_files = 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/SFKeychainItemWrapper.h', 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/SFKeychainItemWrapper+Internal.h', 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/SFKeychainItemWrapper.m'
          sp.public_header_files = 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/SFKeychainItemWrapper.h'
          sp.requires_arc = false
          sp.prefix_header_contents = '#import "SFLogger.h"', '#import "SalesforceSDKConstants.h"'
      end

      # subspec for everything else
      # exclude_files should be the source_files from the base subspec plus the ones from the arc subspec
      # public_header_files is automatically populated by update_podspec_headers.sh which is run when building SalesforceSDKCore
      sdkcore.subspec 'arc' do |sdkcore|
          sdkcore.dependency 'SalesforceSDKCore/SalesforceSDKCore/base'
          sdkcore.dependency 'SalesforceSDKCore/SalesforceSDKCore/no-arc'
          sdkcore.source_files = 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/**/*.{h,m}', 'libs/SalesforceSDKCore/SalesforceSDKCore/SalesforceSDKCore.h'
          sdkcore.exclude_files = 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/Logging/SFLogger.h', 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/Logging/SFLogger.m', 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/SalesforceSDKConstants.h', 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/NSData+SFAdditions.h', 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/NSData+SFAdditions.m', 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/NSString+SFAdditions.h', 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/NSString+SFAdditions.m','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/NSNotificationCenter+SFAdditions.h', 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/NSNotificationCenter+SFAdditions.m', 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/SFKeychainItemWrapper.h', 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/SFKeychainItemWrapper+Internal.h', 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/SFKeychainItemWrapper.m'
          sdkcore.public_header_files = 'libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Analytics/SFSDKAILTNPublisher.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Analytics/SFSDKAnalyticsPublisher.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Analytics/SFSDKEventBuilderHelper.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Analytics/SFSDKSalesforceAnalyticsManager.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/Logging/SFLoggerMacros.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/NSArray+SFAdditions.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/NSData+SFSDKUtils.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/NSDictionary+SFAdditions.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/NSObject+SFBlocks.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/NSURL+SFAdditions.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/NSUserDefaults+SFAdditions.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/SFApplication.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/SFCrypto.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/SFFileProtectionHelper.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/SFInactivityTimerCenter.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/SFPathUtil.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/SFSDKAppConfig.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/SFSDKDatasharingHelper.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/SFTestContext.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/SFUserActivityMonitor.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/SalesforceSDKManager.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/UIDevice+SFHardware.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/UIScreen+SFAdditions.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Identity/SFIdentityCoordinator.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Identity/SFIdentityData.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Instrumentation/SFInstrumentation.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Instrumentation/SFMethodInterceptor.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Login/LoginHost/SFSDKLoginHost.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Login/LoginHost/SFSDKLoginHostDelegate.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Login/LoginHost/SFSDKLoginHostListViewController.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Login/LoginHost/SFSDKLoginHostStorage.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Login/SFLoginViewController.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Network/Additions/SFUserAccount+SalesforceNetwork.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Network/Network/Action/CSFAction.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Network/Network/Action/CSFSalesforceAction.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Network/Network/Model/CSFInput.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Network/Network/Model/CSFOutput.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Network/Network/OAuth/CSFAuthRefresh.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Network/Network/Queue/CSFNetwork.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Network/Network/Support/CSFParameterStorage.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Network/Protocols/CSFActionInput.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Network/Protocols/CSFActionModel.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Network/Protocols/CSFActionValue.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Network/Protocols/CSFIndexedEntity.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Network/Protocols/CSFNetworkOutputCache.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Network/Utilities/CSFAvailability.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Network/Utilities/CSFDefines.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Network/Utilities/CSFForceDefines.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/OAuth/SFOAuthCoordinator.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/OAuth/SFOAuthCredentials.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/OAuth/SFOAuthCrypto.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/OAuth/SFOAuthInfo.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/OAuth/SFOAuthKeychainCredentials.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/OAuth/SFOAuthOrgAuthConfiguration.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/OAuth/SFOAuthSessionRefresher.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Protocols/SFSDKAppDelegate.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/PushNotification/SFPushNotificationManager.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/RestAPI/SFRestAPI+Blocks.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/RestAPI/SFRestAPI+Files.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/RestAPI/SFRestAPI+QueryBuilder.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/RestAPI/SFRestAPI.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/RestAPI/SFRestAPISalesforceAction.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/RestAPI/SFRestRequest.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFAbstractPasscodeViewController.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFAuthErrorHandler.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFAuthErrorHandlerList.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFAuthenticationManager.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFAuthenticationViewHandler.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFCommunityData.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFCryptChunks.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFDecryptStream.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFDefaultUserManagementDetailViewController.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFDefaultUserManagementListViewController.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFDefaultUserManagementViewController.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFEncryptStream.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFEncryptionKey.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFGeneratedKeyStore.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFKeyStore.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFKeyStoreKey.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFKeyStoreManager.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFPBKDF2PasscodeProvider.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFPBKDFData.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFPasscodeKeyStore.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFPasscodeManager+Internal.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFPasscodeManager.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFPasscodeProviderManager.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFPasscodeViewController.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFPasscodeViewControllerTypes.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFSDKCryptoUtils.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFSHA256PasscodeProvider.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFSecurityLockout+Internal.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFSecurityLockout.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFUserAccount.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFUserAccountConstants.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFUserAccountIdentity.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFUserAccountManager.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFUserAccountManagerUpgrade.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Test/SFSDKAsyncProcessListener.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Test/SFSDKTestCredentialsData.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Test/SFSDKTestRequestListener.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Test/TestSetupUtils.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Util/NSURL+SFStringUtils.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Util/SFApplicationHelper.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Util/SFDirectoryManager.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Util/SFJsonUtils.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Util/SFManagedPreferences.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Util/SFPreferences.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Util/SFRootViewManager.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Util/SFSDKResourceUtils.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Util/SFSDKWebUtils.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Util/SalesforceSDKCoreDefines.h','libs/SalesforceSDKCore/SalesforceSDKCore/Classes/Util/UIColor+SFColors.h','libs/SalesforceSDKCore/SalesforceSDKCore/SalesforceSDKCore.h'
          sdkcore.requires_arc = true
          sdkcore.prefix_header_contents = '#import "SFLogger.h"', '#import "SalesforceSDKConstants.h"'
      end

  end

end
