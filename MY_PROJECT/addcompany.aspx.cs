using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MY_PROJECT
{
    public partial class addcompany : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;
        string fnm, nm;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }


        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void filUpload()
        {
            fnm = "comp_img/" + fileCoverPhoto.FileName;
            fileCoverPhoto.SaveAs(Server.MapPath(fnm));
        }
        protected void btnAddCompany_Click(object sender, EventArgs e)
        {
            getcon();
            filUpload();
            cmd = new SqlCommand("insert into Add_Company(Comp_Name,Comp_Owner_Name,Comp_Email,Comp_Address,Comp_Cover_Img)values('" + txtCompanyName.Text + "','" + txtCompanyOwnerName.Text + "','" + txtCompanyEmail.Text + "','" + txtCompanyAddress.Text + "','" + fnm + "')", con);
            cmd.ExecuteNonQuery();
            clear();
            Response.Write("<script>alert('Company Added Successfully')</script>");
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
           
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Show_company.aspx");
        }

        protected void ImageButton1_Click1(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Show_company.aspx");
        }

        void clear()
        {
            txtCompanyName.Text = string.Empty;
            txtCompanyOwnerName.Text = string.Empty;
            txtCompanyEmail.Text = string.Empty;
            txtCompanyAddress.Text = string.Empty;

        }
    }
}
