using System;
using System.Web.UI;
using ShopSphere.Helpers;

namespace ShopSphere
{
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
                string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                ShowErrorMessage("Please fill in all required fields (Name, Username, Email, Password).");
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

            // Register into SQL Server database
            string error;
            bool success = DbHelper.RegisterUser(username, fullName, email, mobile, password, selectedRole, out error);

            if (success)
            {
                ShowSuccessMessage(string.Format("Registration successful for '{0}' as {1}! You can now log in.", username, selectedRole));
                ClearForm();
            }
            else
            {
                ShowErrorMessage(error);
            }
        }

        private void ClearForm()
        {
            txtFullName.Text = string.Empty;
            txtUsername.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtMobile.Text = string.Empty;
            txtPassword.Text = string.Empty;
            txtConfirmPassword.Text = string.Empty;
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
    }
}
