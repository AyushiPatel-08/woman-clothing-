using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace MY_PROJECT
{
    public static class DbHelper
    {
        private static string GetRegistrationConnString()
        {
            if (ConfigurationManager.ConnectionStrings["RegistrationDbConn"] != null)
            {
                return ConfigurationManager.ConnectionStrings["RegistrationDbConn"].ConnectionString;
            }
            return @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=REGISTRATION_DB;Integrated Security=True;";
        }

        private static string GetLoginConnString()
        {
            if (ConfigurationManager.ConnectionStrings["LoginDbConn"] != null)
            {
                return ConfigurationManager.ConnectionStrings["LoginDbConn"].ConnectionString;
            }
            return @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=LOGIN_DB;Integrated Security=True;";
        }

        public static bool RegisterUser(UserModel newUser, out string errorMessage)
        {
            errorMessage = string.Empty;
            string regConnStr = GetRegistrationConnString();
            string loginConnStr = GetLoginConnString();

            try
            {
                // 1. Save into REGISTRATION_DB
                using (SqlConnection conn = new SqlConnection(regConnStr))
                {
                    conn.Open();

                    string checkUserSql = "SELECT COUNT(*) FROM Users WHERE Username = @Username";
                    using (SqlCommand checkCmd = new SqlCommand(checkUserSql, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@Username", newUser.Username);
                        if ((int)checkCmd.ExecuteScalar() > 0)
                        {
                            errorMessage = "Username already exists in REGISTRATION_DB!";
                            return false;
                        }
                    }

                    string insertSql = @"INSERT INTO Users (FullName, Username, Email, Gender, Password, RegisteredAt) 
                                         VALUES (@FullName, @Username, @Email, @Gender, @Password, @RegisteredAt)";
                    using (SqlCommand insertCmd = new SqlCommand(insertSql, conn))
                    {
                        insertCmd.Parameters.AddWithValue("@FullName", newUser.FullName);
                        insertCmd.Parameters.AddWithValue("@Username", newUser.Username);
                        insertCmd.Parameters.AddWithValue("@Email", newUser.Email);
                        insertCmd.Parameters.AddWithValue("@Gender", (object)newUser.Gender ?? DBNull.Value);
                        insertCmd.Parameters.AddWithValue("@Password", newUser.Password);
                        insertCmd.Parameters.AddWithValue("@RegisteredAt", DateTime.Now);

                        insertCmd.ExecuteNonQuery();
                    }
                }

                // 2. Sync to LOGIN_DB
                try
                {
                    using (SqlConnection conn2 = new SqlConnection(loginConnStr))
                    {
                        conn2.Open();
                        string syncSql = @"IF NOT EXISTS (SELECT 1 FROM Users WHERE Username = @Username)
                                           BEGIN
                                               INSERT INTO Users (FullName, Username, Email, Gender, Password, RegisteredAt) 
                                               VALUES (@FullName, @Username, @Email, @Gender, @Password, @RegisteredAt)
                                           END";
                        using (SqlCommand syncCmd = new SqlCommand(syncSql, conn2))
                        {
                            syncCmd.Parameters.AddWithValue("@FullName", newUser.FullName);
                            syncCmd.Parameters.AddWithValue("@Username", newUser.Username);
                            syncCmd.Parameters.AddWithValue("@Email", newUser.Email);
                            syncCmd.Parameters.AddWithValue("@Gender", (object)newUser.Gender ?? DBNull.Value);
                            syncCmd.Parameters.AddWithValue("@Password", newUser.Password);
                            syncCmd.Parameters.AddWithValue("@RegisteredAt", DateTime.Now);

                            syncCmd.ExecuteNonQuery();
                        }
                    }
                }
                catch (Exception)
                {
                    // Ignore sync exception if already exists in LOGIN_DB
                }

                return true;
            }
            catch (Exception ex)
            {
                errorMessage = "Database Error: " + ex.Message;
                return false;
            }
        }

        public static UserModel ValidateUser(string usernameOrEmail, string password)
        {
            string loginConnStr = GetLoginConnString();

            try
            {
                using (SqlConnection conn = new SqlConnection(loginConnStr))
                {
                    conn.Open();
                    string sql = @"SELECT TOP 1 FullName, Username, Email, Gender, Password, RegisteredAt 
                                   FROM Users 
                                   WHERE (Username = @Input OR Email = @Input) AND Password = @Password";

                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@Input", usernameOrEmail);
                        cmd.Parameters.AddWithValue("@Password", password);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                return new UserModel
                                {
                                    FullName = reader["FullName"].ToString(),
                                    Username = reader["Username"].ToString(),
                                    Email = reader["Email"].ToString(),
                                    Gender = reader["Gender"] != DBNull.Value ? reader["Gender"].ToString() : "N/A",
                                    Password = reader["Password"].ToString(),
                                    RegisteredAt = Convert.ToDateTime(reader["RegisteredAt"])
                                };
                            }
                        }
                    }
                }
            }
            catch (Exception)
            {
                // Fallback to in-memory store
                return UserStore.ValidateUser(usernameOrEmail, password);
            }

            return null;
        }

        public static DataTable GetUserDataTableByUsername(string username)
        {
            DataTable dt = new DataTable();
            string regConnStr = GetRegistrationConnString();

            try
            {
                using (SqlConnection conn = new SqlConnection(regConnStr))
                {
                    conn.Open();
                    string sql = @"SELECT FullName AS [Full Name], 
                                          Username AS [Username], 
                                          Email AS [Email Address], 
                                          ISNULL(Gender, 'N/A') AS [Gender], 
                                          RegisteredAt AS [Registration Date] 
                                   FROM Users 
                                   WHERE Username = @Username";

                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }
                    }
                }
            }
            catch (Exception)
            {
                dt.Columns.Add("Full Name");
                dt.Columns.Add("Username");
                dt.Columns.Add("Email Address");
                dt.Columns.Add("Gender");
                dt.Columns.Add("Registration Date");
            }

            return dt;
        }
    }
}
