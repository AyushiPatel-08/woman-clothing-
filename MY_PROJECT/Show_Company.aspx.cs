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
    public partial class Show_Company : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;
        string fnm, nm;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            Filldatalist();

        }
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
        {
            {
                if (e.CommandName == "comp_name")
                {
                    int id = Convert.ToInt32(e.CommandArgument);
                    ViewState["cid"] = id;
                    Response.Redirect("Show_Product.aspx?cid=" + ViewState["cid"]);
                }
            }
        }

        void Filldatalist()
        {
            getcon();

            da = new SqlDataAdapter("Select * From Add_Company", con);
            ds = new DataSet();
            da.Fill(ds);
            DataList1.DataSource = ds;
            DataList1.DataBind();
        }
    }
}