<%@ Page Title="Instagram Screen Time Analyzer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ScreenTime.aspx.cs" Inherits="ShopSphere.ScreenTime" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Breadcrumb -->
    <div class="bg-gray-100 py-6 border-b border-gray-200">
        <div class="container mx-auto px-4 flex justify-between items-center">
            <div>
                <h1 class="text-2xl font-bold text-gray-900">Instagram Screen Time Analyzer</h1>
                <p class="text-xs text-gray-500 mt-1">Daily screen time review</p>
            </div>
            <div class="text-sm text-gray-500">
                <a href="Default.aspx" class="hover:text-primary">Home</a> &nbsp;/&nbsp; <span class="text-primary font-semibold">Screen Time</span>
            </div>
        </div>
    </div>

    <!-- Main Content Section -->
    <section class="py-10 bg-gray-50">
        <div class="container mx-auto px-4">
            <div class="max-w-5xl mx-auto grid grid-cols-1 lg:grid-cols-12 gap-6 items-start">
                
                <!-- Left Column: Input Form (Screen time details) -->
                <div class="lg:col-span-7 bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <div class="flex items-center space-x-3 mb-6">
                        <div class="w-10 h-10 rounded-xl bg-gradient-to-tr from-yellow-400 via-pink-500 to-purple-600 text-white flex items-center justify-center text-xl">
                            <i class="fa-brands fa-instagram"></i>
                        </div>
                        <div>
                            <h2 class="text-2xl font-extrabold text-gray-900">Screen Time Analyzer</h2>
                            <p class="text-xs text-gray-500">Enter your daily usage to evaluate digital wellbeing</p>
                        </div>
                    </div>

                    <!-- Input Controls -->
                    <div class="space-y-4">
                        <div>
                            <asp:Label ID="lblInputPrompt" runat="server" Text="Daily Instagram Screen Time (in hours):" Font-Bold="true" ForeColor="#374151" CssClass="block text-sm mb-2"></asp:Label>
                            <div class="relative">
                                <asp:TextBox ID="txtScreenTime" runat="server" CssClass="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-full focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-base font-semibold"></asp:TextBox>
                                <span class="absolute left-3.5 top-3.5 text-gray-400">
                                    <i class="fa-regular fa-clock"></i>
                                </span>
                            </div>
                            <span class="text-xs text-gray-400 mt-1 block">Enter time in hours. Decimal values are supported.</span>
                        </div>

                        <!-- Buttons (Analyze & Reset) -->
                        <div class="flex space-x-4 pt-2">
                            <asp:Button ID="btnAnalyze" runat="server" Text="Analyze Usage" OnClick="btnAnalyze_Click" CssClass="flex-1 bg-primary text-white font-bold py-3 px-6 rounded-full hover:bg-transparent hover:text-primary border border-primary transition shadow cursor-pointer text-base" />
                            <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" CssClass="bg-gray-200 text-gray-700 font-bold py-3 px-6 rounded-full hover:bg-gray-300 transition cursor-pointer text-base" />
                        </div>

                        <!-- Result Display Panel (Analysis result) -->
                        <asp:Panel ID="pnlResult" runat="server" Visible="false" CssClass="mt-5 p-4 rounded-xl border transition-all">
                            <div class="text-center space-y-2">
                                <span class="text-xs font-bold uppercase tracking-widest text-gray-500">Analysis Result</span>
                                <div class="text-2xl sm:text-3xl font-extrabold">
                                    <asp:Label ID="lblResult" runat="server"></asp:Label>
                                </div>
                                <asp:Label ID="lblResultDetail" runat="server" CssClass="text-sm font-medium block"></asp:Label>
                            </div>
                        </asp:Panel>

                        <!-- Error Message Panel -->
                        <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="p-4 bg-red-50 border border-red-200 text-red-700 rounded-xl text-sm flex items-center space-x-2">
                            <i class="fa-solid fa-triangle-exclamation"></i>
                            <asp:Label ID="lblError" runat="server" Font-Bold="true"></asp:Label>
                        </asp:Panel>
                    </div>
                </div>

                <!-- Right Column: Criteria & Reference Slab Guide -->
                <div class="lg:col-span-5 space-y-5">
                    <div class="bg-gray-900 text-white rounded-xl p-5 shadow-sm border border-gray-800">
                        <h3 class="text-lg font-bold mb-4 flex items-center">
                            <i class="fa-solid fa-list-check text-primary mr-2"></i> Usage categories
                        </h3>
                        <div class="space-y-3 text-xs">
                            <div class="p-2 rounded-lg bg-gray-800 flex flex-wrap gap-2 justify-between items-center border-l-4 border-emerald-500">
                                <div>
                                    <span class="font-bold text-emerald-400">0 – 1 hour</span>
                                    <p class="text-gray-400">Optimal wellbeing balance</p>
                                </div>
                                <span class="bg-emerald-900 text-emerald-300 px-2 py-0.5 rounded font-bold">Excellent! Healthy Usage</span>
                            </div>

                            <div class="p-2 rounded-lg bg-gray-800 flex flex-wrap gap-2 justify-between items-center border-l-4 border-blue-500">
                                <div>
                                    <span class="font-bold text-blue-400">&gt;1 – 2 hours</span>
                                    <p class="text-gray-400">Normal daily interaction</p>
                                </div>
                                <span class="bg-blue-900 text-blue-300 px-2 py-0.5 rounded font-bold">Good Usage</span>
                            </div>

                            <div class="p-2 rounded-lg bg-gray-800 flex flex-wrap gap-2 justify-between items-center border-l-4 border-amber-500">
                                <div>
                                    <span class="font-bold text-amber-400">&gt;2 – 4 hours</span>
                                    <p class="text-gray-400">Noticeable social media time</p>
                                </div>
                                <span class="bg-amber-900 text-amber-300 px-2 py-0.5 rounded font-bold">Moderate Usage</span>
                            </div>

                            <div class="p-2 rounded-lg bg-gray-800 flex flex-wrap gap-2 justify-between items-center border-l-4 border-orange-500">
                                <div>
                                    <span class="font-bold text-orange-400">&gt;4 – 6 hours</span>
                                    <p class="text-gray-400">Elevated screen engagement</p>
                                </div>
                                <span class="bg-orange-900 text-orange-300 px-2 py-0.5 rounded font-bold">High Usage</span>
                            </div>

                            <div class="p-2 rounded-lg bg-gray-800 flex flex-wrap gap-2 justify-between items-center border-l-4 border-rose-500">
                                <div>
                                    <span class="font-bold text-rose-400">More than 6 hours</span>
                                    <p class="text-gray-400">Requires digital detox</p>
                                </div>
                                <span class="bg-rose-900 text-rose-300 px-2 py-0.5 rounded font-bold">Excessive Usage &ndash; Reduce</span>
                            </div>
                        </div>
                    </div>

                </div>

            </div>

            <!-- ASP.NET GridView: Recent Screen Time Analyses Section -->
            <div class="max-w-5xl mx-auto mt-8 bg-white rounded-xl shadow-sm border border-gray-200 p-5">
                <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-6">
                    <div>
                        <h3 class="text-xl font-bold text-gray-900 flex items-center">
                            <i class="fa-solid fa-table-list text-primary mr-2"></i> Recent Analysis History (ASP.NET GridView)
                        </h3>
                        <p class="text-xs text-gray-500 mt-1">Live records retrieved from SQL Server table <code>ScreenTimeLogs</code> via ADO.NET</p>
                    </div>
                </div>

                <div class="overflow-x-auto">
                    <asp:GridView ID="gvScreenTimeLogs" runat="server" AutoGenerateColumns="False" 
                        CssClass="min-w-full text-left text-sm border-collapse"
                        GridLines="None" EmptyDataText="No screen time records found in database."
                        AllowPaging="True" PageSize="5" OnPageIndexChanging="gvScreenTimeLogs_PageIndexChanging">
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

        </div>
    </section>
</asp:Content>
