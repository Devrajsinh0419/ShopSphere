using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;

namespace ShopSphere.Helpers
{
    /// <summary>
    /// Database Helper Class for ShopSphere.
    /// Provides ADO.NET database operations, automatic schema initialization,
    /// seed data generation, and secure password hashing with salt.
    /// Designed for second-year B.Tech students to understand and explain.
    /// </summary>
    public static class DbHelper
    {
        /// <summary>
        /// Reads the database connection string from Web.config.
        /// </summary>
        public static string GetConnectionString()
        {
            if (ConfigurationManager.ConnectionStrings["ShopSphereDB"] != null)
            {
                return ConfigurationManager.ConnectionStrings["ShopSphereDB"].ConnectionString;
            }
            // Fallback default for LocalDB
            return @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=ShopSphereDB;Integrated Security=True;Connect Timeout=30;Encrypt=False;";
        }

        /// <summary>
        /// Creates and opens a new SQL Server connection.
        /// Caller is responsible for disposing or wrapping in 'using'.
        /// </summary>
        public static SqlConnection GetOpenConnection()
        {
            SqlConnection conn = new SqlConnection(GetConnectionString());
            conn.Open();
            return conn;
        }

        /// <summary>
        /// Automatically checks and initializes the database, tables, and seed data.
        /// Called on application start in Global.asax.cs.
        /// </summary>
        public static void InitializeDatabase()
        {
            try
            {
                EnsureDatabaseCreated();
                CreateTablesIfNotExist();
                SeedDefaultUsers();
                SeedDefaultProducts();
                SeedSampleCalculations();
            }
            catch (Exception ex)
            {
                // In a production environment we would log to a file.
                // For college demo, we write to System.Diagnostics.Debug so it never crashes the application.
                System.Diagnostics.Debug.WriteLine("Database initialization note: " + ex.Message);
            }
        }

