using System;
using System.Web.UI;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;


namespace MY_PROJECT
{
    public partial class product_details : Page
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

        }
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void Filldatalist()
        {
            getcon();
            da = new SqlDataAdapter("Select * From Add_Products where Prod_Id='" + Request.QueryString["pid"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            DataList1.DataSource = ds;
            DataList1.DataBind();
        }
    }
}
