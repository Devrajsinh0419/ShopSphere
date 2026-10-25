using System;
using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;

namespace ShopSphere
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            var settings = new FriendlyUrlSettings();
            // Using Off avoids forced mobile master page redirection so our responsive Tailstore layout displays everywhere
            settings.AutoRedirectMode = RedirectMode.Off;
            routes.EnableFriendlyUrls(settings);
        }
    }
}
