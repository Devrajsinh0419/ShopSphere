<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="ShopSphere.Register" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <section class="auth-page">
        <div class="auth-card auth-card-register">
            <div class="auth-heading">
                <span class="auth-kicker">Join ShopSphere</span>
                <h1>Create your account</h1>
                <p>Enter your details to get started.</p>
            </div>

            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="auth-message">
                <div id="divAlertBox" runat="server" class="px-4 py-3 rounded-xl border flex items-center space-x-3 text-sm">
                    <i id="iconAlert" runat="server" class="fa-solid fa-circle-info text-base" aria-hidden="true"></i>
                    <asp:Label ID="lblMessage" runat="server" Font-Bold="true"></asp:Label>
                </div>
            </asp:Panel>

            <div class="auth-fields">
                <div class="auth-field-grid">
                    <div class="auth-field">
                        <label for="<%= txtFullName.ClientID %>">Full name</label>
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="auth-input" autocomplete="name"></asp:TextBox>
                    </div>
                    <div class="auth-field">
                        <label for="<%= txtUsername.ClientID %>">Username</label>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="auth-input" autocomplete="username"></asp:TextBox>
                    </div>
                    <div class="auth-field">
                        <label for="<%= txtEmail.ClientID %>">Email address</label>
                        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="auth-input" autocomplete="email"></asp:TextBox>
                    </div>
                    <div class="auth-field">
                        <label for="<%= txtMobile.ClientID %>">Mobile number <span class="auth-optional">Optional</span></label>
                        <asp:TextBox ID="txtMobile" runat="server" CssClass="auth-input" autocomplete="tel"></asp:TextBox>
                    </div>
                    <div class="auth-field">
                        <label for="<%= txtPassword.ClientID %>">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="auth-input" autocomplete="new-password"></asp:TextBox>
                    </div>
                    <div class="auth-field">
                        <label for="<%= txtConfirmPassword.ClientID %>">Confirm password</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="auth-input" autocomplete="new-password"></asp:TextBox>
                    </div>
                </div>

                <div class="auth-field">
                    <label for="<%= ddlRole.ClientID %>">Account type</label>
                    <asp:DropDownList ID="ddlRole" runat="server" CssClass="auth-input auth-select">
                        <asp:ListItem Text="Student" Value="Student" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Customer" Value="Customer"></asp:ListItem>
                    </asp:DropDownList>
                    <p class="auth-help">Administrator and faculty accounts can’t be created here.</p>
                </div>

                <asp:Button ID="btnRegister" runat="server" Text="Create account" OnClick="btnRegister_Click" CssClass="auth-submit" />
            </div>

            <p class="auth-switch">Already have an account? <a href="Login.aspx">Sign in</a></p>
        </div>
    </section>
</asp:Content>
