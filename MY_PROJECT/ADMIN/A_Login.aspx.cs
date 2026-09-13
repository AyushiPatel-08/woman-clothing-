using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;



namespace MY_PROJECT.ADMIN
{
    public partial class A_Login : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] != null)
            {
                Response.Redirect("//");
            }
        }

        void getcon()
        {
            string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;
            con = new SqlConnection(s);
            con.Open();
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!(string.IsNullOrEmpty(txtUsername.Text)) && !(string.IsNullOrEmpty(txtPassword.Text)))
                getcon();
            {
                cmd = new SqlCommand("select count(*) from Admin where Email= '" + txtUsername.Text + "' and password='" + txtPassword.Text + "'", con);
                
                int i = Convert.ToInt32(cmd.ExecuteScalar());


                if (i > 0)
                {
                    Session["admin"] = txtUsername.Text;
                    Response.Redirect("A_Dashboard.aspx");
                }
                else
                {
                    Response.Write("Invalid Email or Password");
                }
            }
        }
    }
}