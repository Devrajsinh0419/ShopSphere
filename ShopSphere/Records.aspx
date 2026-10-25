<%@ Page Title="Database Records Viewer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Records.aspx.cs" Inherits="ShopSphere.Records" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Breadcrumb -->
    <div class="bg-gray-100 py-6 border-b border-gray-200">
        <div class="container mx-auto px-4 flex justify-between items-center">
            <div>
                <h1 class="text-2xl font-bold text-gray-900">Database Records Viewer</h1>
                <p class="text-xs text-gray-500 mt-1">Mandatory PBL Guideline: Display SQL Server Tables using ASP.NET GridView</p>
            </div>
            <div class="text-sm text-gray-500">
                <a href="Default.aspx" class="hover:text-primary">Home</a> &nbsp;/&nbsp; <span class="text-primary font-semibold">Records</span>
            </div>
        </div>
    </div>

    <!-- Main Section -->
    <section class="py-12 bg-gray-50">
        <div class="container mx-auto px-4">
            
            <!-- Table Selection Toolbar -->
            <div class="bg-white rounded-2xl shadow-sm border border-gray-200 p-6 mb-8 flex flex-col md:flex-row justify-between items-center gap-4">
                <div class="flex items-center space-x-3">
                    <span class="text-sm font-bold text-gray-700">Select Database Table:</span>
                    <asp:DropDownList ID="ddlTables" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlTables_SelectedIndexChanged" CssClass="px-4 py-2 border border-gray-300 rounded-full text-sm font-semibold bg-white focus:outline-none focus:ring-2 focus:ring-primary">
                        <asp:ListItem Text="Users Table (Authentication)" Value="Users" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Electricity Bills (Assignment 2)" Value="ElectricityBills"></asp:ListItem>
                        <asp:ListItem Text="Screen Time Logs (Assignment 1)" Value="ScreenTimeLogs"></asp:ListItem>
                        <asp:ListItem Text="Products Table (Tailstore Catalog)" Value="Products"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div>
                    <asp:Button ID="btnRefresh" runat="server" Text="Refresh Grid" OnClick="btnRefresh_Click" CssClass="bg-primary text-white text-xs font-bold py-2 px-5 rounded-full hover:bg-transparent hover:text-primary border border-primary transition cursor-pointer shadow" />
                </div>
            </div>

            <!-- View 1: USERS TABLE GRIDVIEW -->
            <asp:Panel ID="pnlUsers" runat="server" Visible="true">
                <div class="bg-white rounded-2xl shadow-md border border-gray-200 p-8">
                    <div class="flex justify-between items-center mb-6 pb-4 border-b border-gray-100">
                        <div>
                            <h3 class="text-xl font-bold text-gray-900 flex items-center">
                                <i class="fa-solid fa-users text-primary mr-2"></i> Registered Users Table (Users)
                            </h3>
                            <p class="text-xs text-gray-500 mt-1">Displays all database-backed accounts, assigned roles, and registration timestamps</p>
                        </div>
                        <span class="bg-primary/10 text-primary text-xs font-bold px-3 py-1 rounded-full">
                            Role-Based Accounts
                        </span>
                    </div>

                    <div class="overflow-x-auto">
                        <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" 
                            CssClass="min-w-full text-left text-sm border-collapse"
                            GridLines="None" EmptyDataText="No users found in database."
                            AllowPaging="True" PageSize="5" OnPageIndexChanging="gvUsers_PageIndexChanging">
                            <HeaderStyle CssClass="bg-gray-dark text-white font-bold py-3 px-4 text-xs uppercase tracking-wider" />
                            <RowStyle CssClass="border-b border-gray-200 hover:bg-gray-50 py-3 px-4" />
                            <AlternatingRowStyle CssClass="bg-gray-50/50 border-b border-gray-200 hover:bg-gray-100 py-3 px-4" />
                            <PagerStyle CssClass="py-3 px-4 text-center font-bold space-x-2 text-primary" />
                            <Columns>
                                <asp:BoundField DataField="UserId" HeaderText="ID" ItemStyle-CssClass="py-3 px-4 font-mono font-semibold" />
                                <asp:BoundField DataField="Username" HeaderText="Username" ItemStyle-CssClass="py-3 px-4 font-bold text-gray-900" />
                                <asp:BoundField DataField="FullName" HeaderText="Full Name" ItemStyle-CssClass="py-3 px-4" />
                                <asp:BoundField DataField="Email" HeaderText="Email Address" ItemStyle-CssClass="py-3 px-4 text-gray-600" />
                                <asp:BoundField DataField="Mobile" HeaderText="Mobile" ItemStyle-CssClass="py-3 px-4 text-gray-600" />
                                <asp:TemplateField HeaderText="Role">
                                    <ItemTemplate>
                                        <span class='<%# GetRoleBadgeClass(Eval("Role").ToString()) %>'>
                                            <%# Eval("Role") %>
                                        </span>
                                    </ItemTemplate>
                                    <ItemStyle CssClass="py-3 px-4" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="CreatedAt" HeaderText="Registered On" DataFormatString="{0:dd-MMM-yyyy HH:mm}" ItemStyle-CssClass="py-3 px-4 text-gray-500 text-xs" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </asp:Panel>

            <!-- View 2: ELECTRICITY BILLS GRIDVIEW -->
            <asp:Panel ID="pnlBills" runat="server" Visible="false">
                <div class="bg-white rounded-2xl shadow-md border border-gray-200 p-8">
                    <div class="flex justify-between items-center mb-6 pb-4 border-b border-gray-100">
                        <div>
                            <h3 class="text-xl font-bold text-gray-900 flex items-center">
                                <i class="fa-solid fa-bolt text-amber-500 mr-2"></i> Electricity Bills Table (ElectricityBills)
                            </h3>
                            <p class="text-xs text-gray-500 mt-1">Calculations computed via progressive tariffs and GST slabs (Assignment 2)</p>
                        </div>
                        <a href="ElectricityBill.aspx" class="text-xs text-primary font-bold hover:underline">
                            + Calculate New Bill
                        </a>
                    </div>

                    <div class="overflow-x-auto">
                        <asp:GridView ID="gvBills" runat="server" AutoGenerateColumns="False" 
                            CssClass="min-w-full text-left text-sm border-collapse"
                            GridLines="None" EmptyDataText="No electricity bill records found."
                            AllowPaging="True" PageSize="5" OnPageIndexChanging="gvBills_PageIndexChanging">
                            <HeaderStyle CssClass="bg-gray-dark text-white font-bold py-3 px-4 text-xs uppercase tracking-wider" />
                            <RowStyle CssClass="border-b border-gray-200 hover:bg-gray-50 py-3 px-4" />
                            <AlternatingRowStyle CssClass="bg-gray-50/50 border-b border-gray-200 hover:bg-gray-100 py-3 px-4" />
                            <PagerStyle CssClass="py-3 px-4 text-center font-bold space-x-2 text-primary" />
                            <Columns>
                                <asp:BoundField DataField="BillId" HeaderText="Bill ID" ItemStyle-CssClass="py-3 px-4 font-mono font-semibold" />
                                <asp:BoundField DataField="CustomerId" HeaderText="Customer ID" ItemStyle-CssClass="py-3 px-4 font-semibold text-primary" />
                                <asp:BoundField DataField="CustomerName" HeaderText="Customer Name" ItemStyle-CssClass="py-3 px-4 font-semibold" />
                                <asp:BoundField DataField="UnitsConsumed" HeaderText="Units" ItemStyle-CssClass="py-3 px-4 font-bold text-center" />
                                <asp:BoundField DataField="BillBeforeGst" HeaderText="Before GST" DataFormatString="₹ {0:N2}" ItemStyle-CssClass="py-3 px-4" />
                                <asp:BoundField DataField="GstRate" HeaderText="GST %" DataFormatString="{0:0}%" ItemStyle-CssClass="py-3 px-4 text-center" />
                                <asp:BoundField DataField="GstAmount" HeaderText="GST Amount" DataFormatString="₹ {0:N2}" ItemStyle-CssClass="py-3 px-4" />
                                <asp:BoundField DataField="TotalAmount" HeaderText="Total Payable" DataFormatString="₹ {0:N2}" ItemStyle-CssClass="py-3 px-4 font-bold text-amber-700" />
                                <asp:BoundField DataField="CalculatedAt" HeaderText="Date" DataFormatString="{0:dd-MMM-yyyy}" ItemStyle-CssClass="py-3 px-4 text-gray-500 text-xs" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </asp:Panel>

            <!-- View 3: SCREEN TIME LOGS GRIDVIEW -->
            <asp:Panel ID="pnlScreenTime" runat="server" Visible="false">
                <div class="bg-white rounded-2xl shadow-md border border-gray-200 p-8">
                    <div class="flex justify-between items-center mb-6 pb-4 border-b border-gray-100">
                        <div>
                            <h3 class="text-xl font-bold text-gray-900 flex items-center">
                                <i class="fa-brands fa-instagram text-pink-500 mr-2"></i> Instagram Screen Time Logs (ScreenTimeLogs)
                            </h3>
                            <p class="text-xs text-gray-500 mt-1">History of user usage evaluations and wellbeing categories (Assignment 1)</p>
                        </div>
                        <a href="ScreenTime.aspx" class="text-xs text-primary font-bold hover:underline">
                            + Analyze New Usage
                        </a>
                    </div>

                    <div class="overflow-x-auto">
                        <asp:GridView ID="gvScreenTime" runat="server" AutoGenerateColumns="False" 
                            CssClass="min-w-full text-left text-sm border-collapse"
                            GridLines="None" EmptyDataText="No screen time logs found."
                            AllowPaging="True" PageSize="5" OnPageIndexChanging="gvScreenTime_PageIndexChanging">
                            <HeaderStyle CssClass="bg-gray-dark text-white font-bold py-3 px-4 text-xs uppercase tracking-wider" />
                            <RowStyle CssClass="border-b border-gray-200 hover:bg-gray-50 py-3 px-4" />
                            <AlternatingRowStyle CssClass="bg-gray-50/50 border-b border-gray-200 hover:bg-gray-100 py-3 px-4" />
                            <PagerStyle CssClass="py-3 px-4 text-center font-bold space-x-2 text-primary" />
                            <Columns>
                                <asp:BoundField DataField="LogId" HeaderText="Log ID" ItemStyle-CssClass="py-3 px-4 font-mono font-semibold" />
                                <asp:BoundField DataField="Username" HeaderText="User" ItemStyle-CssClass="py-3 px-4 font-semibold" />
                                <asp:BoundField DataField="ScreenTimeHours" HeaderText="Hours" DataFormatString="{0:0.##} hrs" ItemStyle-CssClass="py-3 px-4" />
                                <asp:BoundField DataField="UsageCategory" HeaderText="Usage Category" ItemStyle-CssClass="py-3 px-4 font-bold" />
                                <asp:BoundField DataField="RecordedAt" HeaderText="Timestamp" DataFormatString="{0:dd-MMM-yyyy HH:mm}" ItemStyle-CssClass="py-3 px-4 text-gray-500 text-xs" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </asp:Panel>

            <!-- View 4: PRODUCTS TABLE GRIDVIEW -->
            <asp:Panel ID="pnlProducts" runat="server" Visible="false">
                <div class="bg-white rounded-2xl shadow-md border border-gray-200 p-8">
                    <div class="flex justify-between items-center mb-6 pb-4 border-b border-gray-100">
                        <div>
                            <h3 class="text-xl font-bold text-gray-900 flex items-center">
                                <i class="fa-solid fa-shirt text-blue-500 mr-2"></i> Products Catalog Table (Products)
                            </h3>
                            <p class="text-xs text-gray-500 mt-1">E-commerce items loaded dynamically from SQL Server</p>
                        </div>
                        <a href="Shop.aspx" class="text-xs text-primary font-bold hover:underline">
                            View Customer Storefront &rarr;
                        </a>
                    </div>

                    <div class="overflow-x-auto">
                        <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" 
                            CssClass="min-w-full text-left text-sm border-collapse"
                            GridLines="None" EmptyDataText="No products in database."
                            AllowPaging="True" PageSize="5" OnPageIndexChanging="gvProducts_PageIndexChanging">
                            <HeaderStyle CssClass="bg-gray-dark text-white font-bold py-3 px-4 text-xs uppercase tracking-wider" />
                            <RowStyle CssClass="border-b border-gray-200 hover:bg-gray-50 py-3 px-4" />
                            <AlternatingRowStyle CssClass="bg-gray-50/50 border-b border-gray-200 hover:bg-gray-100 py-3 px-4" />
                            <PagerStyle CssClass="py-3 px-4 text-center font-bold space-x-2 text-primary" />
                            <Columns>
                                <asp:BoundField DataField="ProductId" HeaderText="Product ID" ItemStyle-CssClass="py-3 px-4 font-mono font-semibold" />
                                <asp:BoundField DataField="ProductName" HeaderText="Product Name" ItemStyle-CssClass="py-3 px-4 font-bold text-gray-900" />
                                <asp:BoundField DataField="Category" HeaderText="Category" ItemStyle-CssClass="py-3 px-4" />
                                <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="${0:0.00}" ItemStyle-CssClass="py-3 px-4 font-bold text-primary" />
                                <asp:BoundField DataField="OriginalPrice" HeaderText="Original Price" DataFormatString="${0:0.00}" ItemStyle-CssClass="py-3 px-4 text-gray-400" />
                                <asp:BoundField DataField="Description" HeaderText="Description" ItemStyle-CssClass="py-3 px-4 text-xs text-gray-600" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </asp:Panel>

        </div>
    </section>
</asp:Content>
