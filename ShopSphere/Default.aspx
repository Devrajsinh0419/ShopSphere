<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ShopSphere._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Hero Banner Section -->
    <section id="banner" class="relative my-8">
        <div class="container mx-auto px-4">
            <div class="relative rounded-2xl overflow-hidden shadow-2xl bg-cover bg-center py-24 sm:py-32" style="background-image: url('assets/images/banner1.jpg');">
                <!-- Dark Overlay -->
                <div class="absolute inset-0 bg-black bg-opacity-60 backdrop-blur-xs"></div>
                
                <div class="relative z-10 flex flex-col items-center justify-center text-center text-white px-6">
                    <span class="bg-primary/90 text-white text-xs font-bold tracking-widest uppercase px-4 py-1.5 rounded-full mb-4 shadow">
                        ITM SLS BU &bull; B.Tech Semester-3 PBL
                    </span>
                    <h1 class="text-4xl sm:text-6xl font-extrabold tracking-tight mb-4">
                        Welcome to <span class="text-primary">ShopSphere</span>
                    </h1>
                    <p class="max-w-2xl text-lg sm:text-xl text-gray-200 mb-8 font-light">
                        A modern ASP.NET Web Forms e-commerce portal and practical computation suite featuring role-based authentication, screen time analytics, and progressive tariff billing.
                    </p>
                    <div class="flex flex-wrap justify-center gap-4">
                        <a href="Shop.aspx" class="bg-primary border border-primary hover:bg-transparent text-white hover:text-primary font-semibold px-6 py-3 rounded-full transition duration-300 shadow-lg">
                            <i class="fa-solid fa-bag-shopping mr-2"></i> Explore Shop
                        </a>
                        <a href="ScreenTime.aspx" class="bg-white/10 hover:bg-white text-white hover:text-gray-900 border border-white font-semibold px-6 py-3 rounded-full transition duration-300 backdrop-blur-sm">
                            <i class="fa-brands fa-instagram mr-2"></i> Instagram Analyzer
                        </a>
                        <a href="ElectricityBill.aspx" class="bg-white/10 hover:bg-white text-white hover:text-gray-900 border border-white font-semibold px-6 py-3 rounded-full transition duration-300 backdrop-blur-sm">
                            <i class="fa-solid fa-bolt mr-2"></i> Electricity Bill
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- PBL Modules Highlights Section -->
    <section class="py-12 bg-white">
        <div class="container mx-auto px-4">
            <div class="text-center max-w-3xl mx-auto mb-12">
                <h2 class="text-3xl font-extrabold text-gray-900 mb-3">Project-Based Learning Modules</h2>
                <p class="text-gray-600">All required semester tasks implemented and integrated into a unified e-commerce experience.</p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <!-- Card 1: Three-Role Login -->
                <div class="bg-gray-50 border border-gray-200 rounded-2xl p-6 hover:shadow-xl transition-all duration-300 flex flex-col justify-between">
                    <div>
                        <div class="w-12 h-12 rounded-xl bg-primary/10 text-primary flex items-center justify-center text-2xl mb-4">
                            <i class="fa-solid fa-user-shield"></i>
                        </div>
                        <h3 class="text-xl font-bold text-gray-900 mb-2">3-Role Authentication</h3>
                        <p class="text-gray-600 text-sm mb-4">
                            Assignment 1 part 2: Role-based login handling Administrator (admin/admin123), Student (student/stud123), and Faculty (faculty/fac123) with database password hashing.
                        </p>
                    </div>
                    <a href="Login.aspx" class="text-primary font-bold text-sm inline-flex items-center hover:underline">
                        Test Login <i class="fa-solid fa-arrow-right ml-2 text-xs"></i>
                    </a>
                </div>

                <!-- Card 2: Instagram Analyzer -->
                <div class="bg-gray-50 border border-gray-200 rounded-2xl p-6 hover:shadow-xl transition-all duration-300 flex flex-col justify-between">
                    <div>
                        <div class="w-12 h-12 rounded-xl bg-pink-500/10 text-pink-600 flex items-center justify-center text-2xl mb-4">
                            <i class="fa-brands fa-instagram"></i>
                        </div>
                        <h3 class="text-xl font-bold text-gray-900 mb-2">Screen Time Analyzer</h3>
                        <p class="text-gray-600 text-sm mb-4">
                            Assignment 1 part 1: Evaluates daily Instagram screen time with 5 dynamic usage categories (0-1h, >1-2h, >2-4h, >4-6h, >6h) using conditional logic.
                        </p>
                    </div>
                    <a href="ScreenTime.aspx" class="text-pink-600 font-bold text-sm inline-flex items-center hover:underline">
                        Open Analyzer <i class="fa-solid fa-arrow-right ml-2 text-xs"></i>
                    </a>
                </div>

                <!-- Card 3: Electricity Bill -->
                <div class="bg-gray-50 border border-gray-200 rounded-2xl p-6 hover:shadow-xl transition-all duration-300 flex flex-col justify-between">
                    <div>
                        <div class="w-12 h-12 rounded-xl bg-amber-500/10 text-amber-600 flex items-center justify-center text-2xl mb-4">
                            <i class="fa-solid fa-bolt"></i>
                        </div>
                        <h3 class="text-xl font-bold text-gray-900 mb-2">Electricity Bill Calculator</h3>
                        <p class="text-gray-600 text-sm mb-4">
                            Assignment 2: Progressive tariff slabs (₹4.20, ₹7.50, ₹10.00), tiered GST (5%, 12%, 18%), input validation, and full Reset functionality.
                        </p>
                    </div>
                    <a href="ElectricityBill.aspx" class="text-amber-600 font-bold text-sm inline-flex items-center hover:underline">
                        Calculate Bill <i class="fa-solid fa-arrow-right ml-2 text-xs"></i>
                    </a>
                </div>

                <!-- Card 4: GridView Viewer -->
                <div class="bg-gray-50 border border-gray-200 rounded-2xl p-6 hover:shadow-xl transition-all duration-300 flex flex-col justify-between">
                    <div>
                        <div class="w-12 h-12 rounded-xl bg-blue-500/10 text-blue-600 flex items-center justify-center text-2xl mb-4">
                            <i class="fa-solid fa-table-list"></i>
                        </div>
                        <h3 class="text-xl font-bold text-gray-900 mb-2">ASP.NET GridView</h3>
                        <p class="text-gray-600 text-sm mb-4">
                            Mandatory PBL requirement: Visualizing live SQL Server database records (Users, Bills, Screen Time, Products) using styled GridView controls.
                        </p>
                    </div>
                    <a href="Records.aspx" class="text-blue-600 font-bold text-sm inline-flex items-center hover:underline">
                        View Records <i class="fa-solid fa-arrow-right ml-2 text-xs"></i>
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Featured Products Showcase Section -->
    <section class="py-12 bg-gray-50">
        <div class="container mx-auto px-4">
            <div class="flex justify-between items-end mb-8">
                <div>
                    <span class="text-primary font-bold text-sm uppercase tracking-wider">Tailstore Catalog</span>
                    <h2 class="text-3xl font-extrabold text-gray-900">Featured Products</h2>
                </div>
                <a href="Shop.aspx" class="hidden sm:inline-flex items-center text-primary font-semibold hover:underline">
                    View All Products <i class="fa-solid fa-arrow-right ml-2"></i>
                </a>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                <!-- Product Card 1 -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden hover:shadow-lg transition">
                    <img src="assets/images/products/5.jpg" alt="Blue women's suit" class="w-full h-64 object-cover">
                    <div class="p-4">
                        <span class="text-xs text-gray-500 font-medium">Women</span>
                        <h4 class="font-bold text-gray-900 mt-1 mb-2">Blue Women's Suit</h4>
                        <div class="flex items-center justify-between mb-4">
                            <div>
                                <span class="text-lg font-bold text-primary">$19.99</span>
                                <span class="text-sm line-through text-gray-400 ml-2">$24.99</span>
                            </div>
                        </div>
                        <a href="Shop.aspx" class="block text-center bg-primary border border-primary hover:bg-transparent text-white hover:text-primary py-2 px-4 rounded-full text-sm font-semibold transition">
                            View Details
                        </a>
                    </div>
                </div>

                <!-- Product Card 2 -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden hover:shadow-lg transition">
                    <img src="assets/images/products/6.jpg" alt="White shirt" class="w-full h-64 object-cover">
                    <div class="p-4">
                        <span class="text-xs text-gray-500 font-medium">Women</span>
                        <h4 class="font-bold text-gray-900 mt-1 mb-2">White Long Sleeve Shirt</h4>
                        <div class="flex items-center justify-between mb-4">
                            <div>
                                <span class="text-lg font-bold text-gray-900">$29.99</span>
                                <span class="text-sm line-through text-gray-400 ml-2">$34.99</span>
                            </div>
                        </div>
                        <a href="Shop.aspx" class="block text-center bg-primary border border-primary hover:bg-transparent text-white hover:text-primary py-2 px-4 rounded-full text-sm font-semibold transition">
                            View Details
                        </a>
                    </div>
                </div>

                <!-- Product Card 3 -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden hover:shadow-lg transition">
                    <img src="assets/images/products/7.jpg" alt="Yellow men's suit" class="w-full h-64 object-cover">
                    <div class="p-4">
                        <span class="text-xs text-gray-500 font-medium">Men</span>
                        <h4 class="font-bold text-gray-900 mt-1 mb-2">Yellow Men's Suit</h4>
                        <div class="flex items-center justify-between mb-4">
                            <div>
                                <span class="text-lg font-bold text-gray-900">$15.99</span>
                                <span class="text-sm line-through text-gray-400 ml-2">$19.99</span>
                            </div>
                        </div>
                        <a href="Shop.aspx" class="block text-center bg-primary border border-primary hover:bg-transparent text-white hover:text-primary py-2 px-4 rounded-full text-sm font-semibold transition">
                            View Details
                        </a>
                    </div>
                </div>

                <!-- Product Card 4 -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden hover:shadow-lg transition">
                    <img src="assets/images/products/8.jpg" alt="Red dress" class="w-full h-64 object-cover">
                    <div class="p-4">
                        <span class="text-xs text-gray-500 font-medium">Women</span>
                        <h4 class="font-bold text-gray-900 mt-1 mb-2">Red Designer Dress</h4>
                        <div class="flex items-center justify-between mb-4">
                            <div>
                                <span class="text-lg font-bold text-primary">$39.99</span>
                                <span class="text-sm line-through text-gray-400 ml-2">$49.99</span>
                            </div>
                        </div>
                        <a href="Shop.aspx" class="block text-center bg-primary border border-primary hover:bg-transparent text-white hover:text-primary py-2 px-4 rounded-full text-sm font-semibold transition">
                            View Details
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
