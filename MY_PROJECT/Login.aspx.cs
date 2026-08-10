using System;
using System.Web;
using System.Web.UI;

namespace MY_PROJECT
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // 1. Check if user is already logged in via Session
                if (Session["Username"] != null)
                {
                    Response.Redirect("Dashboard.aspx");
                    return;
                }

                // 2. Check if Cookie exists to auto-fill username or auto-login
                HttpCookie userCookie = Request.Cookies["UserLoginCookie"];
                if (userCookie != null && !string.IsNullOrEmpty(userCookie["Username"]))
                {
                    txtUsername.Text = userCookie["Username"];
                    ShowInfo("Cookie found! Found saved login details for user: " + userCookie["Username"]);
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string usernameOrEmail = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrEmpty(usernameOrEmail) || string.IsNullOrEmpty(password))
            {
                ShowError("Please enter both username/email and password.");
                return;
            }

            // Validate against SQL Server Database
            UserModel user = DbHelper.ValidateUser(usernameOrEmail, password);

            if (user == null)
            {
                ShowError("Invalid Username/Email or Password! (Try default admin / 123 or register a new user)");
                return;
            }

            // --- 1. SET BACKEND SESSION VALUES ---
            Session["Username"] = user.Username;
            Session["FullName"] = user.FullName;
            Session["Email"] = user.Email;
            Session["Gender"] = user.Gender;
            Session["LoggedInAt"] = DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss tt");

            // --- 2. SET OR REMOVE HTTP COOKIE VALUES ---
            if (chkRememberMe.Checked)
            {
                HttpCookie cookie = new HttpCookie("UserLoginCookie");
                cookie["Username"] = user.Username;
                cookie["FullName"] = user.FullName;
                cookie["Email"] = user.Email;
                cookie["Gender"] = user.Gender;
                cookie.Expires = DateTime.Now.AddDays(7); // Persists for 7 days
                Response.Cookies.Add(cookie);
            }
            else
            {
                // Expire cookie if user unchecked "Remember Me"
                if (Request.Cookies["UserLoginCookie"] != null)
                {
                    HttpCookie cookie = new HttpCookie("UserLoginCookie");
                    cookie.Expires = DateTime.Now.AddDays(-1);
                    Response.Cookies.Add(cookie);
                }
            }

            // Redirect to Dashboard page
            Response.Redirect("Dashboard.aspx");
        }

        private void ShowError(string message)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = "alert-custom alert-danger-custom d-block";
            lblMessage.Visible = true;
        }

        private void ShowInfo(string message)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = "alert-custom alert-info-custom d-block";
            lblMessage.Visible = true;
        }
    }
}
