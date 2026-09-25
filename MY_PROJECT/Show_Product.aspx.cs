using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace MY_PROJECT
{
    public partial class Show_Product : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;
        string fnm, nm;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Filldatalist();
            }
            //if (Session["admin"] == null)
            //{
            //    Response.Redirect("A_Login.aspx");
            //}


            //if (!IsPostBack)
            //{
            //    Filldatalist();
            //    Label3.Text = "Welcome, " + Session["admin"].ToString();
            //}
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void Filldatalist()
        {
            getcon();
            
            da = new SqlDataAdapter("Select * from Add_Products Where Prod_Comp_Id ='" + Request.QueryString["cid"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            DataList1.DataSource = ds;
            DataList1.DataBind();
        }
    }
}