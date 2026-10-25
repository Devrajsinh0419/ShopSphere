using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShopSphere
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string flashMessage = Session["FlashMessage"] as string;
            if (!string.IsNullOrEmpty(flashMessage))
            {
                lblFlashMessage.Text = flashMessage;
                pnlFlashMessage.Visible = true;
                Session.Remove("FlashMessage");
            }
        }
    }
}
