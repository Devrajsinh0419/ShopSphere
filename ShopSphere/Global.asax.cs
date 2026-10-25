using System;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using ShopSphere.Helpers;

namespace ShopSphere
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            // Automatically verify database and seed required tables and default user roles
            DbHelper.InitializeDatabase();
        }
    }
}
