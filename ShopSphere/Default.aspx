<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ShopSphere._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlFlashMessage" runat="server" Visible="false" CssClass="site-notification container mx-auto px-4" role="status">
        <i class="fa-solid fa-circle-check" aria-hidden="true"></i>
        <asp:Label ID="lblFlashMessage" runat="server"></asp:Label>
    </asp:Panel>

    <section class="home-hero">
        <div class="container mx-auto px-4 home-hero-content">
            <span class="home-eyebrow">ShopSphere · Store &amp; project tools</span>
            <h1>Find your next<br /><span>everyday favourite.</span></h1>
            <p>Browse the collection, or use the practical tools built into ShopSphere.</p>
            <div class="home-actions">
                <a href="Shop.aspx" class="button button-primary"><i class="fa-solid fa-bag-shopping" aria-hidden="true"></i> Browse the shop</a>
                <a href="#project-tools" class="button button-secondary">Explore project tools</a>
            </div>
        </div>
    </section>

    <section id="project-tools" class="home-tools container mx-auto px-4">
        <div class="section-heading">
            <div><span class="home-eyebrow">Project tools</span><h2>Quick links</h2></div>
        </div>
        <div class="tool-grid">
            <a href="ScreenTime.aspx" class="tool-card"><span class="tool-icon"><i class="fa-brands fa-instagram" aria-hidden="true"></i></span><span><strong>Screen time</strong><small>Instagram usage analyzer</small></span><i class="fa-solid fa-arrow-right tool-arrow" aria-hidden="true"></i></a>
            <a href="ElectricityBill.aspx" class="tool-card"><span class="tool-icon"><i class="fa-solid fa-bolt" aria-hidden="true"></i></span><span><strong>Electricity bill</strong><small>Usage and charge calculator</small></span><i class="fa-solid fa-arrow-right tool-arrow" aria-hidden="true"></i></a>
            <a href="Records.aspx" class="tool-card"><span class="tool-icon"><i class="fa-solid fa-table-list" aria-hidden="true"></i></span><span><strong>Records</strong><small>Browse project data</small></span><i class="fa-solid fa-arrow-right tool-arrow" aria-hidden="true"></i></a>
        </div>
    </section>
</asp:Content>
