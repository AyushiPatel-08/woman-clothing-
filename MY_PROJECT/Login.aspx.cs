using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace MY_PROJECT
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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

            try
            {
                string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;
                SqlConnection con = new SqlConnection(s);
                con.Open();

                string sql = "SELECT COUNT(*) FROM Users WHERE (Username = @Input OR Email = @Input) AND Password = @Password";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Input", usernameOrEmail);
                cmd.Parameters.AddWithValue("@Password", password);

                int count = Convert.ToInt32(cmd.ExecuteScalar());
                con.Close();

                if (count > 0)
                {
                    Response.Redirect("Dashboard.aspx");
                }
                else
                {
                    ShowError("Invalid Username/Email or Password!");
                }
            }
            catch (Exception ex)
            {
                ShowError("Database Error: " + ex.Message);
            }
        }

        private void ShowError(string message)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = "alert-custom alert-danger-custom d-block";
            lblMessage.Visible = true;
        }
    }
}
