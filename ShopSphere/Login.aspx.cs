using System;
using System.Web.UI;
using ShopSphere.Helpers;

namespace ShopSphere
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Clear any lingering message on fresh get
                pnlMessage.Visible = false;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            // Basic validation
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                ShowErrorMessage("Invalid Username or Password");
                return;
            }

            // Authenticate against SQL Server database using salted hash
            string role;
            string fullName;
            string verifiedUsername;

            bool isValid = DbHelper.AuthenticateUser(username, password, out role, out fullName, out verifiedUsername);

            if (isValid)
            {
                // Store authenticated user in Session
                Session["Username"] = verifiedUsername;
                Session["FullName"] = fullName;
                Session["Role"] = role;
                Response.Redirect("~/Default.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            else
            {
                // Assignment requirement: "Any other Any other -> Invalid Username or Password"
                ShowErrorMessage("Invalid Username or Password");
            }
        }

        private void ShowErrorMessage(string message)
        {
            pnlMessage.Visible = true;
            lblMessage.Text = message;
            divAlertBox.Attributes["class"] = "px-4 py-3 rounded-xl border flex items-center space-x-3 text-sm bg-red-50 border-red-200 text-red-800";
            iconAlert.Attributes["class"] = "fa-solid fa-circle-xmark text-red-600 text-base";
        }

    }
}
