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
    public partial class A_Dashboard : System.Web.UI.Page
    {

        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("A_Login.aspx");
            }
        }

        protected void btnAddCompany_Click(object sender, EventArgs e)
        {
            Response.Redirect("../addcompany.aspx");
        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            Response.Redirect("../addproduct.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("A_Login.aspx");
        }
    }
}