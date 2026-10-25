using System;
using System.Web.UI;

namespace ShopSphere
{
    public partial class Error404 : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.StatusCode = 404;
        }
    }
}
