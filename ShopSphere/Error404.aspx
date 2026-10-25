<%@ Page Title="404 - Page Not Found" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Error404.aspx.cs" Inherits="ShopSphere.Error404" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Tailstore 404 Section -->
    <section id="404-page" class="bg-white py-12 flex items-center justify-center min-h-[60vh]">
        <div class="mx-auto max-w-screen-lg px-4 md:px-8">
            <div class="grid gap-6 sm:grid-cols-2 items-center">
                <!-- Content Column -->
                <div class="flex flex-col items-center justify-center sm:items-start text-center sm:text-left">
                    <span class="text-xs font-bold uppercase tracking-widest text-primary mb-2">Error 404</span>
                    <h1 class="text-4xl sm:text-5xl font-extrabold text-gray-900 mb-4">Page Not Found</h1>
                    <p class="text-gray-500 mb-8 leading-relaxed">
                        The requested page or resource could not be located on the ShopSphere server. It might have been relocated or is temporarily offline.
                    </p>
                    <div class="flex space-x-4">
                        <a href="Default.aspx" class="bg-primary hover:bg-transparent border border-primary text-white hover:text-primary font-semibold px-5 py-2.5 rounded-full transition shadow">
                            <i class="fa-solid fa-house mr-2"></i> Return Home
                        </a>
                        <a href="Shop.aspx" class="bg-gray-100 hover:bg-gray-200 text-gray-800 font-semibold px-5 py-2.5 rounded-full transition border border-gray-300">
                            Explore Shop
                        </a>
                    </div>
                </div>

                <!-- Illustration Column -->
                <div class="relative overflow-hidden rounded-xl bg-gray-50 shadow-md border border-gray-100">
                    <img src="assets/images/404.jpg" alt="404 Not Found" class="w-full h-auto max-h-96 object-cover">
                </div>
            </div>
        </div>
    </section>
</asp:Content>
