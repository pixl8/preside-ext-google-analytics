component {

	public void function configure( required struct config ) {
		var conf         = arguments.config;
		var settings     = conf.settings ?: {};
		var interceptors = conf.interceptors ?: [];

		settings.googleAnalytics = settings.googleAnalytics ?: {};
		settings.googleAnalytics.layouts = settings.googleAnalytics.layouts ?: [ "main" ];

		interceptors.append( { class="app.extensions.preside-ext-google-analytics.interceptors.GoogleAnalyticsLayoutInterceptor", properties={} } );
	}
}
