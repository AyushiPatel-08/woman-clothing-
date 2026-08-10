using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace MY_PROJECT
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblWelcomeName.Text = "User";
                lblFullName.Text = "User";
                lblUsername.Text = "";
                lblEmail.Text = "";
                lblGender.Text = "";

                // Load emp_tbl data into GridView
                try
                {
                    string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;
                    SqlConnection con = new SqlConnection(s);
                    con.Open();

                    SqlDataAdapter da = new SqlDataAdapter("Select * from emp_tbl", con);
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    gvUserProfile.DataSource = ds;
                    gvUserProfile.DataBind();
                    con.Close();
                }
                catch (Exception)
                {
                    // Database not available
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}
