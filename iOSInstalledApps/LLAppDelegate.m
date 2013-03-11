//
//  LLAppDelegate.m
//  iOSInstalledApps
//
//  Created by Aravind Krishnaswamy on 02/09/12.
//  Copyright (c) 2012 Aravind Krishnaswamy. All rights reserved.
//

#import "LLAppDelegate.h"
#import "LLInstalledApps.h"

@implementation LLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
    }
    
    // Get list of running apps (process names)
    NSArray* processes = [LLInstalledApps runningApps];
    assert(processes);
    NSLog(@"Process List: %@", processes);
    
    // Pass in a few URL schemes to lookup
    NSArray* schemes = @[ @"tel:", @"sms:", @"mailto:",@"mailto:",@"fb:",@"twitter:",@"instagram",@"fb130329363652431:", @"angrybirds-free:", @"gplus:", @"dbapi-1:", @"soundhound:", @"crystal-46339:", @"doodlejump:", @"fb138713932872514:", @"angrybirds-seasons:", @"WordsWithFriendsFree:", @"fb137333456313198:", @"fb116792795017163:", @"twc:", @"comgoogleearth:", @"nflx:", @"fb216177331814175Regular:", @"quora:", @"path:", @"evernote:", @"templerun:", @"fb:", @"twitter:", @"skype:", @"shazam:", @"instagram:", @"googleapp:", @"foursquare:", @"kindle:", @"imdb:", @"nook:", @"audible:", @"wattpad:", @"x-marvel:", @"kobo:", @"overdrive:", @"com.goodreads.tt:", @"googlebooks:", @"x-comixology:", @"fb134946456646651:", @"ebooks:", @"taleapp:", @"comicsplus:", @"archiecomics:", @"bluefirereader:", @"deseretbookshelf:", @"earthday:", @"sbo:", @"com.adobe.Adobe-Reader:", @"geniusscan:", @"fb239974426079801:", @"com.citrix.securid:", @"COL-G2M-2:", @"GoToMyPC:", @"camcard:", @"mobileiron:", @"force:", @"ushud:", @"fcpm:", @"guidebook:", @"fb144594245582108:", @"asurionMobileLocate:", @"yammer:", @"pcowebview:", @"fb251196928288322:", @"ifaxpro:", @"fb259699454069234:", @"tuxclient:", @"salesforce.chatter:", @"thumbspeak:", @"fb149064151823702:", @"x-autoniq-vinkeyboard:", @"gmarket:", @"attconnect:", @"ssa:", @"coffeetable:", @"fb151295584961392:", @"fb201021956610141:", @"fb283058048395364:", @"db-s88xnnuq25gizve:", @"fb102540830008:", @"fb156995864320881:", @"everydayasl.SignLanguageFree:", @"Pepi Bath Lite:", @"fb302283319859041:", @"fb160354420696853:", @"dunkindonuts:", @"vbk:", @"o7talkingcat:", @"fb194714260574159:", @"fb207419089277486:", @"fb391965177512181:", @"fb173721292676427:", @"o7talkinggina:", @"simsimi:", @"fb162905073821628:", @"ar.apptrailers:", @"fb198642556841597:", @"o7tomsloveletters:", @"su:", @"fb246167610136:", @"milkthecow:", @"fb117993934900864fatbooth:", @"ragecomics:", @"fb111569915535689:", @"facegoolite:", @"tunein:", @"fb164296826950565:", @"mixcloud:", @"fb131549503542594:", @"spotify:", @"ohttp:", @"fb295275268198atomic:", @"dolphin:", @"pinger-db:", @"paypal:", @"fb151985508172001:", @"fb137249306334655:", @"angrybirds-space:", @"drawsomethingfree:", @"fb300673636660678:", @"RunKeeperPro:", @"loseit:", @"Naturespace:", @"pillboxie:", @"flixster:", @"crackle:", @"imovie:", @"motionxgpsdrive:", @"waze:", @"fb314671695276719:", @"scan:", @"x-appshopper:", @"ihandycarpenterlevel:", @"fb134278739973874:", @"hipstamatic:", @"fb192242309827ob:", @"photosynth:", @"photogram:", @"psx:", @"fb272128689676genius:", @"fb402500439785603:", @"fb246290217488:", @"fb184393654925775:", @"cameraawesome:", @"opencinemagram:", @"fb112953085413703:", @"wunderlist:", @"mozy:", @"mobilertm:", @"weave:", @"simplenote:", @"fb92207306468:", @"CamScanner Lite:", @"orchestra:", @"pulse:", @"x-callback-instapaper:", @"zinio:", @"itms-books:", @"stanza:", @"wikipanion:", @"fb252151941506000:", @"scorecenter:", @"fb129765800430121:", @"en-silviorizzi-7242:", @"bumpapp:", @"trillian:", @"tumblr:", @"flighttrack:", @"currency:", @"tripit:", @"uspn:", @"yelp:"];
    
    NSLog(@"Total number of schemes: %d", [schemes count]);
    NSDate* start_time = [NSDate date];
    NSArray* installed_schemes = [LLInstalledApps appsInstalledWithSchemes:schemes withProgressCallback:^(id count) {
        NSLog(@"Progress: %@", count);
    } maxSize:25];
    NSDate* end_time = [NSDate date];
    
    assert(installed_schemes);
    NSLog(@"Installed apps: %@", installed_schemes);
    NSLog(@"Completed in: %@s", [NSNumber numberWithDouble:[end_time timeIntervalSinceDate:start_time]]);
    
    return YES;
}
							
@end
