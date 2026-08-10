//using System;
//using System.Web;
//using System.Web.UI;

using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;

namespace MY_PROJECT
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // If user is already logged in via Session or Cookie, redirect to Dashboard
                if (Session["Username"] != null || Request.Cookies["UserLoginCookie"] != null)
                {
                    Response.Redirect("Dashboard.aspx");
                }
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string username = txtUsername.Text.Trim();
            string email = txtEmail.Text.Trim();
            string gender = ddlGender.SelectedValue;
            string password = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

            // Input Validation
            if (string.IsNullOrEmpty(fullName) || string.IsNullOrEmpty(username) ||
                string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                ShowError("All required fields must be filled!");
                return;
            }

            if (password != confirmPassword)
            {
                ShowError("Passwords do not match! Please check and try again.");
                return;
            }

            // Create User Object
            UserModel newUser = new UserModel
            {
                FullName = fullName,
                Username = username,
                Email = email,
                Gender = gender,
                Password = password,
                RegisteredAt = DateTime.Now
            };

            // Save to SQL Database Server
            try
            {
                string s = ConfigurationManager
                    .ConnectionStrings["con"]
                    .ConnectionString;

                SqlConnection con = new SqlConnection(s);
                con.Open();

                string checkQuery = "SELECT COUNT(*) FROM Users WHERE Username = @Username";

                SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                checkCmd.Parameters.AddWithValue("@Username", username);

                int count = Convert.ToInt32(checkCmd.ExecuteScalar());

                if (count > 0)
                {
                    ShowError("Username already exists!");
                    con.Close();
                    return;
                }

                string query = @"INSERT INTO Users
                    (FullName, Username, Email, Gender, Password)
                    VALUES
                    (@FullName, @Username, @Email, @Gender, @Password)";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@FullName", fullName);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Gender", gender);
                cmd.Parameters.AddWithValue("@Password", password);

                cmd.ExecuteNonQuery();

                con.Close();
            }
            catch (Exception ex)
            {
                ShowError("Database Error: " + ex.Message);
                return;
            }

            // --- 1. SET BACKEND SESSION VALUES ---
            Session["Username"] = newUser.Username;
            Session["FullName"] = newUser.FullName;
            Session["Email"] = newUser.Email;
            Session["Gender"] = newUser.Gender;
            Session["LoggedInAt"] = DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss tt");

            // --- 2. SET HTTP COOKIE VALUES ---
            HttpCookie userCookie = new HttpCookie("UserLoginCookie");
            userCookie["Username"] = newUser.Username;
            userCookie["FullName"] = newUser.FullName;
            userCookie["Email"] = newUser.Email;
            userCookie["Gender"] = newUser.Gender;
            userCookie.Expires = DateTime.Now.AddDays(7); // Cookie persists for 7 days
            Response.Cookies.Add(userCookie);

            // Redirect to User Dashboard
            Response.Redirect("Dashboard.aspx");
        }

        private void ShowError(string message)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = "alert-custom alert-danger-custom d-block";
            lblMessage.Visible = true;
        }

        private void ShowSuccess(string message)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = "alert-custom alert-success-custom d-block";
            lblMessage.Visible = true;
        }
    }
}
