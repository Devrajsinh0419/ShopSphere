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

                // Format the Welcome message exactly as specified in Assignment 1
                string welcomeText;
                if (string.Equals(role, "Administrator", StringComparison.OrdinalIgnoreCase))
                {
                    welcomeText = "Welcome Administrator";
                }
                else if (string.Equals(role, "Student", StringComparison.OrdinalIgnoreCase))
                {
                    welcomeText = "Welcome Student";
                }
                else if (string.Equals(role, "Faculty", StringComparison.OrdinalIgnoreCase))
                {
                    welcomeText = "Welcome Faculty";
                }
                else
                {
                    welcomeText = "Welcome " + role;
                }

                ShowSuccessMessage(welcomeText);
            }
            else
            {
                // Assignment requirement: "Any other Any other -> Invalid Username or Password"
                ShowErrorMessage("Invalid Username or Password");
            }
        }

        private void ShowSuccessMessage(string message)
        {
            pnlMessage.Visible = true;
            lblMessage.Text = message;
            divAlertBox.Attributes["class"] = "px-4 py-3 rounded-xl border flex items-center space-x-3 text-sm bg-green-50 border-green-200 text-green-800";
            iconAlert.Attributes["class"] = "fa-solid fa-circle-check text-green-600 text-base";
        }

        private void ShowErrorMessage(string message)
        {
            pnlMessage.Visible = true;
            lblMessage.Text = message;
            divAlertBox.Attributes["class"] = "px-4 py-3 rounded-xl border flex items-center space-x-3 text-sm bg-red-50 border-red-200 text-red-800";
            iconAlert.Attributes["class"] = "fa-solid fa-circle-xmark text-red-600 text-base";
        }

        // Quick Viva Demo Autofill Handlers
        protected void btnFillAdmin_Click(object sender, EventArgs e)
        {
            txtUsername.Text = "admin";
            txtPassword.Attributes["value"] = "admin123";
            txtPassword.Text = "admin123";
            pnlMessage.Visible = false;
        }

        protected void btnFillStudent_Click(object sender, EventArgs e)
        {
            txtUsername.Text = "student";
            txtPassword.Attributes["value"] = "stud123";
            txtPassword.Text = "stud123";
            pnlMessage.Visible = false;
        }

        protected void btnFillFaculty_Click(object sender, EventArgs e)
        {
            txtUsername.Text = "faculty";
            txtPassword.Attributes["value"] = "fac123";
            txtPassword.Text = "fac123";
            pnlMessage.Visible = false;
        }
    }
}
