using System;
using System.Data;
using System.Web;
using System.Web.UI;

namespace MY_PROJECT
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string username = Convert.ToString(Session["Username"]);
                string fullName = Convert.ToString(Session["FullName"]);
                string email = Convert.ToString(Session["Email"]);
                string gender = Convert.ToString(Session["Gender"]);

                // If Session is empty, check Cookie recovery
                if (string.IsNullOrEmpty(username))
                {
                    HttpCookie userCookie = Request.Cookies["UserLoginCookie"];
                    if (userCookie != null && !string.IsNullOrEmpty(userCookie["Username"]))
                    {
                        username = userCookie["Username"];
                        fullName = userCookie["FullName"];
                        email = userCookie["Email"];
                        gender = userCookie["Gender"];

                        Session["Username"] = username;
                        Session["FullName"] = fullName;
                        Session["Email"] = email;
                        Session["Gender"] = gender;
                    }
                    else
                    {
                        // Redirect to Login if no valid session or cookie
                        Response.Redirect("Login.aspx");
                        return;
                    }
                }

                // Populate Welcome and Profile Labels
                lblWelcomeName.Text = !string.IsNullOrEmpty(fullName) ? fullName : username;
                lblFullName.Text = !string.IsNullOrEmpty(fullName) ? fullName : username;
                lblUsername.Text = username;
                lblEmail.Text = !string.IsNullOrEmpty(email) ? email : "N/A";
                lblGender.Text = !string.IsNullOrEmpty(gender) ? gender : "Male";

                // Populate GridView from SQL Database
                DataTable dtUser = DbHelper.GetUserDataTableByUsername(username);

                if (dtUser == null || dtUser.Rows.Count == 0)
                {
                    dtUser = new DataTable();
                    dtUser.Columns.Add("Full Name");
                    dtUser.Columns.Add("Username");
                    dtUser.Columns.Add("Email Address");
                    dtUser.Columns.Add("Gender");

                    dtUser.Rows.Add(
                        lblFullName.Text,
                        lblUsername.Text,
                        lblEmail.Text,
                        lblGender.Text
                    );
                }

                gvUserProfile.DataSource = dtUser;
                gvUserProfile.DataBind();
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear Session
            Session.Clear();
            Session.Abandon();

            // Expire Cookie
            if (Request.Cookies["UserLoginCookie"] != null)
            {
                HttpCookie cookie = new HttpCookie("UserLoginCookie");
                cookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(cookie);
            }

            // Redirect to Login Page
            Response.Redirect("Login.aspx");
        }
    }
}
