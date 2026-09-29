using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MY_PROJECT
{
    public partial class Register : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string fnm;

        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();

            fillgrid();

        }

        void getcon()
        {
            string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;
            con = new SqlConnection(s);
            con.Open();
        }

        void imgUpload()
        {
            fnm = "images/" + FileUpload1.FileName;
            FileUpload1.SaveAs(Server.MapPath(fnm));
        }

        void clear()
        {
            txtnm.Text = "";
            txtuname.Text = "";
            rdbgen.SelectedIndex = -1;
            txteml.Text = "";
            ddpct.SelectedIndex = -1;
            txtadd.Text = "";
            txtmbl.Text = "";
            TextBox1.Text = "";
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //insert
            if (Button1.Text == "Save")
            {
                getcon();
                imgUpload();
                cmd = new SqlCommand("insert into [User] (FullName,UserName,Gender,Email,City,Address,Mobile,Image,PassWord) Values ('" + txtnm.Text + "','" + txtuname.Text + "','" + rdbgen.SelectedValue + "','" + txteml.Text + "','" + ddpct.SelectedValue + "','" + txtadd.Text + "','" + txtmbl.Text + "','" + fnm + "','" + TextBox1.Text + "')", con);
                cmd.ExecuteNonQuery();
                con.Close();
                clear();
            }

            //update
            else
            {
                getcon();
                cmd = new SqlCommand("update [User] set FullName = '" + txtnm.Text + "',UserName='" + txtuname.Text + "',Gender='" + rdbgen.SelectedValue + "',Email='" + txteml.Text + "',City='" + ddpct.SelectedValue + "',Address='" + txtadd.Text + "',Mobile='" + txtmbl.Text + "', PassWord='" + TextBox1.Text + "' where Id = '" + ViewState["Id"] + "'", con);
                cmd.ExecuteNonQuery();
                fillgrid();
                clear();
                Button1.Text = "Save";
            }
        }

        void fillgrid()
        {
            getcon();
            da = new SqlDataAdapter("select * from [User]", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        void filldata()//paring
        {
            getcon();
            da = new SqlDataAdapter("select * from [User] where Id='" + ViewState["Id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            //paring
            // Parsing

            txtnm.Text = ds.Tables[0].Rows[0][1].ToString(); // FullName
            txtuname.Text = ds.Tables[0].Rows[0][2].ToString(); // UserName

            // Gender
            if (ds.Tables[0].Rows[0][3].ToString() == "Male")
            {
                rdbgen.SelectedValue = "Male";
            }
            else
            {
                rdbgen.SelectedValue = "Female";
            }

            txteml.Text = ds.Tables[0].Rows[0][4].ToString(); // Email
            ddpct.SelectedValue = ds.Tables[0].Rows[0][5].ToString(); // City
            txtadd.Text = ds.Tables[0].Rows[0][6].ToString(); // Address
            txtmbl.Text = ds.Tables[0].Rows[0][7].ToString(); // Mobile
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "edit_btn")
            {
                int id = Convert.ToInt16(e.CommandArgument);
                ViewState["Id"] = id;
                Button1.Text = "Update";
                filldata();
            }
            else 
            {
                getcon();
                cmd = new SqlCommand(" delete from [User] where Id='" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                fillgrid();
            }
        }
    }
}


