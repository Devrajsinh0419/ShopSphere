<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ShopSphere.Login" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <section class="auth-page">
        <div class="auth-card auth-card-login">
            <div class="auth-heading">
                <span class="auth-kicker">Your account</span>
                <h1>Welcome back</h1>
                <p>Sign in to continue to ShopSphere.</p>
            </div>

            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="auth-message">
                <div id="divAlertBox" runat="server" class="px-4 py-3 rounded-xl border flex items-center space-x-3 text-sm">
                    <i id="iconAlert" runat="server" class="fa-solid fa-circle-info text-base" aria-hidden="true"></i>
                    <asp:Label ID="lblMessage" runat="server" Font-Bold="true"></asp:Label>
                </div>
            </asp:Panel>

            <div class="auth-fields">
                <div class="auth-field">
                    <label for="<%= txtUsername.ClientID %>">Username or email</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="auth-input" autocomplete="username"></asp:TextBox>
                </div>
                <div class="auth-field">
                    <label for="<%= txtPassword.ClientID %>">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="auth-input" autocomplete="current-password"></asp:TextBox>
                </div>
                <asp:Button ID="btnLogin" runat="server" Text="Sign in" OnClick="btnLogin_Click" CssClass="auth-submit" />
            </div>

            <p class="auth-switch">New to ShopSphere? <a href="Register.aspx">Create an account</a></p>
        </div>
    </section>
</asp:Content>
