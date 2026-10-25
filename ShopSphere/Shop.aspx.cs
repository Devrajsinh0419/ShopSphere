using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using ShopSphere.Helpers;

namespace ShopSphere
{
    public partial class Shop : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProducts();
            }
        }

        private void LoadProducts()
        {
            string category = ddlCategory.SelectedValue;
            string search = txtSearch.Text.Trim();

            string query = "SELECT ProductId, ProductName, Category, Price, OriginalPrice, ImageUrl, Description FROM Products WHERE 1=1";
            var paramList = new System.Collections.Generic.List<SqlParameter>();

            if (!string.IsNullOrEmpty(category) && category != "All")
            {
                query += " AND Category = @Category";
                paramList.Add(new SqlParameter("@Category", category));
            }

            if (!string.IsNullOrEmpty(search))
            {
                query += " AND (ProductName LIKE @Search OR Description LIKE @Search)";
                paramList.Add(new SqlParameter("@Search", "%" + search + "%"));
            }

            query += " ORDER BY ProductId ASC";

            DataTable dt = DbHelper.ExecuteDataTable(query, paramList.ToArray());

            if (dt.Rows.Count > 0)
            {
                rptProducts.DataSource = dt;
                rptProducts.DataBind();
                rptProducts.Visible = true;
                pnlNoProducts.Visible = false;
                lblItemCount.Text = "Showing " + dt.Rows.Count + " product(s)";
            }
            else
            {
                rptProducts.Visible = false;
                pnlNoProducts.Visible = true;
                lblItemCount.Text = "No items to display";
            }
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadProducts();
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            LoadProducts();
        }

        protected void btnResetFilter_Click(object sender, EventArgs e)
        {
            txtSearch.Text = string.Empty;
            ddlCategory.SelectedValue = "All";
            pnlNotification.Visible = false;
            LoadProducts();
        }

        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "AddToCart")
            {
                string[] parts = (e.CommandArgument ?? "").ToString().Split(';');
                string name = parts.Length > 0 ? parts[0] : "Item";
                string price = parts.Length > 1 ? parts[1] : "0.00";

                lblNotification.Text = string.Format("Added '{0}' (${1}) to your shopping cart!", name, price);
                pnlNotification.Visible = true;
            }
        }
    }
}
