using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;


namespace MY_PROJECT
{
    public partial class Dashboard : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["admin"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                filldata();
            }

            void getcon()
            {
                string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;
                con = new SqlConnection(s);
                con.Open();
            }


            void filldata()
            {
                getcon();

                da = new SqlDataAdapter(
                    "select * from [User] where Email='" + Session["admin"] + "' or UserName='" + Session["admin"] + "'",
                    con);

                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    lblWelcomeName.Text = ds.Tables[0].Rows[0][1].ToString();
                    lblFullName.Text = ds.Tables[0].Rows[0][1].ToString();
                    lblUsername.Text = ds.Tables[0].Rows[0][2].ToString();
                    lblGender.Text = ds.Tables[0].Rows[0][3].ToString();
                    lblEmail.Text = ds.Tables[0].Rows[0][4].ToString();

                 
                }
            }

        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            Response.Redirect("Login.aspx");
        }
    }
}
