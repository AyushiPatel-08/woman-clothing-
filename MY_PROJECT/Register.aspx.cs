using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace MY_PROJECT
{
    public partial class Register : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string fnm;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                fillgrid();
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void imgupload()
        {
            fnm = "images/" + FileUpload1.FileName;
            FileUpload1.SaveAs(Server.MapPath(fnm));
        }

        void clear()
        {
            txtnm.Text = "";
            rdbgen.SelectedIndex = -1;
            txteml.Text = "";
            ddpct.SelectedIndex = -1;
            txtadd.Text = "";
            txtmbl.Text = "";
        }

        void fillgrid()
        {
            getcon();
            da = new SqlDataAdapter("Select * from emp_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
            con.Close();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Button1.Text == "Save")
            {
                getcon();
                imgupload();
                cmd = new SqlCommand("insert into emp_tbl (Name, Gender, Email, City, Address, Mobile, Image) values (@1, @2, @3, @4, @5, @6, @7)", con);
                cmd.Parameters.AddWithValue("@1", txtnm.Text);
                cmd.Parameters.AddWithValue("@2", rdbgen.SelectedValue);
                cmd.Parameters.AddWithValue("@3", txteml.Text);
                cmd.Parameters.AddWithValue("@4", ddpct.SelectedValue);
                cmd.Parameters.AddWithValue("@5", txtadd.Text);
                cmd.Parameters.AddWithValue("@6", txtmbl.Text);
                cmd.Parameters.AddWithValue("@7", fnm);
                cmd.ExecuteNonQuery();
                clear();
                fillgrid();
                con.Close();
                ShowSuccess("Record saved successfully!");
            }
        }

        private void ShowError(string message)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = "alert-custom alert-danger-custom d-block";
            lblMessage.Visible = true;
        }

        private void ShowSuccess(string message)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = "alert-custom alert-success-custom d-block";
            lblMessage.Visible = true;
        }
    }
}
