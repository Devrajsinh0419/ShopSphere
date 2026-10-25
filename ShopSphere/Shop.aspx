<%@ Page Title="Shop Catalog" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Shop.aspx.cs" Inherits="ShopSphere.Shop" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Breadcrumb and Page Header -->
    <div class="bg-gray-100 py-6 border-b border-gray-200">
        <div class="container mx-auto px-4 flex flex-col sm:flex-row justify-between items-center">
            <h1 class="text-2xl font-bold text-gray-900">Tailstore Product Catalog</h1>
            <div class="text-sm text-gray-500 mt-2 sm:mt-0">
                <a href="Default.aspx" class="hover:text-primary">Home</a> &nbsp;/&nbsp; <span class="text-primary font-semibold">Shop</span>
            </div>
        </div>
    </div>

    <!-- Notification Alert Message -->
    <asp:Panel ID="pnlNotification" runat="server" Visible="false" CssClass="container mx-auto px-4 mt-6">
        <div class="bg-green-50 border border-green-200 text-green-800 px-4 py-3 rounded-xl flex items-center justify-between">
            <div class="flex items-center space-x-2">
                <i class="fa-solid fa-circle-check text-green-500 text-lg"></i>
                <asp:Label ID="lblNotification" runat="server" Font-Bold="true"></asp:Label>
            </div>
            <button type="button" onclick="this.parentElement.style.display='none'" class="text-green-600 hover:text-green-800">&times;</button>
        </div>
    </asp:Panel>

    <!-- Main Shop Section -->
    <section id="shop" class="py-10">
        <div class="container mx-auto px-4">
            <div class="flex flex-col lg:flex-row gap-8">
                <!-- Sidebar Filters -->
                <aside class="w-full lg:w-1/4">
                    <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-200 space-y-6">
                        <!-- Search Box -->
                        <div>
                            <label class="block text-sm font-bold text-gray-700 mb-2">Search Products</label>
                            <div class="relative">
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-full text-sm focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" placeholder="Type product name..."></asp:TextBox>
                                <span class="absolute left-3 top-2.5 text-gray-400">
                                    <i class="fa-solid fa-magnifying-glass"></i>
                                </span>
                            </div>
                        </div>

                        <!-- Category Filter -->
                        <div>
                            <label class="block text-sm font-bold text-gray-700 mb-2">Filter by Category</label>
                            <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" CssClass="w-full px-4 py-2 border border-gray-300 rounded-full text-sm focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent bg-white">
                                <asp:ListItem Text="All Categories" Value="All" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Women's Apparel" Value="Women"></asp:ListItem>
                                <asp:ListItem Text="Men's Apparel" Value="Men"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <!-- Filter Actions -->
                        <div class="pt-2 flex space-x-2">
                            <asp:Button ID="btnFilter" runat="server" Text="Apply Filter" OnClick="btnFilter_Click" CssClass="w-full bg-primary text-white font-semibold py-2 px-4 rounded-full hover:bg-transparent hover:text-primary border border-primary transition cursor-pointer text-sm" />
                            <asp:Button ID="btnResetFilter" runat="server" Text="Reset" OnClick="btnResetFilter_Click" CssClass="w-full bg-gray-200 text-gray-700 font-semibold py-2 px-4 rounded-full hover:bg-gray-300 transition cursor-pointer text-sm" />
                        </div>

                        <!-- Information Badge -->
                        <div class="bg-primary/5 border border-primary/20 rounded-xl p-4 text-xs text-gray-600 space-y-1">
                            <p class="font-bold text-primary"><i class="fa-solid fa-database mr-1"></i> Dynamic Data Binding</p>
                            <p>Products are populated from the SQL Server <code>Products</code> table using ADO.NET DataSets.</p>
                        </div>
                    </div>
                </aside>

                <!-- Product Catalog Grid -->
                <main class="w-full lg:w-3/4">
                    <div class="flex justify-between items-center mb-6">
                        <asp:Label ID="lblItemCount" runat="server" CssClass="text-gray-600 text-sm font-medium"></asp:Label>
                    </div>

                    <!-- Products Repeater -->
                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                        <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
                            <ItemTemplate>
                                <div class="bg-white rounded-2xl shadow-sm border border-gray-200 overflow-hidden hover:shadow-xl transition-all duration-300 flex flex-col justify-between">
                                    <div class="relative">
                                        <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("ProductName") %>' class="w-full h-64 object-cover">
                                        <span class="absolute top-3 right-3 bg-gray-dark/80 backdrop-blur-xs text-white text-xs font-bold px-2.5 py-1 rounded-full">
                                            <%# Eval("Category") %>
                                        </span>
                                    </div>
                                    <div class="p-5 flex flex-col flex-grow justify-between">
                                        <div>
                                            <h3 class="font-bold text-gray-900 text-lg mb-1"><%# Eval("ProductName") %></h3>
                                            <p class="text-xs text-gray-500 mb-3"><%# Eval("Description") %></p>
                                        </div>
                                        <div>
                                            <div class="flex items-center space-x-2 mb-4">
                                                <span class="text-xl font-bold text-primary">$<%# String.Format("{0:0.00}", Eval("Price")) %></span>
                                                <%# Eval("OriginalPrice") != DBNull.Value && Convert.ToDecimal(Eval("OriginalPrice")) > 0 ? "<span class='text-sm text-gray-400 line-through'>$" + String.Format("{0:0.00}", Eval("OriginalPrice")) + "</span>" : "" %>
                                            </div>
                                            <asp:Button ID="btnAddToCart" runat="server" CommandName="AddToCart" CommandArgument='<%# Eval("ProductName") + ";" + Eval("Price") %>' Text="Add to Cart" CssClass="w-full bg-primary border border-transparent hover:bg-transparent hover:border-primary text-white hover:text-primary font-semibold py-2.5 px-4 rounded-full transition cursor-pointer text-sm shadow" />
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <!-- Empty state panel -->
                    <asp:Panel ID="pnlNoProducts" runat="server" Visible="false" CssClass="text-center py-16 bg-white rounded-2xl border border-gray-200 mt-4">
                        <i class="fa-solid fa-box-open text-gray-300 text-5xl mb-3"></i>
                        <h4 class="text-xl font-bold text-gray-700">No products found</h4>
                        <p class="text-gray-500 text-sm mt-1">Try adjusting your category filter or search keywords.</p>
                    </asp:Panel>
                </main>
            </div>
        </div>
    </section>
</asp:Content>
