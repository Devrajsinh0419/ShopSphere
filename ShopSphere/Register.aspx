<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="ShopSphere.Register" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Breadcrumb -->
    <div class="bg-gray-100 py-6 border-b border-gray-200">
        <div class="container mx-auto px-4 flex justify-between items-center">
            <h1 class="text-2xl font-bold text-gray-900">Create New Account</h1>
            <div class="text-sm text-gray-500">
                <a href="Default.aspx" class="hover:text-primary">Home</a> &nbsp;/&nbsp; <span class="text-primary font-semibold">Register</span>
            </div>
        </div>
    </div>

    <!-- Registration Section -->
    <section id="register-section" class="py-16 bg-gray-50">
        <div class="container mx-auto px-4">
            <div class="max-w-2xl mx-auto bg-white rounded-2xl shadow-md border border-gray-200 p-8 sm:p-10">
                <div class="mb-8 text-center">
                    <span class="text-xs font-bold uppercase tracking-wider text-primary">Database-Backed Registration</span>
                    <h2 class="text-3xl font-extrabold text-gray-900 mt-1">Join ShopSphere</h2>
                    <p class="text-gray-500 text-sm mt-1">Fill out the information below to register your account into our SQL Server database.</p>
                </div>

                <!-- Feedback Message Alert -->
                <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="mb-6">
                    <div id="divAlertBox" runat="server" class="px-4 py-3 rounded-xl border flex items-center space-x-3 text-sm">
                        <i id="iconAlert" runat="server" class="fa-solid fa-circle-info text-base"></i>
                        <asp:Label ID="lblMessage" runat="server" Font-Bold="true"></asp:Label>
                    </div>
                </asp:Panel>

                <!-- Registration Form -->
                <div class="space-y-4">
                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                        <div>
                            <label for="txtFullName" class="block text-sm font-semibold text-gray-700 mb-1">Full Name</label>
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="w-full px-4 py-2.5 border border-gray-300 rounded-full focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm" placeholder="e.g. John Doe"></asp:TextBox>
                        </div>
                        <div>
                            <label for="txtUsername" class="block text-sm font-semibold text-gray-700 mb-1">Username</label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="w-full px-4 py-2.5 border border-gray-300 rounded-full focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm" placeholder="Choose unique username"></asp:TextBox>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                        <div>
                            <label for="txtEmail" class="block text-sm font-semibold text-gray-700 mb-1">Email Address</label>
                            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="w-full px-4 py-2.5 border border-gray-300 rounded-full focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm" placeholder="e.g. user@example.com"></asp:TextBox>
                        </div>
                        <div>
                            <label for="txtMobile" class="block text-sm font-semibold text-gray-700 mb-1">Mobile Number</label>
                            <asp:TextBox ID="txtMobile" runat="server" CssClass="w-full px-4 py-2.5 border border-gray-300 rounded-full focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm" placeholder="e.g. 9876543210"></asp:TextBox>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                        <div>
                            <label for="txtPassword" class="block text-sm font-semibold text-gray-700 mb-1">Password</label>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="w-full px-4 py-2.5 border border-gray-300 rounded-full focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm" placeholder="Minimum 4 characters"></asp:TextBox>
                        </div>
                        <div>
                            <label for="txtConfirmPassword" class="block text-sm font-semibold text-gray-700 mb-1">Confirm Password</label>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="w-full px-4 py-2.5 border border-gray-300 rounded-full focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm" placeholder="Re-type password"></asp:TextBox>
                        </div>
                    </div>

                    <div>
                        <label for="ddlRole" class="block text-sm font-semibold text-gray-700 mb-1">Account Role</label>
                        <asp:DropDownList ID="ddlRole" runat="server" CssClass="w-full px-4 py-2.5 border border-gray-300 rounded-full focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm bg-white">
                            <asp:ListItem Text="Student (Default)" Value="Student" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Customer / General User" Value="Customer"></asp:ListItem>
                        </asp:DropDownList>
                        <p class="text-xs text-gray-500 mt-1 italic">
                            * Note: For security, Administrator accounts cannot be created via public registration.
                        </p>
                    </div>

                    <div class="pt-4">
                        <asp:Button ID="btnRegister" runat="server" Text="Create Account" OnClick="btnRegister_Click" CssClass="w-full bg-primary text-white border border-primary hover:bg-transparent hover:text-primary py-3 px-6 rounded-full font-bold shadow-md transition duration-300 cursor-pointer text-base" />
                    </div>

                    <div class="text-center text-sm text-gray-500 pt-3">
                        Already have an account? 
                        <a href="Login.aspx" class="text-primary font-bold hover:underline">Log in here</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
