using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using ShopSphere.Helpers;

namespace ShopSphere
{
    public partial class ElectricityBill : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlBillSummary.Visible = false;
                pnlError.Visible = false;
                LoadRecentBills();
            }
        }

        protected void btnCalculate_Click(object sender, EventArgs e)
        {
            pnlBillSummary.Visible = false;
            pnlError.Visible = false;

            string customerId = txtCustomerId.Text.Trim();
            string customerName = txtCustomerName.Text.Trim();
            string unitsStr = txtUnits.Text.Trim();

            // Field validation
            if (string.IsNullOrEmpty(customerId))
            {
                ShowError("Customer ID is required.");
                txtCustomerId.Focus();
                return;
            }

            if (string.IsNullOrEmpty(customerName))
            {
                ShowError("Customer Name is required.");
                txtCustomerName.Focus();
                return;
            }

            if (string.IsNullOrEmpty(unitsStr))
            {
                ShowError("Units Consumed is required.");
                txtUnits.Focus();
                return;
            }

            int units;
            if (!int.TryParse(unitsStr, out units))
            {
                ShowError("Please enter a valid whole number for Units Consumed.");
                txtUnits.Focus();
                return;
            }

            // Assignment Instruction 1: Units Consumed must be greater than zero.
            if (units <= 0)
            {
                ShowError("Units Consumed must be greater than zero.");
                txtUnits.Focus();
                return;
            }

            // Progressive Slab Tariff Computation (Assignment 2 Specification)
            // First 200 units: ₹ 4.20 per unit
            // Next 201 to 400 units: ₹ 7.50 per unit
            // Above 400 units: ₹ 10.00 per unit
            decimal billBeforeGst = 0m;

            if (units <= 200)
            {
                billBeforeGst = units * 4.20m;
            }
            else if (units <= 400)
            {
                billBeforeGst = (200m * 4.20m) + ((units - 200m) * 7.50m);
            }
            else
            {
                billBeforeGst = (200m * 4.20m) + (200m * 7.50m) + ((units - 400m) * 10.00m);
            }

            // GST Slab Computation (Based on Bill Amount Before GST)
            // Up to ₹ 500: 5%
            // ₹ 501 – ₹ 1000: 12%
            // Above ₹ 1000: 18%
            decimal gstRate = 0m;
            if (billBeforeGst <= 500m)
            {
                gstRate = 5.0m;
            }
            else if (billBeforeGst <= 1000m)
            {
                gstRate = 12.0m;
            }
            else
            {
                gstRate = 18.0m;
            }

            // Formulas specified in Assignment 2:
            // GST Amount = Electricity Bill × (GST/100)
            // Total Bill = Electricity Bill + GST Amount
            decimal gstAmount = billBeforeGst * (gstRate / 100m);
            decimal totalBill = billBeforeGst + gstAmount;

            // Display Results in Label Controls
            lblOutCustomerId.Text = customerId;
            lblOutCustomerName.Text = customerName;
            lblOutUnits.Text = units.ToString() + " kWh";
            lblOutBillBeforeGst.Text = string.Format("₹ {0:N2}", billBeforeGst);
            lblOutGstAmount.Text = string.Format("₹ {0:N2} ({1:0}%)", gstAmount, gstRate);
            lblOutTotalBill.Text = string.Format("₹ {0:N2}", totalBill);

            pnlBillSummary.Visible = true;

            // Save calculation to database table ElectricityBills
            SaveBillToDatabase(customerId, customerName, units, billBeforeGst, gstRate, gstAmount, totalBill);

            // Refresh live GridView
            LoadRecentBills();
        }

        private void SaveBillToDatabase(string customerId, string customerName, int units, decimal billBeforeGst, decimal gstRate, decimal gstAmount, decimal totalBill)
        {
            string insertSql = @"
                INSERT INTO ElectricityBills (CustomerId, CustomerName, UnitsConsumed, BillBeforeGst, GstRate, GstAmount, TotalAmount, CalculatedAt)
                VALUES (@CustomerId, @CustomerName, @Units, @BillBeforeGst, @GstRate, @GstAmount, @TotalAmount, GETDATE())";

            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@CustomerId", customerId),
                new SqlParameter("@CustomerName", customerName),
                new SqlParameter("@Units", units),
                new SqlParameter("@BillBeforeGst", billBeforeGst),
                new SqlParameter("@GstRate", gstRate),
                new SqlParameter("@GstAmount", gstAmount),
                new SqlParameter("@TotalAmount", totalBill)
            };

            DbHelper.ExecuteNonQuery(insertSql, parameters);
        }

        private void LoadRecentBills()
        {
            string query = "SELECT TOP 10 BillId, CustomerId, CustomerName, UnitsConsumed, BillBeforeGst, GstRate, GstAmount, TotalAmount, CalculatedAt FROM ElectricityBills ORDER BY BillId DESC";
            DataTable dt = DbHelper.ExecuteDataTable(query);
            gvRecentBills.DataSource = dt;
            gvRecentBills.DataBind();
        }

        protected void gvRecentBills_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvRecentBills.PageIndex = e.NewPageIndex;
            LoadRecentBills();
        }

        // Assignment Instruction 2: Provide a Reset button to clear all input fields.
        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtCustomerId.Text = string.Empty;
            txtCustomerName.Text = string.Empty;
            txtUnits.Text = string.Empty;

            pnlBillSummary.Visible = false;
            pnlError.Visible = false;

            txtCustomerId.Focus();
        }

        // Quick Viva Demo Sample Handlers
        protected void btnSample1_Click(object sender, EventArgs e)
        {
            txtCustomerId.Text = "CUST-001";
            txtCustomerName.Text = "Sunil Verma";
            txtUnits.Text = "100";
            btnCalculate_Click(sender, e);
        }

        protected void btnSample2_Click(object sender, EventArgs e)
        {
            txtCustomerId.Text = "CUST-002";
            txtCustomerName.Text = "Anita Desai";
            txtUnits.Text = "300";
            btnCalculate_Click(sender, e);
        }

        protected void btnSample3_Click(object sender, EventArgs e)
        {
            txtCustomerId.Text = "CUST-003";
            txtCustomerName.Text = "Deepak Joshi";
            txtUnits.Text = "500";
            btnCalculate_Click(sender, e);
        }

        private void ShowError(string msg)
        {
            lblError.Text = msg;
            pnlError.Visible = true;
            pnlBillSummary.Visible = false;
        }
    }
}
