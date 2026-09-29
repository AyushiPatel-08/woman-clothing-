using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace MY_PROJECT
{
    public partial class Login : System.Web.UI.Page
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
                cmd = new SqlCommand("select count(*) from [User] where UserName= '" + txtUsername.Text + "' and password='" + txtPassword.Text + "'", con);
                //cmd.ExecuteNonQuery();
                int i = Convert.ToInt32(cmd.ExecuteScalar());


                if (i > 0)
                {
                    Session["admin"] = txtUsername.Text;
                    Response.Redirect("index.aspx");
                }
                else
                {
                    Response.Write("Invalid Email or Password");
                }
            }

        }
    }
}
