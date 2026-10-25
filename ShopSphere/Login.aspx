<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ShopSphere.Login" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Breadcrumb -->
    <div class="bg-gray-100 py-6 border-b border-gray-200">
        <div class="container mx-auto px-4 flex justify-between items-center">
            <h1 class="text-2xl font-bold text-gray-900">User Authentication</h1>
            <div class="text-sm text-gray-500">
                <a href="Default.aspx" class="hover:text-primary">Home</a> &nbsp;/&nbsp; <span class="text-primary font-semibold">Login</span>
            </div>
        </div>
    </div>

    <!-- Login Section -->
    <section id="login-section" class="py-16 bg-gray-50">
        <div class="container mx-auto px-4">
            <div class="max-w-4xl mx-auto flex flex-col md:flex-row gap-8 items-start">
                
                <!-- Main Login Card (Matching Tailstore template) -->
                <div class="w-full md:w-3/5 bg-white rounded-2xl shadow-md border border-gray-200 p-8 sm:p-10">
                    <div class="mb-6">
                        <span class="text-xs font-bold uppercase tracking-wider text-primary">Assignment 1 &bull; Part 2</span>
                        <h2 class="text-3xl font-extrabold text-gray-900 mt-1">Sign In to ShopSphere</h2>
                        <p class="text-gray-500 text-sm mt-1">Enter your username and password to access role-specific privileges.</p>
                    </div>

                    <!-- Output Message Label (Assignment Requirement: use Label control instead of Response.Write) -->
                    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="mb-6">
                        <div id="divAlertBox" runat="server" class="px-4 py-3 rounded-xl border flex items-center space-x-3 text-sm">
                            <i id="iconAlert" runat="server" class="fa-solid fa-circle-info text-base"></i>
                            <asp:Label ID="lblMessage" runat="server" Font-Bold="true"></asp:Label>
                        </div>
                    </asp:Panel>

                    <!-- Login Form Controls -->
                    <div class="space-y-5">
                        <div>
                            <label for="txtUsername" class="block text-sm font-semibold text-gray-700 mb-1">Username or Email</label>
                            <div class="relative">
                                <asp:TextBox ID="txtUsername" runat="server" CssClass="w-full pl-10 pr-4 py-2.5 border border-gray-300 rounded-full focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm" placeholder="Enter username (e.g. admin, student, faculty)"></asp:TextBox>
                                <span class="absolute left-3.5 top-3 text-gray-400">
                                    <i class="fa-solid fa-user"></i>
                                </span>
                            </div>
                        </div>

                        <div>
                            <label for="txtPassword" class="block text-sm font-semibold text-gray-700 mb-1">Password</label>
                            <div class="relative">
                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="w-full pl-10 pr-4 py-2.5 border border-gray-300 rounded-full focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm" placeholder="Enter your password"></asp:TextBox>
                                <span class="absolute left-3.5 top-3 text-gray-400">
                                    <i class="fa-solid fa-lock"></i>
                                </span>
                            </div>
                        </div>

                        <div class="pt-2">
                            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="w-full bg-primary text-white border border-primary hover:bg-transparent hover:text-primary py-3 px-6 rounded-full font-bold shadow-md transition duration-300 cursor-pointer text-base" />
                        </div>

                        <div class="text-center text-sm text-gray-500 pt-3">
                            Don't have an account yet? 
                            <a href="Register.aspx" class="text-primary font-bold hover:underline">Register here</a>
                        </div>
                    </div>
                </div>

                <!-- Demonstration & Assignment Guide Card -->
                <div class="w-full md:w-2/5 bg-gray-900 text-white rounded-2xl shadow-md p-6 sm:p-8 space-y-6">
                    <div>
                        <span class="bg-primary/20 text-primary text-xs font-bold px-3 py-1 rounded-full uppercase tracking-wider">Viva Quick-Test</span>
                        <h3 class="text-xl font-bold mt-3 mb-1">Three-Role Credentials</h3>
                        <p class="text-gray-400 text-xs leading-relaxed">
                            Click any preset role below to quickly populate the form for practical demonstration:
                        </p>
                    </div>

                    <!-- Fast autofill buttons for viva -->
                    <div class="space-y-3">
                        <asp:Button ID="btnFillAdmin" runat="server" Text="1. Admin (admin / admin123)" OnClick="btnFillAdmin_Click" CssClass="w-full text-left bg-gray-800 hover:bg-gray-700 text-gray-200 border border-gray-700 py-2.5 px-4 rounded-xl text-xs font-semibold transition cursor-pointer flex items-center justify-between" />
                        <asp:Button ID="btnFillStudent" runat="server" Text="2. Student (student / stud123)" OnClick="btnFillStudent_Click" CssClass="w-full text-left bg-gray-800 hover:bg-gray-700 text-gray-200 border border-gray-700 py-2.5 px-4 rounded-xl text-xs font-semibold transition cursor-pointer flex items-center justify-between" />
                        <asp:Button ID="btnFillFaculty" runat="server" Text="3. Faculty (faculty / fac123)" OnClick="btnFillFaculty_Click" CssClass="w-full text-left bg-gray-800 hover:bg-gray-700 text-gray-200 border border-gray-700 py-2.5 px-4 rounded-xl text-xs font-semibold transition cursor-pointer flex items-center justify-between" />
                    </div>

                    <div class="border-t border-gray-800 pt-4 text-xs text-gray-400 space-y-2">
                        <p class="font-bold text-gray-300">Assignment Logic Note:</p>
                        <p>&bull; <b>admin</b> &rarr; "Welcome Administrator"</p>
                        <p>&bull; <b>student</b> &rarr; "Welcome Student"</p>
                        <p>&bull; <b>faculty</b> &rarr; "Welcome Faculty"</p>
                        <p>&bull; <b>Invalid</b> &rarr; "Invalid Username or Password"</p>
                        <p class="pt-2 text-gray-400">Passwords are securely verified via salted PBKDF2 hash against the SQL Server <code>Users</code> table.</p>
                    </div>
                </div>

            </div>
        </div>
    </section>
</asp:Content>
