using System;
using System.Web.UI;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;


namespace MY_PROJECT
{
    public partial class shop_cart : Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        int uid;
        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            

            if (!IsPostBack)
            {
               // uid = Convert.ToInt32(Session["uid"]);
                Fillcartdatalist();
               // Label3.Text = "Welcome, " + Session["admin"].ToString();
            }
        }
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }
        void Fillcartdatalist()
        {
            getcon();
            da = new SqlDataAdapter("Select p.Prod_Id, p.Prod_Name, p.Prod_Price, p.Prod_Image, c.Cart_Qua, c.Cart_Id from Add_Products p INNER JOIN Cart_tbl c on p.Prod_Id = c.Cart_Prod_Id where Cart_User_Id = '" + uid + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }
    }
}
