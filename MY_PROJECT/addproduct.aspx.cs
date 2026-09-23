using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MY_PROJECT
{
    public partial class addproduct : System.Web.UI.Page
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
                fillCombo();
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void clear()
        {
            txtProductName.Text = string.Empty;
            txtProductCategory.Text = string.Empty;
            txtProductprice.Text = string.Empty;
            txtProductsize.Text = string.Empty;
            txtProductcolor.Text = string.Empty;
        }

        void fileUpload()
        {
            fnm = "prod_img/" + fileProductImage.FileName;
            fileProductImage.SaveAs(Server.MapPath(fnm));
        }

        void fillCombo()
        {
            getcon();
            da = new SqlDataAdapter("Select * from Add_Company", con);
            ds = new DataSet();
            da.Fill(ds);

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                ddlCompanyName.Items.Add(ds.Tables[0].Rows[i]["Comp_Name"].ToString());
            }
        }
        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            getcon();
            fileUpload();
            da = new SqlDataAdapter("select * from Add_Company where Comp_Name='" + ddlCompanyName.SelectedItem + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            int cid = Convert.ToInt16(ds.Tables[0].Rows[0][0]);
            ViewState["cid"] = cid;
            cmd = new SqlCommand("insert into Add_Products(Prod_Comp_Id,Prod_Name,Prod_Category,Prod_Price,Prod_Size,Prod_Color,Prod_Image) values('" + ViewState["cid"] + "','" + txtProductName.Text + "','" + txtProductCategory.Text + "','" + txtProductprice.Text + "','" + txtProductsize.Text + "','" + txtProductcolor.Text + "','" + fnm + "')", con);
            cmd.ExecuteNonQuery();
            Response.Write("<script>alert('Product Added Successfully')</script>");
            clear();
        }
    }
}
