<%@ Page Title="Electricity Bill Calculator" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ElectricityBill.aspx.cs" Inherits="ShopSphere.ElectricityBill" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Breadcrumb -->
    <div class="bg-gray-100 py-6 border-b border-gray-200">
        <div class="container mx-auto px-4 flex justify-between items-center">
            <div>
                <h1 class="text-2xl font-bold text-gray-900">Electricity Bill Calculator</h1>
                <p class="text-xs text-gray-500 mt-1">Assignment 2 &bull; Progressive Slabs, GST Calculation &amp; Event Handling</p>
            </div>
            <div class="text-sm text-gray-500">
                <a href="Default.aspx" class="hover:text-primary">Home</a> &nbsp;/&nbsp; <span class="text-primary font-semibold">Electricity Bill</span>
            </div>
        </div>
    </div>

    <!-- Main Content Section -->
    <section class="py-12 bg-gray-50">
        <div class="container mx-auto px-4">
            <div class="max-w-6xl mx-auto grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
                
                <!-- Left Column: Input Form (Assignment Requirements) -->
                <div class="lg:col-span-7 bg-white rounded-2xl shadow-md border border-gray-200 p-8 sm:p-10">
                    <div class="flex items-center space-x-3 mb-6">
                        <div class="w-12 h-12 rounded-2xl bg-amber-500 text-white flex items-center justify-center text-2xl shadow-md">
                            <i class="fa-solid fa-bolt"></i>
                        </div>
                        <div>
                            <h2 class="text-2xl font-extrabold text-gray-900">Consumer Billing Portal</h2>
                            <p class="text-xs text-gray-500">Compute monthly electricity tariff and applicable GST</p>
                        </div>
                    </div>

                    <!-- Error Alert Panel -->
                    <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="mb-6 p-4 bg-red-50 border border-red-200 text-red-700 rounded-xl text-sm flex items-center space-x-2">
                        <i class="fa-solid fa-circle-exclamation text-base"></i>
                        <asp:Label ID="lblError" runat="server" Font-Bold="true"></asp:Label>
                    </asp:Panel>

                    <!-- Form Controls -->
                    <div class="space-y-4">
                        <div>
                            <label for="txtCustomerId" class="block text-sm font-semibold text-gray-700 mb-1">Customer ID</label>
                            <div class="relative">
                                <asp:TextBox ID="txtCustomerId" runat="server" CssClass="w-full pl-10 pr-4 py-2.5 border border-gray-300 rounded-full focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm" placeholder="e.g. CUST-2026"></asp:TextBox>
                                <span class="absolute left-3.5 top-3 text-gray-400">
                                    <i class="fa-solid fa-id-card"></i>
                                </span>
                            </div>
                        </div>

                        <div>
                            <label for="txtCustomerName" class="block text-sm font-semibold text-gray-700 mb-1">Customer Name</label>
                            <div class="relative">
                                <asp:TextBox ID="txtCustomerName" runat="server" CssClass="w-full pl-10 pr-4 py-2.5 border border-gray-300 rounded-full focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm" placeholder="e.g. Rajesh Kumar"></asp:TextBox>
                                <span class="absolute left-3.5 top-3 text-gray-400">
                                    <i class="fa-solid fa-user"></i>
                                </span>
                            </div>
                        </div>

                        <div>
                            <label for="txtUnits" class="block text-sm font-semibold text-gray-700 mb-1">Units Consumed (kWh)</label>
                            <div class="relative">
                                <asp:TextBox ID="txtUnits" runat="server" CssClass="w-full pl-10 pr-4 py-2.5 border border-gray-300 rounded-full focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm font-semibold" placeholder="e.g. 250"></asp:TextBox>
                                <span class="absolute left-3.5 top-3 text-gray-400">
                                    <i class="fa-solid fa-gauge-high"></i>
                                </span>
                            </div>
                            <span class="text-xs text-gray-400 mt-1 block">* Mandatory instruction: Units Consumed must be greater than zero.</span>
                        </div>

                        <!-- Buttons (Calculate and Reset) -->
                        <div class="flex space-x-4 pt-4">
                            <asp:Button ID="btnCalculate" runat="server" Text="Calculate Bill" OnClick="btnCalculate_Click" CssClass="flex-1 bg-amber-500 hover:bg-amber-600 text-white font-bold py-3 px-6 rounded-full shadow transition cursor-pointer text-base" />
                            <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" CssClass="bg-gray-200 hover:bg-gray-300 text-gray-700 font-bold py-3 px-6 rounded-full transition cursor-pointer text-base" />
                        </div>
                    </div>

                    <!-- Bill Summary Output Card (Assignment 2 Mandatory Displays) -->
                    <asp:Panel ID="pnlBillSummary" runat="server" Visible="false" CssClass="mt-8 pt-6 border-t border-gray-200">
                        <div class="bg-gray-50 border border-gray-200 rounded-2xl p-6 space-y-4">
                            <div class="flex justify-between items-center pb-3 border-b border-gray-200">
                                <span class="text-xs font-bold uppercase tracking-wider text-amber-600">Electricity Bill Invoice</span>
                                <span class="text-xs text-gray-500">ShopSphere Utility Service</span>
                            </div>

                            <div class="grid grid-cols-2 gap-4 text-sm">
                                <div>
                                    <span class="text-gray-500 text-xs block">Customer ID</span>
                                    <asp:Label ID="lblOutCustomerId" runat="server" Font-Bold="true" CssClass="text-gray-900"></asp:Label>
                                </div>
                                <div>
                                    <span class="text-gray-500 text-xs block">Customer Name</span>
                                    <asp:Label ID="lblOutCustomerName" runat="server" Font-Bold="true" CssClass="text-gray-900"></asp:Label>
                                </div>
                                <div>
                                    <span class="text-gray-500 text-xs block">Units Consumed</span>
                                    <asp:Label ID="lblOutUnits" runat="server" Font-Bold="true" CssClass="text-gray-900"></asp:Label>
                                </div>
                                <div>
                                    <span class="text-gray-500 text-xs block">Electricity Bill (Before GST)</span>
                                    <asp:Label ID="lblOutBillBeforeGst" runat="server" Font-Bold="true" CssClass="text-gray-900"></asp:Label>
                                </div>
                                <div>
                                    <span class="text-gray-500 text-xs block">GST Rate &amp; Amount</span>
                                    <asp:Label ID="lblOutGstAmount" runat="server" Font-Bold="true" CssClass="text-gray-900"></asp:Label>
                                </div>
                                <div class="bg-amber-100 p-2.5 rounded-xl border border-amber-300">
                                    <span class="text-amber-800 text-xs font-semibold block uppercase">Total Bill Payable</span>
                                    <asp:Label ID="lblOutTotalBill" runat="server" Font-Bold="true" CssClass="text-xl text-amber-900"></asp:Label>
                                </div>
                            </div>

                            <!-- Calculation Formula Note -->
                            <div class="text-xs text-gray-500 pt-2 border-t border-gray-200 space-y-1">
                                <p><b>Formula Applied:</b> GST Amount = Electricity Bill &times; (GST / 100)</p>
                                <p>Total Bill = Electricity Bill (Before GST) + GST Amount</p>
                            </div>
                        </div>
                    </asp:Panel>
                </div>

                <!-- Right Column: Tariff & GST Rate Reference (From Assignment PDF) -->
                <div class="lg:col-span-5 space-y-6">
                    <!-- Electricity Charges Slab Card -->
                    <div class="bg-gray-900 text-white rounded-2xl p-6 shadow-md border border-gray-800">
                        <h3 class="text-base font-bold mb-3 flex items-center">
                            <i class="fa-solid fa-bolt text-amber-400 mr-2"></i> Electricity Charges (Slab Rates)
                        </h3>
                        <div class="space-y-2 text-xs">
                            <div class="p-2.5 bg-gray-800 rounded-lg flex justify-between items-center">
                                <span class="text-gray-300">First 200 units</span>
                                <span class="bg-amber-500/20 text-amber-400 font-bold px-2 py-0.5 rounded">₹ 4.20 per unit</span>
                            </div>
                            <div class="p-2.5 bg-gray-800 rounded-lg flex justify-between items-center">
                                <span class="text-gray-300">Next 201 to 400 units</span>
                                <span class="bg-amber-500/20 text-amber-400 font-bold px-2 py-0.5 rounded">₹ 7.50 per unit</span>
                            </div>
                            <div class="p-2.5 bg-gray-800 rounded-lg flex justify-between items-center">
                                <span class="text-gray-300">Above 400 units</span>
                                <span class="bg-amber-500/20 text-amber-400 font-bold px-2 py-0.5 rounded">₹ 10.00 per unit</span>
                            </div>
                        </div>

                        <h3 class="text-base font-bold mt-6 mb-3 flex items-center">
                            <i class="fa-solid fa-percent text-blue-400 mr-2"></i> GST Slab (Before GST Bill Amount)
                        </h3>
                        <div class="space-y-2 text-xs">
                            <div class="p-2.5 bg-gray-800 rounded-lg flex justify-between items-center">
                                <span class="text-gray-300">Up to ₹ 500</span>
                                <span class="bg-blue-500/20 text-blue-400 font-bold px-2 py-0.5 rounded">5% GST</span>
                            </div>
                            <div class="p-2.5 bg-gray-800 rounded-lg flex justify-between items-center">
                                <span class="text-gray-300">₹ 501 – ₹ 1000</span>
                                <span class="bg-blue-500/20 text-blue-400 font-bold px-2 py-0.5 rounded">12% GST</span>
                            </div>
                            <div class="p-2.5 bg-gray-800 rounded-lg flex justify-between items-center">
                                <span class="text-gray-300">Above ₹ 1000</span>
                                <span class="bg-blue-500/20 text-blue-400 font-bold px-2 py-0.5 rounded">18% GST</span>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Demo Sample Fillers -->
                    <div class="bg-white border border-gray-200 rounded-2xl p-6 shadow-sm text-xs space-y-3">
                        <span class="font-bold text-gray-800 text-sm block">Quick Test Samples for Viva</span>
                        <div class="grid grid-cols-3 gap-2">
                            <asp:Button ID="btnSample1" runat="server" Text="100 Units" OnClick="btnSample1_Click" CssClass="py-1.5 px-2 bg-gray-100 hover:bg-amber-100 rounded-lg text-xs font-semibold text-gray-800 border border-gray-200 cursor-pointer" />
                            <asp:Button ID="btnSample2" runat="server" Text="300 Units" OnClick="btnSample2_Click" CssClass="py-1.5 px-2 bg-gray-100 hover:bg-amber-100 rounded-lg text-xs font-semibold text-gray-800 border border-gray-200 cursor-pointer" />
                            <asp:Button ID="btnSample3" runat="server" Text="500 Units" OnClick="btnSample3_Click" CssClass="py-1.5 px-2 bg-gray-100 hover:bg-amber-100 rounded-lg text-xs font-semibold text-gray-800 border border-gray-200 cursor-pointer" />
                        </div>
                    </div>
                </div>

            </div>

            <!-- ASP.NET GridView: Saved Electricity Bills Table -->
            <div class="max-w-6xl mx-auto mt-12 bg-white rounded-2xl shadow-md border border-gray-200 p-8">
                <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-6">
                    <div>
                        <h3 class="text-xl font-bold text-gray-900 flex items-center">
                            <i class="fa-solid fa-table-list text-amber-500 mr-2"></i> Saved Electricity Bills (ASP.NET GridView)
                        </h3>
                        <p class="text-xs text-gray-500 mt-1">Live records stored in SQL Server table <code>ElectricityBills</code> via ADO.NET</p>
                    </div>
                </div>

                <div class="overflow-x-auto">
                    <asp:GridView ID="gvRecentBills" runat="server" AutoGenerateColumns="False" 
                        CssClass="min-w-full text-left text-sm border-collapse"
                        GridLines="None" EmptyDataText="No electricity bills recorded yet."
                        AllowPaging="True" PageSize="5" OnPageIndexChanging="gvRecentBills_PageIndexChanging">
                        <HeaderStyle CssClass="bg-gray-dark text-white font-bold py-3 px-4 text-xs uppercase tracking-wider" />
                        <RowStyle CssClass="border-b border-gray-200 hover:bg-gray-50 py-3 px-4" />
                        <AlternatingRowStyle CssClass="bg-gray-50/50 border-b border-gray-200 hover:bg-gray-100 py-3 px-4" />
                        <PagerStyle CssClass="py-3 px-4 text-center font-bold space-x-2 text-primary" />
                        <Columns>
                            <asp:BoundField DataField="BillId" HeaderText="Bill ID" ItemStyle-CssClass="py-3 px-4 font-mono font-semibold" />
                            <asp:BoundField DataField="CustomerId" HeaderText="Customer ID" ItemStyle-CssClass="py-3 px-4 font-semibold text-primary" />
                            <asp:BoundField DataField="CustomerName" HeaderText="Customer Name" ItemStyle-CssClass="py-3 px-4 font-semibold" />
                            <asp:BoundField DataField="UnitsConsumed" HeaderText="Units" ItemStyle-CssClass="py-3 px-4 text-center font-bold" />
                            <asp:BoundField DataField="BillBeforeGst" HeaderText="Bill (Before GST)" DataFormatString="₹ {0:N2}" ItemStyle-CssClass="py-3 px-4" />
                            <asp:BoundField DataField="GstRate" HeaderText="GST %" DataFormatString="{0:0}%" ItemStyle-CssClass="py-3 px-4 text-center" />
                            <asp:BoundField DataField="GstAmount" HeaderText="GST Amount" DataFormatString="₹ {0:N2}" ItemStyle-CssClass="py-3 px-4" />
                            <asp:BoundField DataField="TotalAmount" HeaderText="Total Payable" DataFormatString="₹ {0:N2}" ItemStyle-CssClass="py-3 px-4 font-bold text-amber-700" />
                            <asp:BoundField DataField="CalculatedAt" HeaderText="Date" DataFormatString="{0:dd-MMM-yyyy}" ItemStyle-CssClass="py-3 px-4 text-gray-500 text-xs" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

        </div>
    </section>
</asp:Content>
