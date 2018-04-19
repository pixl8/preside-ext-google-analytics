# Google Analytics for Preside

This extension allows you to easily insert Google Analytics "tags" into your Preside website's pages.

## Installation

From a commandline at the root of your application: 

```
box install preside-ext-google-analytics
```

## Configuration

Once installed, login to the Preside admin and head to **System -> Settings -> Google Analytics** and enter your analytics credentials.

## Usage

The extension will take care of inserting analytics "tags" into your layout automatically for you, you won't need to do anything else. However, you can customize the layouts that are effected and the script itself.

To customize the layouts, set the `settings.googleAnalytics.layouts` variable in your `Config.cfc`:

```
settings.googleAnalytics.layouts = [ "main", "newsletter" ]; // default is [ "main" ]
```

To customize the output of the analytics script, implement your own view at `/views/general/_googleAnalyticsTags.cfm`, the view will be passed two `args`: `gaId` and `layout`. For example:

```
// /views/general/_googleAnalyticsTags.cfm
<cfparam name="args.gaId"   type="string" />
<cfparam name="args.layout" type="string" />

<cfif args.layout == "main">
	<cfoutput><script type="text/javascript">(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
ga('create', '#args.gaId#', 'auto');
ga('send', 'pageview');</script></cfoutput>

<cfelseif args.layout == "newlsetter">
<cfoutput><script type="text/javascript">some special example for newlsetters here</script></cfoutput>
</cfif>
```

## Contributing and roadmap

Pull requests, issues and ideas are all welcome :) Please use Github or get in touch with the Preside team on our [Preside Slack](https://presidecms-slack.herokuapp.com/).

We could obviously do a lot more with this extension and would be great to collaborate with anyone who has ideas!




