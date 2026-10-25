using System;
using System.Text.RegularExpressions;
using System.Web.UI;
using ShopSphere.Helpers;

namespace ShopSphere
{
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtMobile.Attributes["inputmode"] = "numeric";
            txtMobile.Attributes["pattern"] = "[0-9]{10}";
            txtMobile.Attributes["title"] = "Enter exactly 10 digits.";
            txtMobile.Attributes["required"] = "required";

            if (!IsPostBack)
            {
                pnlMessage.Visible = false;
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string username = txtUsername.Text.Trim();
            string email = txtEmail.Text.Trim();
            string mobile = txtMobile.Text.Trim();
            string password = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;
            string selectedRole = ddlRole.SelectedValue;

            // Form Validation
            if (string.IsNullOrEmpty(fullName) || string.IsNullOrEmpty(username) ||
                string.IsNullOrEmpty(email) || string.IsNullOrEmpty(mobile) || string.IsNullOrEmpty(password))
            {
                ShowErrorMessage("Please complete all required fields.");
                return;
            }

            if (!Regex.IsMatch(mobile, @"\A[0-9]{10}\z"))
            {
                ShowErrorMessage("Mobile number must contain exactly 10 digits (0–9).");
                return;
            }

            if (password.Length < 4)
            {
                ShowErrorMessage("Password must be at least 4 characters long.");
                return;
            }

            if (password != confirmPassword)
            {
                ShowErrorMessage("Password and Confirm Password do not match.");
                return;
            }

            selectedRole = string.Equals(selectedRole, "Customer", StringComparison.OrdinalIgnoreCase)
                ? "Customer"
                : "Student";

            // Register into SQL Server database
            string error;
            bool success = DbHelper.RegisterUser(username, fullName, email, mobile, password, selectedRole, out error);

            if (success)
            {
                Session["Username"] = username;
                Session["FullName"] = fullName;
                Session["Role"] = selectedRole;
                Session["FlashMessage"] = "Registration successful. You are now signed in.";
                Response.Redirect("~/Default.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            else
            {
                ShowErrorMessage(error);
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
