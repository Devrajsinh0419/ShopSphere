using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using ShopSphere.Helpers;

namespace ShopSphere
{
    public partial class Records : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DisplaySelectedTable();
            }
        }

        protected void ddlTables_SelectedIndexChanged(object sender, EventArgs e)
        {
            DisplaySelectedTable();
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            DisplaySelectedTable();
        }

        private void DisplaySelectedTable()
        {
            string selected = ddlTables.SelectedValue;

            pnlUsers.Visible = (selected == "Users");
            pnlBills.Visible = (selected == "ElectricityBills");
            pnlScreenTime.Visible = (selected == "ScreenTimeLogs");
            pnlProducts.Visible = (selected == "Products");

            if (pnlUsers.Visible) BindUsers();
            else if (pnlBills.Visible) BindBills();
            else if (pnlScreenTime.Visible) BindScreenTime();
            else if (pnlProducts.Visible) BindProducts();
        }

        private void BindUsers()
        {
            string query = "SELECT UserId, Username, FullName, Email, Mobile, Role, CreatedAt FROM Users ORDER BY UserId ASC";
            DataTable dt = DbHelper.ExecuteDataTable(query);
            gvUsers.DataSource = dt;
            gvUsers.DataBind();
        }

        private void BindBills()
        {
            string query = "SELECT BillId, CustomerId, CustomerName, UnitsConsumed, BillBeforeGst, GstRate, GstAmount, TotalAmount, CalculatedAt FROM ElectricityBills ORDER BY BillId DESC";
            DataTable dt = DbHelper.ExecuteDataTable(query);
            gvBills.DataSource = dt;
            gvBills.DataBind();
        }

        private void BindScreenTime()
        {
            string query = "SELECT LogId, Username, ScreenTimeHours, UsageCategory, RecordedAt FROM ScreenTimeLogs ORDER BY LogId DESC";
            DataTable dt = DbHelper.ExecuteDataTable(query);
            gvScreenTime.DataSource = dt;
            gvScreenTime.DataBind();
        }

        private void BindProducts()
        {
            string query = "SELECT ProductId, ProductName, Category, Price, OriginalPrice, Description FROM Products ORDER BY ProductId ASC";
            DataTable dt = DbHelper.ExecuteDataTable(query);
            gvProducts.DataSource = dt;
            gvProducts.DataBind();
        }

        // Paging event handlers for the GridViews
        protected void gvUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvUsers.PageIndex = e.NewPageIndex;
            BindUsers();
        }

        protected void gvBills_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvBills.PageIndex = e.NewPageIndex;
            BindBills();
        }

        protected void gvScreenTime_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvScreenTime.PageIndex = e.NewPageIndex;
            BindScreenTime();
        }

        protected void gvProducts_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvProducts.PageIndex = e.NewPageIndex;
            BindProducts();
        }

        public string GetRoleBadgeClass(string role)
        {
            if (string.Equals(role, "Administrator", StringComparison.OrdinalIgnoreCase))
            {
                return "px-2.5 py-0.5 rounded-full text-xs font-bold bg-rose-100 text-rose-800 border border-rose-200";
            }
            else if (string.Equals(role, "Faculty", StringComparison.OrdinalIgnoreCase))
            {
                return "px-2.5 py-0.5 rounded-full text-xs font-bold bg-purple-100 text-purple-800 border border-purple-200";
            }
            else if (string.Equals(role, "Student", StringComparison.OrdinalIgnoreCase))
            {
                return "px-2.5 py-0.5 rounded-full text-xs font-bold bg-blue-100 text-blue-800 border border-blue-200";
            }
            return "px-2.5 py-0.5 rounded-full text-xs font-bold bg-gray-100 text-gray-800 border border-gray-200";
        }
    }
}
