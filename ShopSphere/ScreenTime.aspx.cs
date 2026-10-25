using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;
using ShopSphere.Helpers;

namespace ShopSphere
{
    public partial class ScreenTime : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlResult.Visible = false;
                pnlError.Visible = false;
                LoadScreenTimeLogs();
            }
        }

        protected void btnAnalyze_Click(object sender, EventArgs e)
        {
            pnlResult.Visible = false;
            pnlError.Visible = false;

            string input = txtScreenTime.Text.Trim();

            if (string.IsNullOrEmpty(input))
            {
                ShowError("Please enter daily Instagram screen time in hours.");
                return;
            }

            double hours;
            if (!double.TryParse(input, out hours))
            {
                ShowError("Please enter a valid numeric value for screen time.");
                return;
            }

            if (hours < 0)
            {
                ShowError("Screen time cannot be negative. Please enter 0 or more hours.");
                return;
            }

            // Categorize usage using the defined thresholds.
            string category;
            string detail;
            string cardCss;
            Color textColor;

            if (hours >= 0 && hours <= 1.0)
            {
                category = "Excellent! Healthy Usage";
                detail = "Your daily screen time is well within healthy digital balance limits.";
                cardCss = "mt-6 p-6 rounded-2xl border bg-emerald-50 border-emerald-200 text-emerald-800";
                textColor = Color.FromArgb(4, 120, 87); // Emerald 700
            }
            else if (hours > 1.0 && hours <= 2.0)
            {
                category = "Good Usage";
                detail = "Your usage is moderate and within typical recreational guidelines.";
                cardCss = "mt-6 p-6 rounded-2xl border bg-blue-50 border-blue-200 text-blue-800";
                textColor = Color.FromArgb(29, 78, 216); // Blue 700
            }
            else if (hours > 2.0 && hours <= 4.0)
            {
                category = "Moderate Usage";
                detail = "You are spending noticeable time on Instagram. Consider taking scheduled breaks.";
                cardCss = "mt-6 p-6 rounded-2xl border bg-amber-50 border-amber-200 text-amber-800";
                textColor = Color.FromArgb(180, 83, 9); // Amber 700
            }
            else if (hours > 4.0 && hours <= 6.0)
            {
                category = "High Usage";
                detail = "High daily engagement detected. Try enabling daily time limit reminders in Instagram.";
                cardCss = "mt-6 p-6 rounded-2xl border bg-orange-50 border-orange-200 text-orange-800";
                textColor = Color.FromArgb(194, 65, 12); // Orange 700
            }
            else
            {
                // More than 6 hours
                category = "Excessive Usage – Reduce Screen Time";
                detail = "Screen time is excessively high. Recommended to set daily app timers and take a digital detox.";
                cardCss = "mt-6 p-6 rounded-2xl border bg-rose-50 border-rose-200 text-rose-800";
                textColor = Color.FromArgb(190, 18, 60); // Rose 700
            }

            // Display the result.
            lblResult.Text = category;
            lblResult.ForeColor = textColor;
            lblResultDetail.Text = detail;
            pnlResult.CssClass = cardCss;
            pnlResult.Visible = true;

            // Save record to SQL database
            SaveAnalysisLog(hours, category);

            // Refresh live GridView
            LoadScreenTimeLogs();
        }

        private void SaveAnalysisLog(double hours, string category)
        {
            string currentUser = Session["Username"] != null ? Session["Username"].ToString() : "Guest";

            string insertSql = @"
                INSERT INTO ScreenTimeLogs (Username, ScreenTimeHours, UsageCategory, RecordedAt)
                VALUES (@Username, @Hours, @Category, GETDATE())";

            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@Username", currentUser),
                new SqlParameter("@Hours", hours),
                new SqlParameter("@Category", category)
            };

            DbHelper.ExecuteNonQuery(insertSql, parameters);
        }

        private void LoadScreenTimeLogs()
        {
            string query = "SELECT TOP 10 LogId, Username, ScreenTimeHours, UsageCategory, RecordedAt FROM ScreenTimeLogs ORDER BY LogId DESC";
            DataTable dt = DbHelper.ExecuteDataTable(query);
            gvScreenTimeLogs.DataSource = dt;
            gvScreenTimeLogs.DataBind();
        }

        protected void gvScreenTimeLogs_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvScreenTimeLogs.PageIndex = e.NewPageIndex;
            LoadScreenTimeLogs();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtScreenTime.Text = string.Empty;
            pnlResult.Visible = false;
            pnlError.Visible = false;
            txtScreenTime.Focus();
        }

        private void ShowError(string msg)
        {
            lblError.Text = msg;
            pnlError.Visible = true;
            pnlResult.Visible = false;
        }
    }
}