        /// <summary>
        /// If connecting to LocalDB or SQL Server and the target database does not exist,
        /// connects to 'master' database and creates 'ShopSphereDB'.
        /// </summary>
        private static void EnsureDatabaseCreated()
        {
            try
            {
                SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder(GetConnectionString());
                string targetDbName = string.IsNullOrEmpty(builder.InitialCatalog) ? "ShopSphereDB" : builder.InitialCatalog;

                // Create a temporary connection pointing to 'master'
                SqlConnectionStringBuilder masterBuilder = new SqlConnectionStringBuilder(builder.ConnectionString);
                masterBuilder.InitialCatalog = "master";

                using (SqlConnection masterConn = new SqlConnection(masterBuilder.ConnectionString))
                {
                    masterConn.Open();
                    string checkDbSql = "IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = @dbName) " +
                                        "BEGIN CREATE DATABASE [" + targetDbName + "] END";
                    using (SqlCommand cmd = new SqlCommand(checkDbSql, masterConn))
                    {
                        cmd.Parameters.AddWithValue("@dbName", targetDbName);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch
            {
                // If user uses specific rights or DB already exists, continue safely
            }
        }

        /// <summary>
        /// Creates the required relational tables: Users, ElectricityBills, ScreenTimeLogs, Products.
        /// </summary>
        private static void CreateTablesIfNotExist()
        {
            using (SqlConnection conn = GetOpenConnection())
            {
                // 1. Users Table
                string createUsersTable = @"
                    IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Users')
                    BEGIN
                        CREATE TABLE Users (
                            UserId INT IDENTITY(1,1) PRIMARY KEY,
                            Username NVARCHAR(50) NOT NULL UNIQUE,
                            PasswordHash NVARCHAR(255) NOT NULL,
                            Salt NVARCHAR(255) NOT NULL,
                            FullName NVARCHAR(100) NOT NULL,
                            Email NVARCHAR(100) NOT NULL UNIQUE,
                            Mobile NVARCHAR(20) NULL,
                            Role NVARCHAR(50) NOT NULL,
                            CreatedAt DATETIME DEFAULT GETDATE()
                        );
                    END";

                // 2. ElectricityBills Table (Assignment 2)
                string createBillsTable = @"
                    IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ElectricityBills')
                    BEGIN
                        CREATE TABLE ElectricityBills (
                            BillId INT IDENTITY(1,1) PRIMARY KEY,
                            CustomerId NVARCHAR(50) NOT NULL,
                            CustomerName NVARCHAR(100) NOT NULL,
                            UnitsConsumed INT NOT NULL,
                            BillBeforeGst DECIMAL(18,2) NOT NULL,
                            GstRate DECIMAL(5,2) NOT NULL,
                            GstAmount DECIMAL(18,2) NOT NULL,
                            TotalAmount DECIMAL(18,2) NOT NULL,
                            CalculatedAt DATETIME DEFAULT GETDATE()
                        );
                    END";

                // 3. ScreenTimeLogs Table (Assignment 1)
                string createScreenTimeTable = @"
                    IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ScreenTimeLogs')
                    BEGIN
                        CREATE TABLE ScreenTimeLogs (
                            LogId INT IDENTITY(1,1) PRIMARY KEY,
                            Username NVARCHAR(50) NOT NULL,
                            ScreenTimeHours DECIMAL(5,2) NOT NULL,
                            UsageCategory NVARCHAR(100) NOT NULL,
                            RecordedAt DATETIME DEFAULT GETDATE()
                        );
                    END";

                // 4. Products Table (Tailstore Catalog)
                string createProductsTable = @"
                    IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Products')
                    BEGIN
                        CREATE TABLE Products (
                            ProductId INT IDENTITY(1,1) PRIMARY KEY,
                            ProductName NVARCHAR(100) NOT NULL,
                            Category NVARCHAR(50) NOT NULL,
                            Price DECIMAL(18,2) NOT NULL,
                            OriginalPrice DECIMAL(18,2) NULL,
                            ImageUrl NVARCHAR(255) NOT NULL,
                            Description NVARCHAR(255) NULL
                        );
                    END";

                using (SqlCommand cmd = new SqlCommand(createUsersTable, conn)) { cmd.ExecuteNonQuery(); }
                using (SqlCommand cmd = new SqlCommand(createBillsTable, conn)) { cmd.ExecuteNonQuery(); }
                using (SqlCommand cmd = new SqlCommand(createScreenTimeTable, conn)) { cmd.ExecuteNonQuery(); }
                using (SqlCommand cmd = new SqlCommand(createProductsTable, conn)) { cmd.ExecuteNonQuery(); }
            }
        }

        /// <summary>
        /// Pre-seeds the three mandatory user roles from the assignment:
        /// admin/admin123 — Administrator
        /// student/stud123 — Student
        /// faculty/fac123 — Faculty
        /// </summary>
        private static void SeedDefaultUsers()
        {
            using (SqlConnection conn = GetOpenConnection())
            {
                // Check if admin exists
                string checkUserSql = "SELECT COUNT(*) FROM Users WHERE Username = @Username";

                // 1. Admin
                using (SqlCommand cmd = new SqlCommand(checkUserSql, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", "admin");
                    int count = (int)cmd.ExecuteScalar();
                    if (count == 0)
                    {
                        InsertUserDirect(conn, "admin", "admin123", "System Administrator", "admin@shopsphere.edu", "9876543210", "Administrator");
                    }
                }

                // 2. Student
                using (SqlCommand cmd = new SqlCommand(checkUserSql, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", "student");
                    int count = (int)cmd.ExecuteScalar();
                    if (count == 0)
                    {
                        InsertUserDirect(conn, "student", "stud123", "B.Tech Student", "student@shopsphere.edu", "9876543211", "Student");
                    }
                }

                // 3. Faculty
                using (SqlCommand cmd = new SqlCommand(checkUserSql, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", "faculty");
                    int count = (int)cmd.ExecuteScalar();
                    if (count == 0)
                    {
                        InsertUserDirect(conn, "faculty", "fac123", "Department Faculty", "faculty@shopsphere.edu", "9876543212", "Faculty");
                    }
                }
            }
        }

        /// <summary>
        /// Inserts a user with hashed password and salt into the database.
        /// </summary>
        private static void InsertUserDirect(SqlConnection conn, string username, string plainPassword, string fullName, string email, string mobile, string role)
        {
            string salt = GenerateSalt();
            string hash = HashPassword(plainPassword, salt);

            string insertSql = @"
                INSERT INTO Users (Username, PasswordHash, Salt, FullName, Email, Mobile, Role, CreatedAt)
                VALUES (@Username, @PasswordHash, @Salt, @FullName, @Email, @Mobile, @Role, GETDATE())";

            using (SqlCommand cmd = new SqlCommand(insertSql, conn))
            {
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@PasswordHash", hash);
                cmd.Parameters.AddWithValue("@Salt", salt);
                cmd.Parameters.AddWithValue("@FullName", fullName);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Mobile", (object)mobile ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@Role", role);
                cmd.ExecuteNonQuery();
            }
        }

        /// <summary>
        /// Seeds the Tailstore product items into the database if the table is empty.
        /// </summary>
        private static void SeedDefaultProducts()
        {
            using (SqlConnection conn = GetOpenConnection())
            {
                string countSql = "SELECT COUNT(*) FROM Products";
                using (SqlCommand countCmd = new SqlCommand(countSql, conn))
                {
                    int count = (int)countCmd.ExecuteScalar();
                    if (count == 0)
                    {
                        string insertSql = @"
                            INSERT INTO Products (ProductName, Category, Price, OriginalPrice, ImageUrl, Description) VALUES
                            (N'Blue Women''s Suit', N'Women', 19.99, 24.99, N'assets/images/products/5.jpg', N'Elegant formal slim-fit suit for work and events'),
                            (N'White Long Sleeve Shirt', N'Women', 29.99, 34.99, N'assets/images/products/6.jpg', N'Classic breathable white button-down shirt'),
                            (N'Yellow Men''s Suit', N'Men', 15.99, 19.99, N'assets/images/products/7.jpg', N'Modern casual blazer crafted with lightweight fabric'),
                            (N'Red Designer Dress', N'Women', 39.99, 49.99, N'assets/images/products/8.jpg', N'Vibrant evening dress with contemporary silhouette'),
                            (N'Black Leather Jacket', N'Women', 49.99, 59.99, N'assets/images/products/4.jpg', N'Premium faux leather biker jacket with silver hardware'),
                            (N'Black Evening Gown', N'Women', 35.99, 45.00, N'assets/images/products/3.jpg', N'Timeless formal floor-length dress'),
                            (N'Casual Cotton Tee', N'Men', 12.99, 18.00, N'assets/images/products/1.jpg', N'Everyday comfort fit premium round-neck t-shirt'),
                            (N'Sporty Urban Hoodie', N'Men', 28.50, 36.00, N'assets/images/products/2.jpg', N'Warm fleece-lined pullover for cool days');";

                        using (SqlCommand insertCmd = new SqlCommand(insertSql, conn))
                        {
                            insertCmd.ExecuteNonQuery();
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Seeds sample calculations so GridViews have initial demo data.
        /// </summary>
        private static void SeedSampleCalculations()
        {
            using (SqlConnection conn = GetOpenConnection())
            {
                // Seed sample electricity bills if empty
                string countBillsSql = "SELECT COUNT(*) FROM ElectricityBills";
                using (SqlCommand cmd = new SqlCommand(countBillsSql, conn))
                {
                    int count = (int)cmd.ExecuteScalar();
                    if (count == 0)
                    {
                        string insertBills = @"
                            INSERT INTO ElectricityBills (CustomerId, CustomerName, UnitsConsumed, BillBeforeGst, GstRate, GstAmount, TotalAmount, CalculatedAt) VALUES
                            (N'CUST-1001', N'Rohan Sharma', 150, 630.00, 12.00, 75.60, 705.60, DATEADD(day, -3, GETDATE())),
                            (N'CUST-1002', N'Pooja Patel', 250, 1215.00, 18.00, 218.70, 1433.70, DATEADD(day, -2, GETDATE())),
                            (N'CUST-1003', N'Aman Gupta', 80, 336.00, 5.00, 16.80, 352.80, DATEADD(day, -1, GETDATE()));";
                        using (SqlCommand insertCmd = new SqlCommand(insertBills, conn))
                        {
                            insertCmd.ExecuteNonQuery();
                        }
                    }
                }

                // Seed sample screen time logs if empty
                string countLogsSql = "SELECT COUNT(*) FROM ScreenTimeLogs";
                using (SqlCommand cmd = new SqlCommand(countLogsSql, conn))
                {
                    int count = (int)cmd.ExecuteScalar();
                    if (count == 0)
                    {
                        string insertLogs = @"
                            INSERT INTO ScreenTimeLogs (Username, ScreenTimeHours, UsageCategory, RecordedAt) VALUES
                            (N'student', 0.8, N'Excellent! Healthy Usage', DATEADD(day, -3, GETDATE())),
                            (N'student', 1.5, N'Good Usage', DATEADD(day, -2, GETDATE())),
                            (N'faculty', 3.0, N'Moderate Usage', DATEADD(day, -1, GETDATE())),
                            (N'student', 5.2, N'High Usage', GETDATE());";
                        using (SqlCommand insertCmd = new SqlCommand(insertLogs, conn))
                        {
                            insertCmd.ExecuteNonQuery();
                        }
                    }
                }
            }
        }

        // ==========================================
        // PASSWORD HASHING AND AUTHENTICATION
        // ==========================================

        /// <summary>
        /// Generates a cryptographically random 16-byte salt, encoded as Base64.
        /// </summary>
        public static string GenerateSalt()
        {
            byte[] saltBytes = new byte[16];
            using (RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider())
            {
                rng.GetBytes(saltBytes);
            }
            return Convert.ToBase64String(saltBytes);
        }

        /// <summary>
        /// Derives a PBKDF2 hash of the given password using the provided salt.
        /// Compatible across all .NET Framework 4.7.2 environments.
        /// </summary>
        public static string HashPassword(string password, string salt)
        {
            byte[] saltBytes = Convert.FromBase64String(salt);
            using (Rfc2898DeriveBytes pbkdf2 = new Rfc2898DeriveBytes(password, saltBytes, 10000))
            {
                byte[] hashBytes = pbkdf2.GetBytes(32);
                return Convert.ToBase64String(hashBytes);
            }
        }

        /// <summary>
        /// Verifies whether the entered password matches the stored hash when hashed with stored salt.
        /// </summary>
        public static bool VerifyPassword(string enteredPassword, string storedHash, string storedSalt)
        {
            try
            {
                string hash = HashPassword(enteredPassword, storedSalt);
                return string.Equals(hash, storedHash, StringComparison.Ordinal);
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// Authenticates user against the SQL Server Users table.
        /// Returns true if valid, and outputs the User's Role and Full Name.
        /// </summary>
        public static bool AuthenticateUser(string usernameOrEmail, string password, out string role, out string fullName, out string username)
        {
            role = string.Empty;
            fullName = string.Empty;
            username = string.Empty;

            try
            {
                using (SqlConnection conn = GetOpenConnection())
                {
                    string selectSql = @"
                        SELECT Username, PasswordHash, Salt, FullName, Role 
                        FROM Users 
                        WHERE Username = @Input OR Email = @Input";

                    using (SqlCommand cmd = new SqlCommand(selectSql, conn))
                    {
                        cmd.Parameters.AddWithValue("@Input", usernameOrEmail.Trim());

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string storedUsername = reader["Username"].ToString();
                                string storedHash = reader["PasswordHash"].ToString();
                                string storedSalt = reader["Salt"].ToString();
                                string storedRole = reader["Role"].ToString();
                                string storedFullName = reader["FullName"].ToString();

                                if (VerifyPassword(password, storedHash, storedSalt))
                                {
                                    role = storedRole;
                                    fullName = storedFullName;
                                    username = storedUsername;
                                    return true;
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Authentication error: " + ex.Message);
            }

            return false;
        }

        /// <summary>
        /// Registers a new user into the database.
        /// Safety Rule: Public registration will never assign Administrator or Faculty role.
        /// Defaults to 'Student' or 'Customer'.
        /// </summary>
        public static bool RegisterUser(string username, string fullName, string email, string mobile, string password, string requestedRole, out string errorMessage)
        {
            errorMessage = string.Empty;

            // Enforce role safety
            string safeRole = "Student";
            if (string.Equals(requestedRole, "Customer", StringComparison.OrdinalIgnoreCase))
            {
                safeRole = "Customer";
            }
            else
            {
                safeRole = "Student";
            }

            try
            {
                using (SqlConnection conn = GetOpenConnection())
                {
                    // Check if username already exists
                    string checkSql = "SELECT COUNT(*) FROM Users WHERE Username = @Username";
                    using (SqlCommand checkCmd = new SqlCommand(checkSql, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@Username", username.Trim());
                        int count = (int)checkCmd.ExecuteScalar();
                        if (count > 0)
                        {
                            errorMessage = "Username is already taken. Please choose another.";
                            return false;
                        }
                    }

                    // Check if email already exists
                    string checkEmailSql = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                    using (SqlCommand checkEmailCmd = new SqlCommand(checkEmailSql, conn))
                    {
                        checkEmailCmd.Parameters.AddWithValue("@Email", email.Trim());
                        int count = (int)checkEmailCmd.ExecuteScalar();
                        if (count > 0)
                        {
                            errorMessage = "Email address is already registered.";
                            return false;
                        }
                    }

                    // Insert new user
                    InsertUserDirect(conn, username.Trim(), password, fullName.Trim(), email.Trim(), mobile?.Trim(), safeRole);
                    return true;
                }
            }
            catch (Exception ex)
            {
                errorMessage = "Database error: " + ex.Message;
                return false;
            }
        }

        // ==========================================
        // ADO.NET HELPER METHODS FOR DATA BINDING
        // ==========================================

        /// <summary>
        /// Executes a SELECT query with parameters and fills a DataTable.
        /// Ideal for binding to ASP.NET GridView controls.
        /// </summary>
        public static DataTable ExecuteDataTable(string query, SqlParameter[] parameters = null)
        {
            DataTable dt = new DataTable();
            try
            {
                using (SqlConnection conn = GetOpenConnection())
                {
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        if (parameters != null)
                        {
                            cmd.Parameters.AddRange(parameters);
                        }
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("ExecuteDataTable error: " + ex.Message);
            }
            return dt;
        }

        /// <summary>
        /// Executes an INSERT / UPDATE / DELETE statement with parameters.
        /// </summary>
        public static int ExecuteNonQuery(string query, SqlParameter[] parameters)
        {
            try
            {
                using (SqlConnection conn = GetOpenConnection())
                {
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        if (parameters != null)
                        {
                            cmd.Parameters.AddRange(parameters);
                        }
                        return cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("ExecuteNonQuery error: " + ex.Message);
                return -1;
            }
        }
    }
}
