component extends="coldbox.system.Interceptor" {

	property name="layoutsToApply"             inject="coldbox:setting:googleAnalytics.layouts" type="array";
	property name="systemConfigurationService" inject="delayedInjector:systemConfigurationService";

	public void function configure() {}

	public void function postLayoutRender( event, interceptData={} ) {
		var layout = Trim( interceptData.layout ?: "" );

		if ( Len( layout ) && layoutsToApply.findNoCase( layout ) ) {
			var settings    = systemConfigurationService.getCategorySettings( "google-analytics" );
			var gaId        = Trim( settings.analytics_id ?: "" );
			var anonymizeIp = IsBoolean( settings.anonymize_ip ?: "" ) && settings.anonymize_ip;

			if ( Len( gaId ) ) {
				var gaScript = Trim( renderView( view="/general/_googleAnalyticsTags", args={ gaId=gaId, layout=layout, anonymizeIp=anonymizeIp } ) );

				if ( Len( gaScript ) ) {
					interceptData.renderedLayout = ( interceptData.renderedLayout ?: "" ).reReplaceNoCase( "<body(.*?)>", "<body\1>#chr(10)##gaScript#" );
				}
			}
		}
	}
}