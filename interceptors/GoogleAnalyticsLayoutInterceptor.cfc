component extends="coldbox.system.Interceptor" {

	property name="layoutsToApply"             inject="coldbox:setting:googleAnalytics.layouts" type="array";
	property name="systemConfigurationService" inject="delayedInjector:systemConfigurationService";

	public void function configure() {}

	public void function postLayoutRender( event, interceptData={} ) {
		var layout = Trim( interceptData.layout ?: "" );

		if ( Len( layout ) && layoutsToApply.findNoCase( layout ) ) {
			var gaId = Trim( systemConfigurationService.getSetting( category="google-analytics", setting="analytics_id" ) );

			if ( Len( gaId ) ) {
				var gaScript = Trim( renderView( view="/general/_googleAnalyticsTags", args={ gaId=gaId, layout=layout } ) );

				if ( Len( gaScript ) ) {
					interceptData.renderedLayout = ( interceptData.renderedLayout ?: "" ).reReplaceNoCase( "<body(.*?)>", "<body\1>#chr(10)##gaScript#" );
				}
			}
		}
	}
}