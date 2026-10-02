using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MY_PROJECT
{
    public partial class shop : Page
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
                fillProducts();
            }

        }
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
        {

            if (e.CommandName == "cmd_dtl")
            {
                int pid = Convert.ToInt32(e.CommandArgument);
                ViewState["pid"] = pid;
                Response.Redirect("product-details.aspx?pid=" + ViewState["pid"]);
            }
            else
            {
                int Prod_Id = Convert.ToInt32(e.CommandArgument);
                int uid = Convert.ToInt32(Session["uid"]);
                ViewState["prdid"] = Prod_Id;
                getcon();
                int qua = 1;
                cmd = new SqlCommand("insert into Cart_tbl (Cart_User_Id, Cart_Prod_Id,Cart_Qua,Add_Date_Time) values('" + uid + "', '" + ViewState["prdid"] + "', '" + qua + "', Getdate())", con);
                cmd.ExecuteNonQuery();
            }


        }

        void fillProducts()
        {
            getcon();

            da = new SqlDataAdapter("select Prod_Id, Prod_Name, Prod_Price, Prod_Size, Prod_Color, Prod_Image from Add_Products", con);
            ds = new DataSet();
            da.Fill(ds);
            DataList1.DataSource = ds;
            DataList1.DataBind();


        }

    }



}
